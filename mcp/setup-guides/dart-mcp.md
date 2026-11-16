# Dart & Flutter MCP Server Setup Guide

This guide details how to configure and use the official **Dart & Flutter MCP Server** to empower AI coding agents with real-time runtime inspection, DTD diagnostics, and automated hot reloads.

---

## 1. Capabilities
- **`hot_reload`**: Triggers JIT code injection into the active debug isolate.
- **`hot_restart`**: Reboots the application state while keeping the debug connection active.
- **`get_runtime_errors`**: Captures unhandled Flutter exceptions and stacktraces from the running VM.
- **`widget_inspector`**: Inspects render object bounds and element hierarchy.
- **`pub_dev_search`**: Searches pub.dev for package versions, verified publishers, and documentation.

---

## 2. Prerequisites
- Dart SDK `^3.3.0` or Flutter SDK `^3.19.0`
- Active Flutter development session running in debug or profile mode:
  ```bash
  flutter run -d windows
  ```

---

## 3. Configuration

### Cursor (`.cursor/mcp.json`)
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

### Claude Code (`~/.claude/mcp.json`)
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

---

## 4. Verification Steps
1. Start your Flutter application in debug mode on Windows Desktop:
   ```bash
   flutter run -d windows
   ```
2. In your AI agent chat, ask:
   ```text
   Use the dart-flutter MCP tool to trigger a hot reload and check if any runtime errors are present.
   ```
3. Confirm the agent receives a successful reload confirmation and empty error stream.

---

## 5. Security & Limitations
- **Local Loopback Only**: The server connects exclusively to the local Dart Tooling Daemon (DTD) on `127.0.0.1`.
- **Debug Mode Only**: Runtime tools do not work against release or AOT-compiled binaries where the Dart VM Service is stripped.
