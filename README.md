# LAMS — Look At My Screen

A Claude Code skill that captures your screen and analyses it using AI vision.

Type `/lams` and Claude describes what it sees. Append a question to focus the analysis.

```
/lams
/lams what error is showing?
/lams is there anything wrong with this layout?
```

---

## Requirements

- [Claude Code](https://claude.ai/code) — CLI, desktop app, or IDE extension
- One of the following MCP tools enabled in your Claude Code session:
  - **[Windows-MCP](https://github.com/anthropics/windows-mcp)** *(Windows — recommended)*
  - **[Desktop Commander MCP](https://github.com/wonderwhy-er/DesktopCommanderMCP)** *(cross-platform fallback)*

---

## Installation

Copy `lams.md` into your Claude Code skills directory:

**Windows**
```
%APPDATA%\Claude\skills\lams.md
```

**macOS / Linux**
```
~/.claude/skills/lams.md
```

Restart Claude Code. The `/lams` command will be available immediately.

---

## Master Prompt

The full skill definition is in [`lams.md`](lams.md). This is the prompt Claude uses — you can also paste it directly into any Claude session that has MCP tools available, without installing the skill file.

---

## Notes

- Works best with `claude-sonnet-4-6` or `claude-opus-4-6`. Run `/model claude-sonnet-4-6` if on auto-selection.
- In Cowork and Chat sessions, MCP tools are available natively — paste the master prompt directly.

---

## License

MIT
