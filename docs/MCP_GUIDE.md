# Model Context Protocol (MCP) Integration Guide

This guide details how AI coding agents can optionally interface with **Model Context Protocol (MCP)** servers to enhance Flutter development, automated debugging, and UI design translation.

> [!IMPORTANT]
> **MCP Servers are 100% Optional.**
> The **Flutter Agent Kit** is completely functional and self-contained without any MCP servers installed. All core engineering, skills, rules, and workflows operate cleanly via standard Flutter and Dart CLI tools (`flutter`, `dart`, `git`). Never automatically install or execute untrusted MCP servers without explicit developer consent.

---

## 1. Supported MCP Servers Overview

| MCP Server | Primary Capability | Supported Platforms | Supported Agents |
| :--- | :--- | :--- | :--- |
| **Dart & Flutter MCP Server** | Dart Tooling Daemon (DTD), Hot Reload/Restart, DevTools, runtime error capture, widget inspector | Windows, macOS, Linux | Claude Code, Cursor, Gemini CLI, Antigravity |
| **Figma to Flutter MCP** | Extract design tokens, color styles, typography, and generate Flutter widgets from Figma files | Windows, macOS, Linux | Claude Code, Cursor, Gemini CLI, Antigravity |
| **Browser Automation MCP** | Inspect rendered Flutter Web apps, take screenshots, run end-to-end web workflows | Windows, macOS, Linux | Claude Code, Cursor, Antigravity |
| **Filesystem MCP** | Sandboxed, structured file access for reading/writing project assets | Windows, macOS, Linux | Claude Code, Cursor, Gemini CLI, Antigravity |

---

## 2. Dart & Flutter MCP Server

### Purpose & Capabilities
The official Dart and Flutter MCP server connects AI agents directly to the **Dart Tooling Daemon (DTD)** and the **Dart VM Service**. This grants agents deep introspective capabilities:
- **Hot Reload / Hot Restart**: Trigger application reload programmatically after code edits.
- **Runtime Error Stream**: Capture unhandled exceptions, FlutterError details, and stacktraces directly from the running app.
- **Widget Inspector**: Inspect the live widget hierarchy and bounds.
- **Pub.dev Search**: Look up package versions and documentation safely.

### Installation & Configuration

#### In Cursor (`.cursor/mcp.json` or Global Settings)
```json
{
  "mcpServers": {
    "dart-flutter": {
      "command": "dart",
      "args": ["run", "mcp_server_dart"],
      "env": {}
    }
  }
}
```

#### In Claude Code (`~/.claude/mcp.json`)
```json
{
  "mcpServers": {
    "dart-flutter": {
      "command": "dart",
      "args": ["run", "mcp_server_dart"]
    }
  }
}
```

### Security & Permissions
- **Least Privilege**: The server communicates only with the local Dart Tooling Daemon via local IPC/WebSockets.
- **Network Boundaries**: No external outbound network requests are made other than pub.dev package resolution.
- **Process Isolation**: The MCP server operates as a child process of the agent harness and cannot execute arbitrary shell commands.

### Verification Steps
1. Start your Flutter application: `flutter run -d windows` (or Chrome / emulator).
2. Note the Dart Tooling Daemon URI or VM service URI.
3. Test tool availability in your agent: invoke `dtd` or `hot_reload`.
4. Verify the agent receives a successful response without crashing the running Flutter app.

### Limitations
- Requires an active, running Flutter application in debug or profile mode.
- Does not function against release builds where VM Service and DTD are disabled.

---

## 3. Figma to Flutter MCP Server

### Purpose & Capabilities
Translates Figma designs directly into production-grade Flutter themes, components, and responsive screens:
- **Design Token Extraction**: Extracts color styles, typography hierarchies, and spacing grids.
- **Theme Generation**: Emits Flutter `ThemeData` and custom `ThemeExtension` classes.
- **Component Translation**: Generates Flutter widgets matching Figma component variants.

### Installation & Configuration
Requires Node.js (v18+) and a Figma Personal Access Token.

```json
{
  "mcpServers": {
    "figma-flutter": {
      "command": "npx",
      "args": ["-y", "figma-flutter-mcp"],
      "env": {
        "FIGMA_ACCESS_TOKEN": "your-figma-token-here"
      }
    }
  }
}
```

### Security & Permissions
- **Secret Protection**: Store `FIGMA_ACCESS_TOKEN` in environment variables or user-level configuration. Never commit it to git repositories.
- **Read-Only**: The integration only reads Figma design files and does not modify remote Figma canvases.

### Verification Steps
1. Configure `FIGMA_ACCESS_TOKEN`.
2. Provide your agent with a Figma file URL: `https://www.figma.com/file/<key>/<name>`.
3. Agent extracts color tokens and emits `app_theme.dart`.
4. Verify colors match Figma hex values.

---

## 4. MCP Operational Safety Rules

When working with AI agents and MCP tools:
1. **Never Assume MCP Exists**: Always verify tool availability before attempting an MCP call. If the tool is missing, fall back immediately to standard CLI commands (`flutter test`, `flutter analyze`).
2. **Never Commit MCP Configurations Containing Secrets**: Ensure files like `mcp.json` containing API keys or personal access tokens are listed in `.gitignore`.
3. **No Automatic Execution**: AI agents must never download or launch unverified MCP servers from the web without developer confirmation.
