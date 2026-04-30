# lams

Analyse the user's screen using the lowest-token method that answers the question.

## Token Priority — always use the cheapest method that works

| Method | Cost | Use when |
|--------|------|----------|
| Copy text | ★☆☆☆ | Text, code, page content visible on screen |
| Window screenshot (bounds only) | ★★★☆ | Layout, visual UI, colour, position |
| Full screenshot | ★★★★ AVOID | Last resort only |

---

## Steps

### 1. Detect OS

Check the system prompt for the current OS before selecting any tool. Never assume.

- `darwin` / `macOS` → use macOS steps below
- `win32` / `Windows` → use Windows steps below
- `linux` → use Linux steps below

---

### 2A. Copy text (cheapest)

Try this before screenshotting. If the answer is in the text, stop here.

**macOS (Desktop Commander):**
```bash
osascript -e 'tell application "App Name" to activate'
sleep 0.3
osascript -e 'tell application "System Events" to keystroke "a" using command down'
sleep 0.1
osascript -e 'tell application "System Events" to keystroke "c" using command down'
sleep 0.1
pbpaste
```

**Windows (Desktop Commander):**
```powershell
Add-Type -AssemblyName System.Windows.Forms
$wsh = New-Object -ComObject WScript.Shell
$wsh.SendKeys("^a")
Start-Sleep -Milliseconds 150
$wsh.SendKeys("^c")
Start-Sleep -Milliseconds 150
[System.Windows.Forms.Clipboard]::GetText()
```

**Linux (Desktop Commander — requires `xclip` and `xdotool`):**
```bash
xdotool key ctrl+a
sleep 0.1
xdotool key ctrl+c
sleep 0.1
xclip -selection clipboard -o
```

---

### 2B. Window screenshot (only when visual is needed)

**Step 1 — Scroll to relevant content first:**

**macOS:**
```bash
osascript -e 'tell application "App Name" to activate'
sleep 0.2
# Repeat as needed
osascript -e 'tell application "System Events" to key code 125'
```

**Windows:**
```powershell
$wsh = New-Object -ComObject WScript.Shell
$wsh.SendKeys("{PGDN}")
```

**Linux:**
```bash
xdotool key Page_Down
```

---

**Step 2 — Capture exact window bounds (not full screen):**

**macOS (Desktop Commander — preferred):**
```bash
BOUNDS=$(osascript -e '
tell application "System Events"
  tell process "App Name"
    set w to front window
    set pos to position of w
    set sz to size of w
    return (item 1 of pos) & "," & (item 2 of pos) & "," & (item 1 of sz) & "," & (item 2 of sz)
  end tell
end tell')
X=$(echo $BOUNDS | cut -d',' -f1 | xargs)
Y=$(echo $BOUNDS | cut -d',' -f2 | xargs)
W=$(echo $BOUNDS | cut -d',' -f3 | xargs)
H=$(echo $BOUNDS | cut -d',' -f4 | xargs)
screencapture -R "${X},${Y},${W},${H}" /tmp/lams-shot.png
```
Then read `/tmp/lams-shot.png` into vision context.

**Windows — Windows-MCP (preferred):**
```
mcp__Windows-MCP__Screenshot
```

**Windows — Desktop Commander fallback (requires .NET):**
```powershell
Add-Type -AssemblyName System.Windows.Forms, System.Drawing
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bmp = New-Object System.Drawing.Bitmap($screen.Width, $screen.Height)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.CopyFromScreen($screen.Location, [System.Drawing.Point]::Empty, $screen.Size)
$bmp.Save("$env:TEMP\lams.png")
```
Then read `$env:TEMP\lams.png` into vision context.

**Linux — Desktop Commander (requires `scrot` and `xdotool`):**
```bash
# Get active window bounds
eval $(xdotool getactivewindow getwindowgeometry --shell)
scrot -a "${X},${Y},${WIDTH},${HEIGHT}" /tmp/lams-shot.png
```
Then read `/tmp/lams-shot.png` into vision context.

---

### 3. Analyse and respond

- Describe what is on screen (apps, windows, content)
- Surface any errors, warnings, or issues
- If the user typed anything after `/lams` (e.g. `/lams what error is showing?`), focus on that specific question
- Extract and quote text directly where possible instead of describing it

---

## Notes

- Never take a full-screen screenshot — always prefer window bounds only
- One screenshot per task — extract everything needed before taking another
- If capture fails after one attempt, stop and inform the user rather than retrying with the same method
- On Linux, `scrot`, `xdotool`, and `xclip` must be installed — inform the user if missing
