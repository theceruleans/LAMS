# lams

Analyse the user's screen using the lowest-token method that answers the question.

## Token Priority — always use the cheapest method that works

| Method | Cost | Use when |
|--------|------|----------|
| Copy text / `pbpaste` | ★☆☆☆ | Reading text, code, page content |
| `get_page_text` (Chrome MCP) | ★☆☆☆ | Web page content, no layout needed |
| `read_page filter:interactive` (Chrome MCP) | ★★☆☆ | Finding buttons, inputs, links |
| Window screenshot + zoom region | ★★★☆ | Layout, visual UI, colour, position |
| Full screenshot | ★★★★ AVOID | Never — always use window-only capture |

---

## Steps

### 1. Decide the best capture method

Before screenshotting, ask: can this be answered without an image?

- **Text/code/data on screen?** → copy it directly (Step 2A)
- **Web page content needed?** → use `get_page_text` or `read_page` (Step 2B)
- **Visual layout or UI needed?** → take a window screenshot (Step 2C)
- **Never** take a full-screen screenshot

---

### 2A. Copy text (cheapest)

**macOS — Desktop Commander available:**
```bash
~/claude-scripts/copy-text.sh "App Name"
```
Read stdout directly — no image tokens used.

**Fallback via osascript:**
```bash
osascript -e 'tell application "App Name" to activate'
osascript -e 'tell application "System Events" to keystroke "a" using command down'
osascript -e 'tell application "System Events" to keystroke "c" using command down'
pbpaste
```

---

### 2B. Web page text / DOM (cheap)

- Chrome MCP `get_page_text` → plain text of the page
- Chrome MCP `read_page filter:interactive` → buttons, inputs, links only
- Use these before any screenshot for web tasks

---

### 2C. Window screenshot (only when visual is needed)

**Step 1 — Scroll to relevant content first:**

```bash
~/claude-scripts/scroll-window.sh "App Name" down 3
```

**Step 2 — Capture the exact window bounds (not full screen):**

**macOS — Desktop Commander available (preferred):**
```bash
~/claude-scripts/screenshot-window.sh "App Name" /tmp/lams-shot.png
```

**macOS — fallback via osascript + screencapture:**
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

**Windows — Windows-MCP available (preferred):**
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

**Step 3 — Read and analyse:**
- Read the saved file into vision context
- Use `zoom` on a specific region if only part of the image is relevant — avoid re-screenshotting

---

### 3. Analyse and respond

- Describe what is on screen (apps, windows, content)
- Surface any errors, warnings, or issues
- If the user typed anything after `/lams` (e.g. `/lams what error is showing?`), focus on that specific question
- Extract and quote text directly where possible instead of describing it

---

## Window arrangement (macOS)

If windows need repositioning before capture:
```bash
~/claude-scripts/arrange-windows.sh "Claude" "Google Chrome"
```

---

## Notes

- On macOS, always check for `~/claude-scripts/` first — use those helpers if present
- Never take a full-screen screenshot — always capture window bounds only
- One screenshot per task — extract everything needed before taking another
- If capture fails after one attempt, stop and inform the user rather than retrying with the same method
- Do not assume OS — check the system prompt before selecting a tool
