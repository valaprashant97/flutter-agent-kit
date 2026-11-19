---
name: project-analysis
description: Non-destructive analysis and onboarding protocol for existing Flutter codebases.
---

# project-analysis

## 1. Skill Name
`project-analysis`

## 2. Purpose
Provides a disciplined, read-only onboarding procedure for AI coding agents to discover, trace, and document an existing Flutter project's architecture, dependencies, state management patterns, and test coverage before proposing or applying code modifications.

## 3. When to Use
- When first joining or opening an existing Flutter codebase (local or via a GitHub repository URL).
- When the user asks: "Analyze this project", "What architecture is this app using?", "Inspect this GitHub repo", or "Where should I add this feature?".
- Before proposing any major architectural changes or refactoring.

## 4. When Not to Use
- When creating a brand-new Flutter project from scratch (use `new-project` workflow instead).
- When executing a focused bugfix where the project architecture is already known and documented in `docs/MEMORY.md`.

## 5. Required Project Context
- `pubspec.yaml`
- `lib/` directory listing
- `test/` directory listing
- Existing `README.md` or `docs/` if available

## 6. Step-by-Step Workflow
1. **Audit Dependencies**: Read `pubspec.yaml`. Identify SDK constraints, dependencies, dev_dependencies, and Flutter version constraints.
2. **Classify Architecture**: Check `lib/` directory structure. Determine if it follows Feature-First, Layer-First, Clean Architecture, or an unstructured layout.
3. **Identify State Management**: Check dependencies and imports for BLoC, Riverpod, Provider, GetX, or ChangeNotifier.
4. **Locate Core Contracts**: Find the primary networking client (Dio / HTTP), local database (Drift / Hive / SharedPreferences), and routing solution (`go_router` / Navigator).
5. **Inspect Test Coverage**: Review `test/` for unit, widget, or integration tests to understand existing test conventions.
6. **Synthesize Findings**: Output a concise structured summary and record details in `docs/MEMORY.md`.

## 7. Engineering Rules
- **Read-Only Invariant**: Do NOT modify, delete, format, or generate code during this analysis.
- **Never Assume**: If multiple state management solutions or conflicting patterns exist, document the contradiction and ask for clarification rather than assuming a default.
- **Token Efficiency**: Do NOT read all files in `lib/`. Read top-level directories, entry points (`lib/main.dart`), and sample feature files only.

## 8. Code Examples
```bash
# Non-destructive project status inspection commands
flutter --version
flutter pub deps --style=compact
dart analyze
```

## 9. Common Mistakes
- Silently rewriting files during the initial audit.
- Reading huge generated files (`*.g.dart`, `*.freezed.dart`) that consume the context window without adding architectural insight.
- Assuming an application uses Clean Architecture without verifying the actual folder layout.

## 10. Testing and Verification
- Run `dart analyze` to identify any existing baseline lint issues or errors before starting feature work.
- Run `flutter test` to verify if the baseline test suite currently passes.

## 11. Completion Criteria
- An accurate summary of the project architecture, dependencies, state management, and test suite is delivered to the user.
- Baseline project state is documented in `docs/MEMORY.md`.
- No source code files have been modified.

## 12. Related Skills
- `github-repository` — Ingesting, discovering topology, and profiling remote GitHub repositories
- `flutter-architecture`
- `coding-standards`
- `code-review`
- `testing`
