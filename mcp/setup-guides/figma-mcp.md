# Figma to Flutter MCP Server Setup Guide

This guide details how to configure the **Figma to Flutter MCP Server** to allow AI coding agents to translate Figma designs directly into Flutter themes, components, and responsive layouts.

---

## 1. Capabilities
- **`extract_colors`**: Reads Figma paint styles and generates Flutter `ColorScheme` & `AppColors`.
- **`extract_typography`**: Extracts font families, font weights, line heights, and letter spacings into `TextTheme`.
- **`extract_components`**: Inspects Figma component sets and generates Flutter widgets matching component variants.
- **`export_svg_assets`**: Downloads vector icons and illustrations directly into `assets/icons/`.

---

## 2. Prerequisites
- Node.js (v18.0.0+)
- Figma Personal Access Token ([Generate in Figma Settings > Security](https://www.figma.com/settings))
- Target Figma File Key (extracted from URL: `https://www.figma.com/file/<FILE_KEY>/<FILE_NAME>`)

---

## 3. Configuration

### Cursor (`.cursor/mcp.json`)
```json
{
  "mcpServers": {
    "figma-flutter": {
      "command": "npx",
      "args": ["-y", "figma-flutter-mcp"],
      "env": {
        "FIGMA_ACCESS_TOKEN": "figd_your_actual_token_here"
      }
    }
  }
}
```

### Claude Code (`~/.claude/mcp.json`)
```json
{
  "mcpServers": {
    "figma-flutter": {
      "command": "npx",
      "args": ["-y", "figma-flutter-mcp"],
      "env": {
        "FIGMA_ACCESS_TOKEN": "figd_your_actual_token_here"
      }
    }
  }
}
```

---

## 4. Verification Steps
1. Configure `FIGMA_ACCESS_TOKEN` in your user environment or local config.
2. Provide your agent with a Figma URL:
   ```text
   Inspect Figma file https://www.figma.com/file/abc123XYZ/DesignSystem and generate lib/core/theme/app_theme.dart.
   ```
3. Verify generated code matches Figma style names and hex color codes.

---

## 5. Security Invariants
- **Never Commit Tokens**: Ensure `mcp.json` containing `FIGMA_ACCESS_TOKEN` is in `.gitignore`.
- **Read-Only Access**: The server only queries the Figma REST API and cannot modify Figma design files.
