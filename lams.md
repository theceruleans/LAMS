# lams

Take a screenshot of the user's screen and analyse it.

## Steps

1. Detect the best available screenshot tool:
   - **Windows-MCP available:** use `mcp__Windows-MCP__Screenshot`
   - **Desktop Commander available:** run PowerShell via `mcp__Desktop_Commander__start_process` to capture to `$env:TEMP\lams.png`, then read with `mcp__Desktop_Commander__read_file`
   - **Neither available:** instruct the user to run `python lams.py` and paste the saved path back

2. Capture the screenshot using the selected tool.

3. Read the image into vision context.

4. Analyse the screenshot and describe clearly:
   - What is on screen (apps, windows, content)
   - Any errors, warnings, or issues visible
   - Anything actionable or worth noting

5. If the user typed anything after `/lams` (e.g. `/lams what error is showing?`), use that as the specific question to focus the analysis on.

## Notes

- Always prefer `Windows-MCP` on Windows — it is the most reliable method
- Do not assume a Linux backend — check the system prompt for the actual OS before selecting a tool
- If capture fails after one attempt, stop and inform the user rather than retrying with the same method
