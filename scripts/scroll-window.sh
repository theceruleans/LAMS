#!/bin/zsh
# scroll-window.sh
# Usage: scroll-window.sh [AppName] [up|down|pagedown|pageup] [amount]

APP="${1:-Google Chrome}"
DIRECTION="${2:-down}"
AMOUNT="${3:-5}"

osascript << EOF
tell application "$APP"
    activate
end tell
delay 0.3
EOF

case "$DIRECTION" in
    down)     KEY="125" ;;
    up)       KEY="126" ;;
    pagedown) KEY="121" ;;
    pageup)   KEY="116" ;;
    *)        KEY="125" ;;
esac

osascript << EOF
tell application "System Events"
    repeat $AMOUNT times
        key code $KEY
        delay 0.05
    end repeat
end tell
EOF

echo "Scrolled $APP $DIRECTION x$AMOUNT"
