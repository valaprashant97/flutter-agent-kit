# Multi-Agent Compatibility Guide

This document defines how the **Flutter Agent Kit** provides cross-agent interoperability across OpenAI Codex, Cursor, Claude Code, Gemini CLI, GitHub Copilot, Antigravity, and other coding assistants while maintaining a single, consistent source of truth.

---

## 1. Supported AI Agents Matrix

| AI Agent / Tool | Entry File | Discovery Mode | Skill Format Supported | Context Budget Profile |
| :--- | :--- | :--- | :--- | :--- |
| **OpenAI Codex / General** | `AGENTS.md` | Session initialization | Open Agent Skills (`SKILL.md`) | High |
| **Claude Code** | `CLAUDE.md` | Automatic on CLI launch | Open Agent Skills (`SKILL.md`) | Moderate / Efficient |
| **Gemini CLI** | `GEMINI.md` | Project root scan | Open Agent Skills (`SKILL.md`) | Very High (1M+ tokens) |
| **Cursor** | `.cursorrules` & `.cursor/rules/*.mdc` | Semantic file-match & glob triggers | MDC Rules & SKILL.md | Moderate |
| **GitHub Copilot** | `.github/copilot-instructions.md` | Workspace instruction scan | Standard Markdown guidance | Compact |
| **Antigravity** | `AGENTS.md` | Root workspace scan | Plugin, Rules, SKILL.md | Very High |

---

## 2. Shared Source of Truth Strategy

To prevent documentation drift and conflicting instructions across agent types:
1. **Zero Knowledge Duplication**: The core rules, engineering standards, and procedures live exclusively in `core/` (7 core files), `rules/` (51 domain rules), `skills/` (35 specialized skills), and `workflows/` (25 structured workflows).
2. **Standardized Catalogs**: Agents reference [`docs/SKILLS_CATALOG.md`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/docs/SKILLS_CATALOG.md) (35 skills index) and [`docs/WORKFLOWS.md`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/docs/WORKFLOWS.md) (25 workflows index) instead of hardcoding procedure lists.
3. **Core Invariants Alignment**: All agent entry points align around the 5 core invariant systems:
   - **Real Data Integrity & Zero Dummy Data** (`docs/REAL_DATA_INTEGRITY.md`, `skills/real-data-integrity/`)
   - **Global Design Consistency** (`docs/DESIGN_SYSTEM_STANDARDS.md`, `skills/design-system/`)
   - **Navigation Clarity & Discoverability** (`docs/NAVIGATION_AND_ICON_STANDARDS.md`, `skills/navigation-clarity/`)
   - **Performance Engineering & Algorithmic Efficiency** (`docs/PERFORMANCE_ENGINEERING_STANDARDS.md`, `skills/performance-engineering/`)
   - **Task Management & Incremental Development** (`docs/TASK_MANAGEMENT_STANDARDS.md`, `skills/task-management/`)
4. **Lightweight Entry Points**:
   - `AGENTS.md`, `CLAUDE.md`, and `GEMINI.md` contain concise routing instructions pointing to the shared layers.
   - Cursor's `.cursor/rules/` files use YAML frontmatter globs (`globs: ["lib/**/*.dart"]`) to load targeted rules only when relevant files are edited.
   - Copilot instructions in `.github/copilot-instructions.md` provide a high-level summary and link to `core/engineering-standards.md`.

---

## 3. Agent-Specific Setup & Behaviors

### Cursor (`.cursorrules` and `.cursor/rules/`)
- **Structure**:
  - `.cursorrules`: Legacy compatibility rule-set loaded globally.
  - `.cursor/rules/*.mdc`: Targeted rule-sets with glob patterns:
    - `dart.mdc`: Triggers on `**/*.dart`.
    - `flutter-ui.mdc`: Triggers on `lib/features/**/presentation/**`, `lib/widgets/**`.
    - `windows.mdc`: Triggers on `windows/**`, `lib/**/windows/**`.
    - `testing.mdc`: Triggers on `test/**/*.dart`.
- **Best Practice**: Use Cursor's `@` symbol in chat to reference specific skills or templates directly (e.g., `@skills/state-management/SKILL.md`).

### Claude Code (`CLAUDE.md`)
- **Structure**:
  - `CLAUDE.md` is strictly optimized for token efficiency. It provides compact shell commands, verification steps, and pointers to `core/` and `skills/`.
  - Commands defined: `flutter analyze`, `flutter test`, `flutter run -d windows`.
- **Best Practice**: Claude Code excels at autonomous loops. Ensure tests exist before launching Claude on refactoring tasks.

### Gemini CLI (`GEMINI.md`)
- **Structure**:
  - `GEMINI.md` leverages Gemini's expansive context window (1M+ tokens) while still enforcing surgical change discipline.
  - Directs Gemini to conduct deep multi-file architectural analysis before applying targeted patches.

### OpenAI Codex & Antigravity (`AGENTS.md`)
- **Structure**:
  - Standardized format aligned with the Open Agent Skills specification.
  - Directs the agent to follow the universal decision hierarchy:
    $$\text{Correctness} > \text{Requirements} > \text{Consistency} > \text{Security} > \text{Token Efficiency}$$

### GitHub Copilot (`.github/copilot-instructions.md`)
- **Structure**:
  - Compact instructions loaded automatically into Copilot Chat and inline completions in VS Code and JetBrains IDEs.
  - Focuses on null safety, clean Dart 3 syntax, avoiding obsolete widgets, and preventing security leaks.

---

## 4. Handling Agent Limitations & Gotchas

| Limitation / Risk | Mitigation in Flutter Agent Kit |
| :--- | :--- |
| **Agent Hallucinates APIs** | Rules strictly ground agents in Dart 3.x and modern Flutter documentation; forbids speculative package imports. |
| **Agent Rewrites Entire Files** | `core/change-discipline.md` strictly bans wholesale file rewrites when targeted edits suffice. |
| **Agent Fakes Verification** | `core/verification-policy.md` explicitly forbids claiming tests passed without running actual CLI commands. |
| **Context Window Exhaustion** | `core/token-efficiency.md` forbids scanning the entire repository; agents read only relevant files. |
| **Agent Weakens Tests** | Rules explicitly forbid deleting or commenting out tests to achieve green builds. |
