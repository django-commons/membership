"""Open the "Switch release and project information to Django Commons" issue in an
incoming project's origin repo and post the standard transfer comments.

Reads the origin repo URL from a membership INBOUND issue, then (via `gh api`):
  1. opens the switch-over issue in that repo,
  2. comments the release-flow walkthrough (referencing the issue from step 1),
  3. comments the PyPI-handle / scheduling note.

Usage:
    python scripts/transfer_issue.py <membership-issue-number> [--dry-run]

--dry-run prints each API endpoint and JSON payload instead of calling it.
"""

import argparse
import json
import re
import subprocess
import sys

MEMBERSHIP_REPO = "django-commons/membership"

ISSUE_TITLE = "Switch release and project information to Django Commons"

# Fill these in for whoever is running the script.
CAL_LINK = "cal.com"  # display text for the scheduling link
CAL_URL = "https://cal.com/ryancheley/django-commons-inbound-transfer"


def gh(args, payload=None):
    """Call the gh CLI. If payload is given, pipe it as JSON to `gh api --input -`."""
    result = subprocess.run(
        ["gh", *args],
        input=json.dumps(payload) if payload is not None else None,
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        print(result.stderr, file=sys.stderr)
        sys.exit(result.returncode)
    return result.stdout


def membership_issue_info(membership_issue):
    """Return (owner, repo, author) for the origin project named in a membership issue."""
    data = json.loads(
        gh(["issue", "view", str(membership_issue), "--repo", MEMBERSHIP_REPO, "--json", "body,author"])
    )
    match = re.search(r"https://github\.com/([A-Za-z0-9_.-]+)/([A-Za-z0-9_.-]+)", data["body"])
    if not match:
        print(f"No github.com project URL found in {MEMBERSHIP_REPO}#{membership_issue}", file=sys.stderr)
        sys.exit(1)
    return match.group(1), match.group(2).removesuffix(".git"), data["author"]["login"]


def issue_body(membership_issue):
    url = f"https://github.com/{MEMBERSHIP_REPO}/issues/{membership_issue}"
    return (
        f"Related to [{MEMBERSHIP_REPO}#{membership_issue}]({url})\n"
        " Don't merge this until the repo has been transferred to the Django Commons "
        "GitHub org and the PyPI org."
    )


def release_flow_comment(owner, repo, issue_number):
    ref = f"{owner}/{repo}#{issue_number}"
    return (
        f"Once the transfer is complete, we'll merge {ref} then I'll ask you to cut a "
        "release to get a feel for the new flow.\n\n"
        "The release process will be:\n\n"
        "1. Push commit with version change to GitHub\n"
        "2. Tag that commit with the new version number\n"
        "3. Push tag to GitHub\n"
        "4. [automated] GitHub will request an approval from the admins via email "
        "(you'll also find it under the Actions tab)\n"
        "5. The deployment review will be approved\n"
        "6. [automated] It'll be pushed to PyPI and a draft release on GitHub will be created\n"
        "7. Edit the release notes on GitHub release and publish\n\n"
        "We can tweak the above by editing the release.yml file to make it more "
        "streamlined if you'd like."
    )


PYPI_COMMENT = (
    "My PyPI handle is ryancheley. You should have permissions to move the repo into "
    "the Django Commons GitHub org since you're a member now. If you run into any "
    "issues or would like to do this in sync, you can schedule some time on my calendar "
    f"at [{CAL_LINK}]({CAL_URL})"
)


def post(endpoint, payload, dry_run):
    if dry_run:
        print(f"POST {endpoint}")
        print(json.dumps(payload, indent=2))
        print()
        return None
    return json.loads(gh(["api", "-X", "POST", endpoint, "--input", "-"], payload=payload))


def run(membership_issue, dry_run):
    owner, repo, author = membership_issue_info(membership_issue)
    mention = f"@{author} "

    created = post(
        f"/repos/{owner}/{repo}/issues",
        {"title": ISSUE_TITLE, "body": issue_body(membership_issue)},
        dry_run,
    )
    new_number = created["number"] if created else "<new-issue-number>"

    # Comments go on the membership issue, referencing the origin-repo issue we just opened.
    comments_endpoint = f"/repos/{MEMBERSHIP_REPO}/issues/{membership_issue}/comments"
    post(comments_endpoint, {"body": mention + release_flow_comment(owner, repo, new_number)}, dry_run)
    post(comments_endpoint, {"body": mention + PYPI_COMMENT}, dry_run)

    if not dry_run:
        print(f"Opened {owner}/{repo}#{new_number}: {created['html_url']}")


def _self_test():
    assert membership_issue_info.__doc__  # sanity
    body = "### URL\n\nhttps://github.com/jazzband/django-constance.git\nhttps://jazzband.co/x"
    m = re.search(r"https://github\.com/([A-Za-z0-9_.-]+)/([A-Za-z0-9_.-]+)", body)
    assert (m.group(1), m.group(2).removesuffix(".git")) == ("jazzband", "django-constance")
    assert "jazzband/django-constance#42" in release_flow_comment("jazzband", "django-constance", 42)
    assert "django-commons/membership#7]" in issue_body(7)
    print("self-test ok")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("membership_issue", nargs="?", help="membership INBOUND issue number")
    parser.add_argument("--dry-run", action="store_true", help="print endpoints + payloads only")
    parser.add_argument("--self-test", action="store_true", help=argparse.SUPPRESS)
    args = parser.parse_args()

    if args.self_test:
        _self_test()
    elif args.membership_issue:
        run(args.membership_issue, args.dry_run)
    else:
        parser.error("membership_issue is required")
