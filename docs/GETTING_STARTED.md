# Getting Started with the Flutter Agent Kit

This guide shows you how to integrate and use the **Flutter Agent Kit** with any new or existing Flutter application across all supported AI coding agents.

---

## 1. Quick Integration

You can add the Flutter Agent Kit to your project in two simple ways:

### Option A: Direct Repository Inclusion (Recommended)
Copy the `flutter-agent-kit` directory into your project's root or tools directory:

```bash
# In your Flutter project root
git submodule add https://github.com/your-org/flutter-agent-kit.git .agent-kit
```

Or copy the agent configuration files directly to your project root:
- Copy `AGENTS.md` to your root (for OpenAI Codex, Antigravity, OpenCode).
- Copy `CLAUDE.md` to your root (for Claude Code).
- Copy `GEMINI.md` to your root (for Gemini CLI).
- Copy `.cursorrules` and `.cursor/rules/` to your root (for Cursor).
- Copy `.github/copilot-instructions.md` to `.github/` (for GitHub Copilot).

### Option B: Monorepo / Shared Workspace
Keep `flutter-agent-kit` alongside your projects and instruct your agent to read rules from its absolute path.

---

## 2. Using with Supported AI Agents

### Using with Cursor
1. Ensure `.cursorrules` is at your project root, or copy the `.cursor/rules/` directory into your project.
2. In Cursor Chat (`Ctrl+L` / `Cmd+L`), your agent will automatically reference the relevant rules based on the open file.
3. To trigger a full workflow, prompt:
   ```text
   Follow workflows/existing-project-analysis/WORKFLOW.md and analyze this codebase.
   ```

### Using with Claude Code
1. Ensure `CLAUDE.md` is present in the current working directory.
2. Launch Claude Code:
   ```bash
   claude
   ```
3. Claude Code reads `CLAUDE.md` automatically on startup.
4. To implement a feature:
   ```text
   Read templates/PRD.md and implement the user profile feature using surgical changes.
   ```

### Using with Gemini CLI
1. Ensure `GEMINI.md` is in your project directory.
2. Run your Gemini CLI command:
   ```bash
   gemini "Analyze this project following core/project-understanding.md"
   ```

### Using with OpenAI Codex & Antigravity
1. Ensure `AGENTS.md` is at the root of your workspace.
2. Provide your instructions. The agent reads `AGENTS.md` as its primary operating guide.

### Using with GitHub Copilot
1. Ensure `.github/copilot-instructions.md` exists.
2. Copilot in VS Code / JetBrains automatically includes these instructions in its prompt context.

---

## 3. The 3-Minute Flutter Project Onboarding Workflow

When opening an existing Flutter project with an AI agent:

### Step 1: Initial Discovery (Non-Destructive)
Prompt the agent:
```text
Execute the Existing Project Analysis workflow:
1. Inspect pubspec.yaml to identify SDK constraints and dependencies.
2. Inspect lib/ to determine the state management and architecture.
3. Inspect test/ to check existing test coverage.
4. Report your findings in docs/MEMORY.md without modifying application code.
```

### Step 2: Architecture Alignment
Prompt the agent:
```text
Review docs/ARCHITECTURE.md. All subsequent changes must follow the established state management and layering patterns.
```

### Step 3: Feature Implementation Loop
For each feature:
```text
Implement [Feature Name]:
1. Create a focused plan following core/change-discipline.md.
2. Implement only the required files.
3. Run `flutter analyze` and `flutter test` to verify your changes.
```

---

## 4. Standard Verification Commands

The Agent Kit instructs AI agents to run only the relevant verification commands:

| Action | Recommended Verification Command |
| :--- | :--- |
| **Dart Code Quality** | `flutter analyze` or `dart analyze` |
| **Unit & Widget Tests** | `flutter test` |
| **Targeted Test File** | `flutter test test/features/auth/auth_bloc_test.dart` |
| **Code Coverage** | `flutter test --coverage` |
| **Windows Release Build** | `flutter build windows --release` |
| **MSIX Package Creation** | `dart run msix:create` |
