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

- **Token-efficient by default** — LAMS tries text extraction before screenshotting. Images are only used when visuals actually matter.
- **Window-only screenshots** — no more full-screen captures on macOS. LAMS reads the exact window bounds and crops to them.
- **Scroll before capture** — scrolls to relevant content before screenshotting.

---

## How it works

LAMS is a **Claude Code slash command** — a markdown file that Claude reads as instructions when you type `/lams`. It is not an MCP server. It uses MCP tools that are already connected to your session (Desktop Commander or Windows-MCP) to capture and read your screen.

---

## Requirements

- [Claude Code](https://claude.ai/code) — CLI, desktop app, or IDE extension
- One of the following MCP tools enabled in your Claude Code session:
  - **Windows-MCP** (`ant.dir.cursortouch.windows-mcp`) *(Windows — recommended, install via Claude Extensions)*
  - **[Desktop Commander MCP](https://github.com/wonderwhy-er/DesktopCommanderMCP)** *(cross-platform)*

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

Or manually copy `lams.md` into your commands directory:
- Windows: `%USERPROFILE%\.claude\commands\`
- macOS / Linux: `~/.claude/commands/`

---

## Master Prompt

The full skill definition is in [`lams.md`](lams.md). You can also paste it directly into any Claude session that has Desktop Commander or Windows-MCP available, without installing the skill file.

---

## Notes

- Works best with `claude-sonnet-4-6` or `claude-opus-4-6`. Run `/model claude-sonnet-4-6` if on auto-selection.
- In Cowork sessions, Desktop Commander MCP is available natively — paste the master prompt directly.

---

## Support

If LAMS saved you time, consider buying me a coffee — [paypal.me/ceruleanalpha](https://paypal.me/ceruleanalpha)

---

## Author

Created by **Habib Anibaba** ([@theceruleans](https://github.com/theceruleans))

---

## License

MIT
