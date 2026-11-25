#!/usr/bin/env python3
"""Write the site's project list to django-commons.org/data/projects.json to be
included on the website.

Projects come from terraform/repositories.tfvars.
"""

from __future__ import annotations

import json
import os
import re
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
TFVARS = "terraform/repositories.tfvars"
OUTPUT = REPO_ROOT / "django-commons.org/data/projects.json"

# Repositories in the tfvars that are not member projects and aren't marked
# with `is_django_commons_repo`.
NON_PROJECTS = {"best-practices", "django-unicorn.com"}

KEY_RE = re.compile(r'^  "([^"]+)"\s*=\s*\{\s*$')
ADDED_KEY_RE = re.compile(r'^\+  "([^"]+)"\s*=\s*\{\s*$')
DESC_RE = re.compile(r'^\s*description\s*=\s*"((?:[^"\\]|\\.)*)"')
ORG_REPO_RE = re.compile(r"^\s*is_django_commons_repo\s*=\s*true\b")
DATE_MARKER = ">>> "


def parse_repositories(tfvars: str) -> dict[str, dict]:
    """Return {repo_name: {"description": str, "org_repo": bool}} in file order.

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


def first_added() -> dict[str, tuple[int, str]]:
    """Map each repository to (commit index, date) of the commit that added it.

    Walks the tfvars history oldest first in a single `git log` call. A higher
    index means a later commit.
    """
    result = subprocess.run(
        [
            "git",
            "log",
            "--reverse",
            "--first-parent",
            f"--format={DATE_MARKER}%cd",
            "--date=format-local:%Y-%m-%d",
            "--unified=0",
            "-p",
            "--",
            TFVARS,
        ],
        cwd=REPO_ROOT,
        env={**os.environ, "TZ": "UTC"},
        capture_output=True,
        text=True,
        check=False,
    )
    if result.returncode != 0:
        print(f"git log failed, omitting join dates: {result.stderr.strip()}", file=sys.stderr)
        return {}

    added: dict[str, tuple[int, str]] = {}
    index, date = -1, ""
    for line in result.stdout.splitlines():
        if line.startswith(DATE_MARKER):
            index += 1
            date = line[len(DATE_MARKER) :].strip()
        elif match := ADDED_KEY_RE.match(line):
            added.setdefault(match.group(1), (index, date))
    return added


def clean_description(description: str) -> str:
    """Collapse whitespace, drop a lone trailing period and capitalize."""
    text = " ".join(description.split())
    if text.endswith(".") and text.count(".") == 1:
        text = text[:-1]
    return text[:1].upper() + text[1:]


def build_projects() -> list[dict]:
    repos = parse_repositories((REPO_ROOT / TFVARS).read_text())
    added = first_added()
    projects = []
    for position, (name, info) in enumerate(repos.items()):
        if info["org_repo"] or name in NON_PROJECTS:
            continue
        project = {"name": name, "description": clean_description(info["description"])}
        index, date = added.get(name, (-1, ""))
        if date:
            project["joined"] = date
        # Newest first; projects added in the same commit keep tfvars order.
        projects.append(((-index, position), project))
    return [project for _, project in sorted(projects, key=lambda item: item[0])]


def main() -> int:
    projects = build_projects()
    OUTPUT.write_text(json.dumps({"projects": projects}, indent=2) + "\n")
    print(f"Wrote {len(projects)} projects to {OUTPUT.relative_to(REPO_ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
