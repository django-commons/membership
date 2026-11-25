"""Tests for build_site_projects.py. Run with `just test`."""

from __future__ import annotations

import json
import os
import subprocess
from pathlib import Path

import pytest

import build_site_projects as bsp

ORG_REPO = """\
  "membership" = {
    description            = "Org repo."
    is_django_commons_repo = true
  }
"""


def project(name: str, description: str) -> str:
    return f'  "{name}" = {{\n    description = "{description}"\n    topics = []\n  }}\n'


def tfvars(*blocks: str) -> str:
    return "repositories = {\n" + "\n".join(blocks) + "}\n"


class Repo:
    """A throwaway git repository holding only the tfvars file."""

    def __init__(self, root: Path):
        self.root = root
        (root / "terraform").mkdir()
        (root / "django-commons.org/data").mkdir(parents=True)
        self.git("init", "-q", "-b", "main")

    def git(self, *args: str, date: str = "2026-01-01") -> str:
        stamp = f"{date}T12:00:00+00:00"
        env = {
            **os.environ,
            "GIT_AUTHOR_NAME": "Test",
            "GIT_AUTHOR_EMAIL": "test@example.com",
            "GIT_COMMITTER_NAME": "Test",
            "GIT_COMMITTER_EMAIL": "test@example.com",
            "GIT_AUTHOR_DATE": stamp,
            "GIT_COMMITTER_DATE": stamp,
        }
        result = subprocess.run(
            ["git", *args], cwd=self.root, env=env, capture_output=True, text=True, check=True
        )
        return result.stdout

    def commit(self, content: str, date: str) -> None:
        (self.root / bsp.TFVARS).write_text(content)
        self.git("add", bsp.TFVARS)
        self.git("commit", "-q", "-m", f"Update {date}", date=date)


@pytest.fixture(scope="module")
def history(tmp_path_factory) -> Path:
    """Three onboarding commits on main plus one project added through a merge."""
    repo = Repo(tmp_path_factory.mktemp("history"))
    repo.commit(tfvars(ORG_REPO, project("django-old", "Old one.")), "2026-02-04")
    repo.commit(
        tfvars(ORG_REPO, project("django-old", "Old one."), project("django-mid", "Mid")),
        "2026-05-01",
    )
    repo.git("checkout", "-q", "-b", "onboard")
    repo.commit(
        tfvars(
            ORG_REPO,
            project("django-old", "Old one."),
            project("django-mid", "Mid"),
            project("django-merged", "Merged"),
        ),
        "2026-06-01",
    )
    repo.git("checkout", "-q", "main")
    repo.git("merge", "-q", "--no-ff", "-m", "Merge onboard", "onboard", date="2026-06-10")
    repo.commit(
        tfvars(
            ORG_REPO,
            project("django-old", "Old one, reworded."),
            project("django-mid", "Mid"),
            project("django-merged", "Merged"),
            project("django-new-a", "New a"),
            project("django-new-b", "New b"),
            project("best-practices", "Template"),
        ),
        "2026-11-18",
    )
    return repo.root


@pytest.fixture
def at_root(monkeypatch):
    """Point the script at a different repository root."""

    def use(root: Path) -> None:
        monkeypatch.setattr(bsp, "REPO_ROOT", root)
        monkeypatch.setattr(bsp, "OUTPUT", root / "django-commons.org/data/projects.json")

    return use


def test_parse_repositories():
    text = tfvars(
        ORG_REPO,
        '  "django-x" = {\n'
        '    description = "Says \\"hi\\""\n'
        "    admins = [\n"
        '      "someone",\n'
        "    ]\n"
        "    nested = {\n"
        '      description = "Not this one"\n'
        "    }\n"
        "  }\n",
    )
    assert bsp.parse_repositories(text) == {
        "membership": {"description": "Org repo.", "org_repo": True},
        "django-x": {"description": 'Says "hi"', "org_repo": False},
    }


@pytest.mark.parametrize(
    ("raw", "cleaned"),
    [
        ("simple tagging for django.", "Simple tagging for django"),
        ("Two sentences. Kept as is.", "Two sentences. Kept as is."),
        ("  extra\n   whitespace ", "Extra whitespace"),
        ("", ""),
    ],
)
def test_clean_description(raw, cleaned):
    assert bsp.clean_description(raw) == cleaned


def test_build_projects(history, at_root):
    """Newest first, same-commit projects in tfvars order, non-projects skipped."""
    at_root(history)
    assert bsp.build_projects() == [
        {"name": "django-new-a", "description": "New a", "joined": "2026-11-18"},
        {"name": "django-new-b", "description": "New b", "joined": "2026-11-18"},
        {"name": "django-merged", "description": "Merged", "joined": "2026-06-10"},
        {"name": "django-mid", "description": "Mid", "joined": "2026-05-01"},
        {"name": "django-old", "description": "Old one, reworded", "joined": "2026-02-04"},
    ]


def test_build_projects_without_history(tmp_path, at_root):
    """Outside a git repository the join dates are left out."""
    (tmp_path / "terraform").mkdir()
    (tmp_path / bsp.TFVARS).write_text(tfvars(project("django-x", "X")))
    at_root(tmp_path)
    assert bsp.build_projects() == [{"name": "django-x", "description": "X"}]


def test_main(history, at_root):
    at_root(history)
    try:
        assert bsp.main() == 0
        data = json.loads(bsp.OUTPUT.read_text())
    finally:
        bsp.OUTPUT.unlink(missing_ok=True)
    assert [p["name"] for p in data["projects"]][0] == "django-new-a"
