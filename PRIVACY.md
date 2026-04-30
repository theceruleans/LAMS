# Privacy Policy — LAMS (Look At My Screen)

**Last updated:** April 2026

---

## Overview

LAMS is an open-source Claude Code skill. It is a markdown instruction file — it has no servers, no backend, no accounts, and collects no data of its own.

---

## What LAMS does with your screen

When you run `/lams`, LAMS instructs Claude to read your screen using one of three methods, in order of preference:

1. **Copy text** — selects and copies visible text from the active window via your clipboard
2. **Window screenshot** — captures a cropped image of the active window only (never the full screen)
3. **Full screenshot** — used only as a last resort if the above methods fail

This content is passed to Claude as part of your normal conversation context. It is not sent anywhere else.

---

## Data collection

**LAMS collects no data.**

- No analytics
- No telemetry
- No usage tracking
- No accounts or sign-in
- No third-party services
- Nothing is stored outside your own machine or your Claude session

---

## Where your screen data goes

Screen content captured by LAMS is sent to Anthropic's Claude API as part of your active session — exactly the same as anything else you type or paste into Claude.

How Anthropic handles that data is governed by:
- [Anthropic Privacy Policy](https://www.anthropic.com/privacy)
- [Anthropic Usage Policy](https://www.anthropic.com/policies/usage-policy)

LAMS has no influence over and no access to how Anthropic processes your data.

---

## Local processing

All screen capture runs locally on your machine via Desktop Commander MCP (macOS/Linux) or Windows-MCP (Windows). No screen content is transmitted to any server other than the Anthropic API you are already using.

---

## Clipboard use

On macOS and Linux, LAMS uses your clipboard temporarily to extract text (Cmd+A, Cmd+C, read, done). It does not retain clipboard contents, log them, or transmit them anywhere outside your Claude session.

---

## Third-party tools

LAMS depends on:

| Tool | Purpose | Privacy info |
|------|---------|--------------|
| [Desktop Commander MCP](https://github.com/wonderwhy-er/DesktopCommanderMCP) | Screen capture and shell commands | Open source, runs locally |
| [Windows-MCP](https://github.com/ant-dir/cursortouch-windows-mcp) | Screen capture on Windows | Open source, runs locally |
| Anthropic Claude API | AI analysis of screen content | [Anthropic Privacy Policy](https://www.anthropic.com/privacy) |

LAMS does not control how these tools handle data. Review their respective policies.

---

## Children's privacy

LAMS is a developer tool intended for adults. It is not directed at children under 13 and does not knowingly process data from children.

---

## Changes to this policy

If this policy changes materially, the date at the top will be updated and a note will be added to the GitHub changelog.

---

## Contact

Questions? Open an issue at [github.com/theceruleans/LAMS](https://github.com/theceruleans/LAMS) or reach out via GitHub.

---

*LAMS is MIT licensed open-source software maintained by [Habib Anibaba](https://github.com/theceruleans).*
