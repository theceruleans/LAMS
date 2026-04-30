#!/bin/zsh
# arrange-windows.sh
# Usage: arrange-windows.sh [left_app] [right_app]
# Default: Claude left, Chrome right

LEFT_APP="${1:-Claude}"
RIGHT_APP="${2:-Google Chrome}"

osascript << EOF
tell application "Finder"
    set screenBounds to bounds of window of desktop
    set screenW to item 3 of screenBounds
    set screenH to item 4 of screenBounds
end tell

set halfW to screenW / 2

tell application "System Events"
    if exists process "$LEFT_APP" then
        tell process "$LEFT_APP"
            set position of front window to {0, 0}
            set size of front window to {halfW, screenH}
        end tell
    end if
    if exists process "$RIGHT_APP" then
        tell process "$RIGHT_APP"
            set position of front window to {halfW, 0}
            set size of front window to {halfW, screenH}
        end tell
    end if
end tell
EOF

echo "Arranged: $LEFT_APP (left) | $RIGHT_APP (right)"
