# lams

Analyse the user's screen using the lowest-token method that answers the question.

## Token Priority — always use the cheapest method that works

| Method | Cost | Use when |
|--------|------|----------|
| Copy text via Desktop Commander | ★☆☆☆ | Text, code, page content visible on screen |
| Window screenshot (bounds only) | ★★★☆ | Layout, visual UI, colour, position |
| Full screenshot | ★★★★ AVOID | Never — always prefer window-only capture |

---

## Steps

### 1. Decide the best capture method

Before screenshotting, ask: can this be answered without an image?

- **Text/code/data visible on screen?** → copy it directly (Step 2A)
- **Visual layout or UI needed?** → take a window screenshot (Step 2B)
- **Never** take a full-screen screenshot

---

### 2A. Copy text (cheapest — Desktop Commander)

**macOS:**
```bash
osascript -e 'tell application "App Name" to activate'
sleep 0.3
osascript -e 'tell application "System Events" to keystroke "a" using command down'
sleep 0.1
osascript -e 'tell application "System Events" to keystroke "c" using command down'
sleep 0.1
pbpaste
```

**Windows:**
```powershell
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait("^a")
Start-Sleep -Milliseconds 100
[System.Windows.Forms.SendKeys]::SendWait("^c")
Start-Sleep -Milliseconds 100
[System.Windows.Forms.Clipboard]::GetText()
```

Read stdout directly — no image tokens used.

---

### 2B. Window screenshot (only when visual is needed)

**Step 1 — Scroll to relevant content first (macOS):**
```bash
osascript -e 'tell application "App Name" to activate'
sleep 0.3
osascript -e 'tell application "System Events" to key code 125' # down arrow, repeat as needed
```

**Step 2 — Capture exact window bounds only (not full screen):**

**macOS — Desktop Commander:**
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
Use `mcp__Windows-MCP__Screenshot`

**Windows — Desktop Commander fallback:**
```powershell
Add-Type -AssemblyName System.Windows.Forms
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bmp = New-Object System.Drawing.Bitmap($screen.Width, $screen.Height)
$graphics = [System.Drawing.Graphics]::FromImage($bmp)
$graphics.CopyFromScreen($screen.Location, [System.Drawing.Point]::Empty, $screen.Size)
$bmp.Save("$env:TEMP\lams.png")
```
Then read `$env:TEMP\lams.png` into vision context.

---

### 3. Analyse and respond

- Describe what is on screen (apps, windows, content)
- Surface any errors, warnings, or issues
- If the user typed anything after `/lams` (e.g. `/lams what error is showing?`), focus on that specific question
- Extract and quote text directly where possible instead of describing it

---

## Notes

- Never take a full-screen screenshot — always capture window bounds only on macOS
- One screenshot per task — extract everything needed before taking another
- If capture fails after one attempt, stop and inform the user rather than retrying with the same method
- Do not assume OS — check the system prompt before selecting a tool
