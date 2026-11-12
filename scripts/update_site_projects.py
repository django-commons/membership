#!/usr/bin/env python3
"""Add newly onboarded projects to the website's project list.

`terraform/repositories.tfvars` is the source of truth for the repositories in
the organization. Whenever a pull request adding a new project is merged, a new
top-level key shows up in that file. This script walks the commits in a range,
finds the repositories each commit introduced, and inserts them into
`django-commons.org/data/projects.yaml` (newest first) with `joined` set to the
date of the merge commit (UTC).

Only the standard library is used and the YAML file is edited as text, so the
header comments and the hand-curated entries are left untouched.

Usage:
    update_site_projects.py --before <sha> --after <sha> [--dry-run]
    update_site_projects.py --after <sha>        # just that one commit

Prints the names of the projects it added, one per line.
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
TFVARS = "terraform/repositories.tfvars"
PROJECTS_YAML = REPO_ROOT / "django-commons.org/data/projects.yaml"

# Repositories in the tfvars that are not member projects.
NON_PROJECTS = {"best-practices", "django-unicorn.com"}

ZERO_SHA = "0" * 40
KEY_RE = re.compile(r'^  "([^"]+)"\s*=\s*\{\s*$')
DESC_RE = re.compile(r'^\s*description\s*=\s*"((?:[^"\\]|\\.)*)"')
ORG_REPO_RE = re.compile(r"^\s*is_django_commons_repo\s*=\s*true\b")
ENTRY_RE = re.compile(r"^  - name:\s*(\S+)\s*$")
JOINED_RE = re.compile(r'^    joined:\s*"?(\d{4}-\d{2}-\d{2})"?\s*$')
PLAIN_SAFE_RE = re.compile(r"^[A-Za-z0-9][A-Za-z0-9 ,.()/'_-]*$")


def git(*args: str, check: bool = True) -> str:
    result = subprocess.run(
        ["git", *args], cwd=REPO_ROOT, capture_output=True, text=True, check=False
    )
    if check and result.returncode != 0:
        raise SystemExit(f"git {' '.join(args)} failed: {result.stderr.strip()}")
    return result.stdout if result.returncode == 0 else ""


def parse_repositories(tfvars: str) -> dict[str, dict]:
    """Return {repo_name: {"description": str, "org_repo": bool}}.

    Repositories are the 2-space-indented `"name" = {` blocks of the top-level
    `repositories` map; their attributes sit at 4 spaces and the block ends at
    a line that is exactly `  }`.
    """
    repos: dict[str, dict] = {}
    current = None
    for line in tfvars.splitlines():
        if current is None:
            if match := KEY_RE.match(line):
                current = repos.setdefault(
                    match.group(1), {"description": "", "org_repo": False}
                )
            continue
        if line.rstrip() == "  }":
            current = None
        elif match := DESC_RE.match(line):
            if not current["description"]:
                current["description"] = json.loads(f'"{match.group(1)}"')
        elif ORG_REPO_RE.match(line):
            current["org_repo"] = True
    return repos


def added_projects(parent: str, commit: str) -> dict[str, str]:
    """Projects present in `commit`'s tfvars but not in `parent`'s."""
    old = parse_repositories(git("show", f"{parent}:{TFVARS}", check=False))
    new = parse_repositories(git("show", f"{commit}:{TFVARS}", check=False))
    return {
        name: info["description"]
        for name, info in new.items()
        if name not in old and not info["org_repo"] and name not in NON_PROJECTS
    }


def commit_date(commit: str) -> str:
    timestamp = int(git("show", "-s", "--format=%ct", commit).strip())
    return datetime.fromtimestamp(timestamp, tz=timezone.utc).strftime("%Y-%m-%d")


def clean_description(description: str) -> str:
    text = " ".join(description.split())
    if text and text[-1] == "." and text.count(".") == 1:
        text = text[:-1]
    return text[:1].upper() + text[1:]


def yaml_scalar(value: str) -> str:
    # JSON strings are valid YAML double-quoted scalars.
    return value if PLAIN_SAFE_RE.match(value) else json.dumps(value, ensure_ascii=False)


def render_entry(name: str, joined: str, description: str) -> list[str]:
    lines = [f"  - name: {name}", f'    joined: "{joined}"']
    if description:
        lines.append(f"    description: {yaml_scalar(clean_description(description))}")
    return lines


def insert_project(lines: list[str], name: str, joined: str, description: str) -> bool:
    """Insert into the (newest-first) list; False if already present."""
    entries = [(i, m.group(1)) for i, line in enumerate(lines) if (m := ENTRY_RE.match(line))]
    if any(existing == name for _, existing in entries):
        return False
    if not entries:
        raise SystemExit("No `- name:` entries found in projects.yaml")

    # Insert before the first entry that is not newer than this project. An
    # entry without a `joined` date counts as old.
    position = None
    for index, _ in entries:
        match = JOINED_RE.match(lines[index + 1]) if index + 1 < len(lines) else None
        if not match or match.group(1) <= joined:
            position = index
            break
    if position is None:  # older than everything: append after the last entry
        position = len(lines)
        while position > 0 and not lines[position - 1].strip():
            position -= 1
    lines[position:position] = render_entry(name, joined, description)
    return True


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("--before", help="Last commit already processed (exclusive)")
    parser.add_argument("--after", required=True, help="Last commit to process")
    parser.add_argument("--dry-run", action="store_true", help="Don't write the file")
    args = parser.parse_args()

    before = args.before if args.before and args.before != ZERO_SHA else None
    rev_range = f"{before}..{args.after}" if before else f"{args.after}^..{args.after}"
    commits = git("rev-list", "--first-parent", "--reverse", rev_range).split()

    lines = PROJECTS_YAML.read_text().splitlines()
    added: list[str] = []
    for commit in commits:
        parents = git("rev-list", "--parents", "-n", "1", commit).split()[1:]
        if not parents:
            continue
        for name, description in added_projects(parents[0], commit).items():
            if insert_project(lines, name, commit_date(commit), description):
                added.append(name)

    if added and not args.dry_run:
        PROJECTS_YAML.write_text("\n".join(lines) + "\n")
    print("\n".join(added))
    return 0


if __name__ == "__main__":
    sys.exit(main())
