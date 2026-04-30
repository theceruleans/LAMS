#!/bin/zsh
# screenshot-window.sh
# Usage: screenshot-window.sh [AppName] [output_path]
# Takes a screenshot of only the target app window bounds

APP="${1:-Google Chrome}"
OUTPUT="${2:-/tmp/claude-shot-$(date +%s).png}"

BOUNDS=$(osascript << EOF
tell application "System Events"
    tell process "$APP"
        set w to front window
        set pos to position of w
        set sz to size of w
        set x to item 1 of pos
        set y to item 2 of pos
        set ww to item 1 of sz
        set wh to item 2 of sz
        return (x as text) & "," & (y as text) & "," & (ww as text) & "," & (wh as text)
    end tell
end tell
EOF)

X=$(echo $BOUNDS | cut -d',' -f1 | xargs)
Y=$(echo $BOUNDS | cut -d',' -f2 | xargs)
W=$(echo $BOUNDS | cut -d',' -f3 | xargs)
H=$(echo $BOUNDS | cut -d',' -f4 | xargs)

screencapture -R "${X},${Y},${W},${H}" "$OUTPUT"
echo "$OUTPUT"
