#!/bin/zsh
# copy-text.sh
# Usage: copy-text.sh [AppName] [all|selection]
# Copies text from the target app window to clipboard and prints it

APP="${1:-Google Chrome}"
MODE="${2:-all}"

osascript << EOF
tell application "$APP"
    activate
end tell
delay 0.3
EOF

if [ "$MODE" = "all" ]; then
    osascript << EOF
    tell application "System Events"
        keystroke "a" using command down
        delay 0.15
        keystroke "c" using command down
        delay 0.15
    end tell
EOF
else
    # Just copy current selection
    osascript << EOF
    tell application "System Events"
        keystroke "c" using command down
        delay 0.15
    end tell
EOF
fi

pbpaste
