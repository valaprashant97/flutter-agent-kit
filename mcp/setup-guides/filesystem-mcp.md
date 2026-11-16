# Filesystem MCP Setup Guide

This guide details how to configure a secure, sandboxed Filesystem Model Context Protocol (MCP) server for Flutter and Dart workspaces.

---

## 1. Capabilities
- **`read_file`**: Reads text, images, or configuration assets within permitted directory trees.
- **`write_file`**: Writes code, tests, and documentation atomically without path traversal.
- **`list_directory`**: Explores project structure in a bounded, token-efficient manner.

---

## 2. Configuration (`.cursor/mcp.json` or `claude-code-mcp.json`)
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "D:\\Flutter\\Flutter Agent-Kit\\flutter-agent-kit"
      ]
    }
  }
}
```

---

## 3. Security Boundaries
- **Strict Path Allowlisting**: Only folders explicitly passed in `args` can be accessed by the agent.
- **Traversal Prevention**: The server rejects `../` traversal attempts that escape the allowed workspace boundaries.
- **Protected Locations**: Sensitive system directories (`C:\Windows`, `C:\Users\<user>\.ssh`) are blocked.
