# Convert Google Docs clipboard content into a meeting notes markdown file
# (see scripts/gdoc2md.py). Copy the notes in the Google Doc first, then run:
#   just notes-to-md 2026-09-16
notes-to-md date:
    #!/usr/bin/env bash
    set -euo pipefail
    year="{{date}}"
    year="${year%%-*}"
    output="docs/blog/posts/meetings/${year}/{{date}}-admins-meeting.md"
    mkdir -p "docs/blog/posts/meetings/${year}"
    if [[ "$(uname -s)" == "Darwin" ]]; then
        pbpaste -Prefer html | uv run --script scripts/gdoc2md.py > "$output"
    elif [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
        wl-paste --type text/html | uv run --script scripts/gdoc2md.py > "$output"
    else
        xclip -selection clipboard -t text/html -o | uv run --script scripts/gdoc2md.py > "$output"
    fi
    echo "Wrote $output"
    echo
    cat "$output"
