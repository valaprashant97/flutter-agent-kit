
# Flutter Agent Kit

The Flutter Agent Kit is a provider-neutral standards and workflow package for
building Flutter applications with AI coding agents.

## Quick Start

Choose the entry point for your AI coding agent:

- GitHub Copilot: `.github/copilot-instructions.md`
- Claude Code: `CLAUDE.md`
- Gemini CLI: `GEMINI.md`
- Cursor: `.cursorrules`
- OpenAI Codex or Antigravity: `AGENTS.md`

Start with [Getting Started](docs/GETTING_STARTED.md). Core conventions live in
`core/`, specialized guidance lives in `skills/`, and reusable lifecycle
processes live in `workflows/`.

## Repository Structure

- `core/` — shared engineering principles
- `skills/` — area-specific implementation guidance
- `rules/` — detailed domain rules
- `workflows/` — structured lifecycle workflows
- `templates/` — project documentation templates
- `scripts/` — repository validation tools

## Validation

Run the structure validator:

```bash
dart run scripts/validation/validate-structure.dart
```
