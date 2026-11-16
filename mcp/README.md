# Model Context Protocol (MCP) Integration Kit

This directory provides verified setup guides, client configurations, and security policies for connecting AI coding agents to Model Context Protocol (MCP) servers for Flutter and Dart engineering.

> [!IMPORTANT]
> **MCP is 100% Optional**: The Flutter Agent Kit operates autonomously with standard CLI tools (`flutter`, `dart`, `git`). These MCP configurations are optional accelerators for agents running in environments with MCP support (Cursor, Claude Code, Gemini CLI, Antigravity).

---

## Directory Structure

```text
mcp/
├── README.md                   # This overview guide
│
├── setup-guides/               # Verified server installation & operational guides
│   ├── dart-mcp.md             # Official Dart & Flutter Tooling Daemon (DTD) server
│   ├── figma-mcp.md            # Figma to Flutter token & widget extraction server
│   ├── browser-mcp.md          # Headless browser automation for Flutter Web & DevTools
│   └── filesystem-mcp.md       # Secure sandboxed filesystem access
│
└── configurations/             # Ready-to-copy client configuration files
    ├── cursor-mcp.json         # Configuration for Cursor IDE
    ├── claude-code-mcp.json    # Configuration for Claude Code CLI
    ├── gemini-cli-mcp.json     # Configuration for Gemini CLI
    └── antigravity-mcp.json    # Configuration for Antigravity Agent Harness
```

---

## Supported Servers & Capabilities

### 1. Dart & Flutter MCP Server (`setup-guides/dart-mcp.md`)
- **Capabilities**: DTD protocol bridge, hot reload, hot restart, live runtime error capture, widget inspector hierarchy, and pub.dev package lookup.
- **Client Requirements**: Dart SDK 3.3+.

### 2. Figma to Flutter MCP Server (`setup-guides/figma-mcp.md`)
- **Capabilities**: Parses Figma design files into Flutter `ThemeData`, `ThemeExtension` tokens, SVG icons, and responsive widget trees.
- **Client Requirements**: Node.js 18+, Figma Personal Access Token.

### 3. Browser Automation MCP (`setup-guides/browser-mcp.md`)
- **Capabilities**: Launches headless Chrome to inspect Flutter Web CanvasKit/WASM rendering, execute end-to-end clicks, and audit visual layout.
- **Client Requirements**: Chrome / Chromium installed.

### 4. Filesystem MCP (`setup-guides/filesystem-mcp.md`)
- **Capabilities**: Provides bounded, sandboxed file reading and writing within the project workspace, preventing unauthorized path traversal.
