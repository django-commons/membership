#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.9"
# dependencies = ["html2text", "pyyaml"]
# ///
"""Convert Google Docs clipboard content to markdown, for pasting meeting
notes into docs/blog/posts/meetings/.

Usage:
    1. In the Google Doc, select the content and copy it (Ctrl+C / Cmd+C).
    2. Run (from the repo root):

       just notes-to-md 2026-09-16

       This reads your clipboard's HTML, pipes it through this script, writes
       docs/blog/posts/meetings/2026/2026-09-16-admins-meeting.md, and prints
       the result.

       See the justfile for the recipe.


Why: copying from Google Docs into a plain markdown file (or into Obsidian)
loses structure - nested bullets flatten and hyperlinked text loses its
link. This script reads the *HTML* version of what's on your clipboard
(which Google Docs always includes) and converts it properly, including
nesting depths beyond what mkdocs-material's markdown renderer would
otherwise silently flatten.
"""
import datetime
import re
import sys

import html2text
import yaml

# Fixed frontmatter fields for every admins meeting post.
BLOG_TITLE_TEMPLATE = "Admins Meeting Notes: {date}"
# The blog plugin builds each post's URL as {date}/{slug}, and the date
# segment is already unique per meeting, so a fixed slug keeps URLs from
# repeating the date twice (.../2026/09/16/admins-meeting/ instead of
# .../2026/09/16/admins-meeting-notes-2026-09-16/).
BLOG_SLUG = "admins-meeting"
BLOG_DESCRIPTION = "The public meeting notes from the Django Commons admin team."
BLOG_AUTHOR = "Django Commons Admins"
BLOG_CATEGORIES = ["Meeting Notes"]
BLOG_TAGS = ["admins"]

# Google Docs meeting notes use first names only; expand them for the
# frontmatter's attendees/apologies lists. Add new admins here as needed.
NAME_ALIASES = {
    "Ryan": "Ryan Cheley",
    "Tim": "Tim Schilling",
    "Storm": "Storm Heg",
    "Daniel": "Daniel Moran",
    "Tilda": "Tilda Udufo",
    "Brian": "Brian Kohan",
    "Daksh": "Daksh P. Jain",
}


class _IndentDumper(yaml.Dumper):
    """Indent list items under their key, matching the style used at
    https://github.com/django/steering-council/blob/main/meetings/2026/2026-09-07-steering-council-with-fellows.md
    """

    def increase_indent(self, flow=False, indentless=False):
        return super().increase_indent(flow, False)


class _DoubleQuoted(str):
    """A string that should render as a "double-quoted" YAML scalar."""


_IndentDumper.add_representer(
    _DoubleQuoted,
    lambda dumper, data: dumper.represent_scalar("tag:yaml.org,2002:str", str(data), style='"'),
)


def strip_checkbox_icons(html: str) -> str:
    """Remove Google Docs' checklist checkbox icon <img> tags.

    These are decorative UI chrome (a base64 checked/unchecked icon), not
    content. html2text usually drops them silently, but the <del>
    wrapping mark_completed_items() adds can throw off its block parsing
    enough that the icon leaks through as its own bogus list item
    instead. Stripping them outright avoids relying on that being
    silently swallowed.
    """
    return re.sub(r'<img[^>]*aria-roledescription="checkbox"[^>]*/?>', "", html)


def mark_completed_items(html: str) -> str:
    """Wrap checked-off Google Docs checklist items' text in <del>.

    Google Docs marks a checked item with `aria-checked="true"` and a
    `text-decoration:line-through` style, not real strikethrough markup,
    so html2text ignores it. <del> (which html2text renders as
    ~~text~~) makes completed action items show up struck through, the
    same convention used at
    https://github.com/django/steering-council/blob/main/meetings/2026/2026-09-07-steering-council-with-fellows.md

    Only the <span> text nodes are wrapped (not the whole <li>, which
    also contains the checkbox <img> and a block-level <p> - wrapping
    those in the inline <del> confuses html2text's block parsing).
    """
    def wrap_spans(li_match: re.Match) -> str:
        return re.sub(r"(<span[^>]*>)(.*?)(</span>)", r"\1<del>\2</del>\3", li_match.group(0))

    return re.sub(
        r'<li[^>]*aria-checked="true"[^>]*>.*?</li>',
        wrap_spans,
        html,
        flags=re.DOTALL,
    )


def strip_embedded_images(md: str) -> str:
    """Replace embedded (data: URI) images with a placeholder.

    A real pasted screenshot comes through as a `![](data:image/...)`
    with the whole image base64-encoded inline - hundreds of KB of
    noise in a meeting-notes markdown file. Flag it instead so it gets
    handled deliberately (e.g. saved as a real file and linked).
    """
    return re.sub(r"!\[[^\]]*\]\(data:[^)]+\)", "*(image omitted - add manually)*", md)


