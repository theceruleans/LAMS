# LAMS — Look At My Screen

A Claude Code skill that captures your screen and analyses it using AI vision.

Type `/lams` and Claude describes what it sees. Append a question to focus the analysis.

```
/lams
/lams what error is showing?
/lams is there anything wrong with this layout?
```

---

## Why LAMS

**Without LAMS:** take a screenshot manually, drag it into Claude, type your question. ~18 seconds per interaction.

**With LAMS:** type `/lams what's wrong here?`. ~3 seconds.

| | Without LAMS | With LAMS | Saving |
|--|--|--|--|
| Time per use | ~18 seconds | ~3 seconds | **15 seconds** |
| Time at 20 uses/day | 6 min/day | 1 min/day | **~2.5 hrs/month** |
| Tokens per analysis (API) | ~1,000–1,500 | ~100–500 | **Up to 90% less** |
| API cost at 50 uses/day | ~$4.50/month | ~$0.45/month | **~$48/year** |
| Context window used | High | Minimal | **More room for your actual work** |

LAMS picks the cheapest method automatically — text extraction when possible, window-cropped screenshot only when visuals are needed. It never takes a full-screen capture.

---

## How it works

LAMS is a **Claude Code slash command** — a markdown file Claude reads as instructions when you type `/lams`. It is not an MCP server. It uses MCP tools already connected to your session to capture and read your screen, choosing the cheapest method that answers the question.

---

## Platform support

| Platform | Status | Required tools |
|----------|--------|----------------|
| macOS | ✅ Full support | Desktop Commander MCP |
| Windows | ✅ Full support | Windows-MCP *(recommended)* or Desktop Commander MCP |
| Linux | ⚠️ Experimental | Desktop Commander MCP + `scrot` + `xdotool` + `xclip` |

---

## Requirements by platform

### macOS

- [Desktop Commander MCP](https://github.com/wonderwhy-er/DesktopCommanderMCP)

Install Desktop Commander via Claude Code:
```
/mcp add desktop-commander
```
Or follow the [Desktop Commander setup guide](https://github.com/wonderwhy-er/DesktopCommanderMCP).

---

### Windows

**Option A — Windows-MCP (recommended)**

Install via Claude Extensions: search `ant.dir.cursortouch.windows-mcp` in the Extensions panel.

**Option B — Desktop Commander MCP (fallback)**

Requires [Node.js](https://nodejs.org) installed. Then:
```
/mcp add desktop-commander
```

---

### Linux (experimental)

Requires [Desktop Commander MCP](https://github.com/wonderwhy-er/DesktopCommanderMCP) plus these system tools:

```bash
# Debian / Ubuntu
sudo apt install scrot xdotool xclip

# Arch
sudo pacman -S scrot xdotool xclip

# Fedora
sudo dnf install scrot xdotool xclip
```

Linux support is community-tested. If you run into issues, [open an issue](https://github.com/theceruleans/LAMS/issues).

---

## Installation

**macOS / Linux**
```bash
curl -o ~/.claude/commands/lams.md --create-dirs https://raw.githubusercontent.com/theceruleans/LAMS/main/lams.md
```

**Windows (PowerShell)**
```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\.claude\commands" | Out-Null
curl.exe -o "$env:USERPROFILE\.claude\commands\lams.md" https://raw.githubusercontent.com/theceruleans/LAMS/main/lams.md
```

Restart Claude Code. The `/lams` command will be available immediately.

Or manually copy `lams.md` into your commands directory:
- macOS / Linux: `~/.claude/commands/`
- Windows: `%USERPROFILE%\.claude\commands\`

---

## Share your own skills

LAMS is distributed as a single markdown file — the simplest way to share Claude Code skills. To share your own:

1. Create a public GitHub repo with your `skillname.md` file in the root
2. Add a one-line curl install command to your README (same pattern as above)
3. Users drop the file into `~/.claude/commands/` and restart Claude Code

No packaging, no registry, no build step.

---

## Master Prompt

The full skill definition is in [`lams.md`](lams.md). You can paste it directly into any Claude session that has Desktop Commander or Windows-MCP available, without installing the skill file.

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
