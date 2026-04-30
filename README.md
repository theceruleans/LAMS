# LAMS — Look At My Screen

A Claude Code skill that captures your screen and analyses it using AI vision.

Type `/lams` and Claude describes what it sees. Append a question to focus the analysis.

```
/lams
/lams what error is showing?
/lams is there anything wrong with this layout?
```

---

## What's new

- **Token-efficient by default** — LAMS now tries the cheapest method first: text copy → DOM inspection → window screenshot. Images are only used when visuals actually matter.
- **Window-only screenshots** — no more full-screen captures. LAMS reads the exact window bounds and crops to them.
- **Scroll before capture** — automatically scrolls to relevant content before screenshotting.
- **Text extraction** — copies text directly from the target app when possible, skipping the image entirely.
- **macOS helper scripts** — if `~/claude-scripts/` is present, LAMS uses those for faster, more precise captures.

---

## Requirements

- [Claude Code](https://claude.ai/code) — CLI, desktop app, or IDE extension
- One of the following MCP tools enabled in your Claude Code session:
  - **Windows-MCP** (`ant.dir.cursortouch.windows-mcp`) *(Windows — recommended, install via Claude Extensions)*
  - **[Desktop Commander MCP](https://github.com/wonderwhy-er/DesktopCommanderMCP)** *(cross-platform fallback)*

### Optional — macOS helper scripts (recommended)

For the best experience on macOS, install the helper scripts:

```bash
mkdir -p ~/claude-scripts
curl -o ~/claude-scripts/arrange-windows.sh https://raw.githubusercontent.com/theceruleans/LAMS/main/scripts/arrange-windows.sh
curl -o ~/claude-scripts/screenshot-window.sh https://raw.githubusercontent.com/theceruleans/LAMS/main/scripts/screenshot-window.sh
curl -o ~/claude-scripts/scroll-window.sh https://raw.githubusercontent.com/theceruleans/LAMS/main/scripts/scroll-window.sh
curl -o ~/claude-scripts/copy-text.sh https://raw.githubusercontent.com/theceruleans/LAMS/main/scripts/copy-text.sh
chmod +x ~/claude-scripts/*.sh
```

These give LAMS precise window bounds, scrolling, and text extraction — reducing image token usage significantly.

---

## Installation

**Windows (PowerShell)**
```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\.claude\commands" | Out-Null
curl.exe -o "$env:USERPROFILE\.claude\commands\lams.md" https://raw.githubusercontent.com/theceruleans/LAMS/main/lams.md
```

**macOS / Linux**
```bash
curl -o ~/.claude/commands/lams.md --create-dirs https://raw.githubusercontent.com/theceruleans/LAMS/main/lams.md
```

Restart Claude Code. The `/lams` command will be available immediately.

Or manually copy `lams.md` into your skills directory:
- Windows: `%USERPROFILE%\.claude\commands\`
- macOS / Linux: `~/.claude/commands/`

---

## Token priority

LAMS uses the cheapest method that answers the question:

| Method | Token cost | Used when |
|--------|-----------|----------|
| Copy text / pbpaste | Minimal | Text, code, page content |
| Chrome DOM / `get_page_text` | Minimal | Web pages, no layout needed |
| Window screenshot + zoom | Medium | UI layout, visuals, colour |
| Full screenshot | **Avoided** | Never used |

---

## Master Prompt

The full skill definition is in [`lams.md`](lams.md). You can also paste it directly into any Claude session that has MCP tools available, without installing the skill file.

---

## Notes

- Works best with `claude-sonnet-4-6` or `claude-opus-4-6`. Run `/model claude-sonnet-4-6` if on auto-selection.
- In Cowork and Chat sessions, MCP tools are available natively — paste the master prompt directly.

---

## Support

If LAMS saved you time, consider buying me a coffee — [paypal.me/ceruleanalpha](https://paypal.me/ceruleanalpha)

---

## Author

Created by **Habib Anibaba** ([@theceruleans](https://github.com/theceruleans))

---

## License

MIT
