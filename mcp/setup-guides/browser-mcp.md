# Browser Automation MCP Setup Guide

This guide details how to configure headless browser automation MCP servers for inspecting, testing, and debugging Flutter Web applications.

---

## 1. Capabilities
- **`navigate_page`**: Opens Flutter Web running on local dev server (e.g., `http://localhost:8080`).
- **`take_screenshot`**: Captures high-resolution visual screenshots of CanvasKit or WASM rendering.
- **`click_element` & `fill_form`**: Simulates end-to-end user journeys in the browser.
- **`inspect_console_logs`**: Captures browser JavaScript errors, CORS violations, and network failures.

---

## 2. Configuration (`.cursor/mcp.json` or `claude-code-mcp.json`)
```json
{
  "mcpServers": {
    "browser-tools": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-puppeteer"],
      "env": {}
    }
  }
}
```

---

## 3. Verification Workflow
1. Start Flutter Web dev server:
   ```bash
   flutter run -d web-server --web-port=8080
   ```
2. Prompt agent:
   ```text
   Navigate to http://localhost:8080, take a screenshot of the login screen, and check the browser console for errors.
   ```
3. Verify the agent captures the screenshot and reports clean console logs.
