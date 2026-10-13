# Convert Google Docs clipboard content into a meeting notes markdown file
# (see scripts/gdoc2md.py). Copy the notes in the Google Doc first, then run:
#   just notes-to-md 2026-09-16
notes-to-md date:
    #!/usr/bin/env bash
    set -euo pipefail
    output="django-commons.org/content/blog/posts/{{date}}-admins-meeting.md"
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