def strip_private_items(text: str) -> str:
    """Drop any list item tagged [private] (case-insensitive), along
    with its nested sub-items, so it never reaches the public notes.

    Must run after reindent_lists(), which normalizes nesting to a
    consistent 4-spaces-per-level so "nested under it" can be
    determined by indentation depth alone.
    """
    item_re = re.compile(r"^( *)-\s(.*)$")
    private_re = re.compile(r"\[private\]", re.IGNORECASE)

    out = []
    drop_indent = None  # while set, drop anything indented deeper than this
    for line in text.split("\n"):
        m = item_re.match(line)

        if drop_indent is not None:
            if line.strip() == "" or (m and len(m.group(1)) > drop_indent):
                continue
            drop_indent = None  # subtree ended; fall through and handle this line normally

        if m and private_re.search(m.group(2)):
            drop_indent = len(m.group(1))
            continue

        if not m and private_re.search(line):
            continue

        out.append(line)

    return "\n".join(out)


def tighten_lists(text: str) -> str:
    """Drop blank lines that sit between two list items.

    Google Docs wraps every bullet's text in its own <p>, so html2text
    treats each one as a separate paragraph and inserts a blank line
    after it. That's technically valid markdown (a "loose" list) but
    reads far sparser than the source doc. Blank lines that separate
    a list from surrounding headings/paragraphs are left alone.
    """
    item_re = re.compile(r"^\s*-\s")
    lines = text.split("\n")
    out = []
    for i, line in enumerate(lines):
        if line.strip() == "" and out and item_re.match(out[-1]):
            next_nonblank = next((l for l in lines[i + 1:] if l.strip() != ""), "")
            if item_re.match(next_nonblank):
                continue
        out.append(line)
    return "\n".join(out)


def reindent_lists(text: str, spaces_per_level: int = 4) -> str:
    """Re-indent nested markdown lists to 4 spaces/level.

    html2text emits 2 spaces/level, which mkdocs-material's markdown
    renderer (tab_length=4) silently flattens once nesting goes 4+
    levels deep - the list *looks* fine in the .md file but renders
    wrong on the site.
    """
    out = []
    for line in text.split("\n"):
        m = re.match(r"^( *)\* (.*)", line)
        if not m:
            out.append(line)
            continue
        leading, rest = m.groups()
        level = len(leading) // 2 or 1
        out.append(" " * ((level - 1) * spaces_per_level) + "- " + rest)
    return "\n".join(out)


def extract_frontmatter(md: str) -> str:
    """Pull the "# YYYY-MM-DD" title and "Attendees:"/"Apologies:" lines
    that Google Docs meeting notes start with out into a YAML frontmatter
    block (date/title/description/author/categories/tags/attendees/
    apologies), then return the frontmatter + remaining body.
    """
    lines = md.split("\n")
    meta: dict = {}
    consumed = set()

    date_match = re.match(r"^#\s*(\d{4}-\d{2}-\d{2})\s*$", lines[0]) if lines else None
    if date_match:
        meta["date"] = datetime.date.fromisoformat(date_match.group(1))
        consumed.add(0)

    for i, line in enumerate(lines):
        m = re.match(r"^(Attendees|Apologies):\s*(.+)$", line, re.IGNORECASE)
        if m:
            key = m.group(1).lower()
            people = [p.strip() for p in m.group(2).split(",") if p.strip()]
            meta[key] = [NAME_ALIASES.get(p, p) for p in people]
            consumed.add(i)

    if not meta:
        return md

    body = "\n".join(l for i, l in enumerate(lines) if i not in consumed).lstrip("\n")

    ordered = {}
    if "date" in meta:
        ordered["date"] = meta["date"]
        ordered["title"] = _DoubleQuoted(BLOG_TITLE_TEMPLATE.format(date=meta["date"].isoformat()))
        ordered["slug"] = BLOG_SLUG
        ordered["description"] = _DoubleQuoted(BLOG_DESCRIPTION)
        ordered["author"] = BLOG_AUTHOR
        ordered["categories"] = BLOG_CATEGORIES
        ordered["tags"] = BLOG_TAGS
    for key in ("attendees", "apologies"):
        if key in meta:
            ordered[key] = meta[key]

    frontmatter = yaml.dump(
        ordered, Dumper=_IndentDumper, sort_keys=False, default_flow_style=False, allow_unicode=True
    )
    return f"---\n{frontmatter}---\n\n{body}"


def main() -> None:
    raw_html = sys.stdin.read()
    if not raw_html.strip():
        sys.exit("no HTML on stdin (did you use `-t text/html`?)")

    raw_html = strip_checkbox_icons(raw_html)
    raw_html = mark_completed_items(raw_html)

    h = html2text.HTML2Text()
    h.body_width = 0
    h.unicode_snob = True
    md = h.handle(raw_html)

    md = re.sub(r"(?m)^(\s*[-*] .*?) \\- ", r"\1 - ", md)  # unescape "word \- word"
    md = re.sub(r"\[\s+([^\]]*)\]\(", r"[\1](", md)  # stray space html2text adds after a <del>
    md = md.replace("\xa0", " ")  # non-breaking spaces from &nbsp;
    md = re.sub(r"[ \t]+\n", "\n", md)  # trailing whitespace
    md = re.sub(r"\n{3,}", "\n\n", md)  # collapse blank-line runs
    md = strip_embedded_images(md)
    md = reindent_lists(md)
    md = strip_private_items(md)
    md = tighten_lists(md)
    md = extract_frontmatter(md)

    sys.stdout.write(md.strip() + "\n")


if __name__ == "__main__":
    main()
