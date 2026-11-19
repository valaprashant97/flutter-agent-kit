---
name: github-repository
description: End-to-end GitHub repository onboarding, dynamic topology inspection, architecture and state management auto-detection, non-destructive audit, surgical standards application, and verification across any arbitrary Flutter codebase.
---

# github-repository

## 1. Skill Name
`github-repository`

## 2. Purpose
Empowers AI coding agents to work autonomously and safely with **any arbitrary GitHub repository URL**. Provides a structured, reusable lifecycle to ingest a repository link, verify permissions, discover repository topology (including monorepos and nested Flutter subdirectories), auto-detect the existing architecture and state management approach, adapt coding standards to existing conventions without forced rewrites, run verification commands, and deliver structured progress reports.

## 3. When to Use
- When given a GitHub repository URL (HTTPS or SSH) to implement a feature, fix a bug, or perform an audit.
- When the user asks to work on an external Flutter project on GitHub.
- When an onboarding task requires inspecting a remote Flutter repository without prior knowledge of its folder layout or state management.
- When the user asks: "Analyze this GitHub repo", "Clone and add a feature from this URL", or "Refactor this repository".

## 4. When Not to Use
- When working within an already open local workspace where no remote GitHub repository is referenced.
- When creating a brand-new Flutter project from scratch without an existing repository (use `workflows/new-project/`).
- When the user explicitly restricts all network access or Git operations.

## 5. Required Project Context
- GitHub Repository URL (HTTPS or SSH) or GitHub CLI slug (`owner/repo`).
- Authorization status (read-only vs write permissions, target working branch).
- Discovered `pubspec.yaml` (root, `apps/*`, or `packages/*`).
- Target task description (feature, bugfix, or refactor).
- Reference: `docs/GITHUB_REPOSITORY_STANDARDS.md` and `docs/FLUTTER_CODING_STANDARDS.md`.

## 6. Step-by-Step Workflow

Every GitHub repository task follows this 8-step lifecycle:

### Step 1 — Ingest URL & Request if Missing
- Check if a valid GitHub repository URL was provided.
- **If missing**: Immediately ask the user for the GitHub link before proceeding. Never guess or fabricate repository URLs.
- Parse URL format (HTTPS or SSH) and identify owner and repository name.

### Step 2 — Verify Authorization & Access Mode
- Verify permissions: Read-only access vs push/write access.
- Confirm target branch strategy: Never push directly to default branches (`main`/`master`). Always plan to work on a feature branch (`feat/<name>` or `fix/<name>`).
- If write access is unauthorized, operate locally and provide clean Git patches or pull request branch instructions.

### Step 3 — Clone & Ingest Repository
- Clone the repository into an isolated workspace directory:
  ```bash
  git clone --depth 50 <REPO_URL> <TARGET_DIR>
  cd <TARGET_DIR>
  ```
- Inspect Git status, remote URLs, and existing branches.

### Step 4 — Dynamic Topology & Flutter Root Discovery
- Search for `pubspec.yaml`:
  - Check repository root.
  - If not at root, search `apps/`, `packages/`, or inspect `melos.yaml`.
- Set the active working directory to the discovered Flutter project root.
- Verify Flutter SDK constraints in `pubspec.yaml` (Dart 2 vs Dart 3).

### Step 5 — Automated Codebase Profiling
- **Architecture**: Inspect `lib/` layout (Feature-First, Layer-First, Clean Architecture, or MVC).
- **State Management**: Identify dominant library (`flutter_bloc`, `flutter_riverpod`, `provider`, `get`, `mobx`, `signals`, or `ValueNotifier`).
- **Dependencies**: Locate networking (`dio`/`http`), local storage (`drift`/`hive`/`shared_preferences`), and routing (`go_router`/`Navigator`).
- **Design & Linter**: Inspect `analysis_options.yaml` and existing shared widgets in `lib/`.
- Record discovered profile in `docs/MEMORY.md`.

### Step 6 — Baseline Pre-flight Diagnostics
- Run non-destructive baseline checks from the Flutter root:
  ```bash
  flutter pub get
  flutter analyze
  flutter test
  ```
- Record any pre-existing analysis warnings or test failures to ensure the agent does not take blame for legacy issues.

### Step 7 — Adaptive Surgical Implementation
- Checkout a new working branch:
  ```bash
  git checkout -b feat/<task-name>
  ```
- Implement changes adhering strictly to:
  - Discovered architecture and state management (do not introduce foreign libraries).
  - Existing naming conventions and code formatting.
  - Flutter coding standards (4 UI states, pure `build()`, mounted checks, resource disposal).
- Touch only the files required for the task.

### Step 8 — Verification & Standardized Reporting
- Run verification pipeline:
  ```bash
  dart format --output=none --set-exit-if-changed .
  flutter analyze
  flutter test
  ```
- Verify 0 new warnings and 100% test pass rate.
- Generate structured report following `docs/GITHUB_REPOSITORY_STANDARDS.md`.

---

## 7. Engineering Rules

- **URL Request Invariant**: If no GitHub URL is supplied for a remote repository request, ask for it immediately. Never assume a fixed repo.
- **Topology Flexibility**: Never assume the Flutter app is at the root. Always discover the exact path to `pubspec.yaml`.
- **Zero Architectural Churn**: Follow the project's existing architecture and state management. Never force a rewrite to Clean Architecture or BLoC if the project uses Layer-First or Provider.
- **Branch Protection**: Never commit or push directly to `main` or `master`. Always work on a dedicated branch.
- **Surgical Discipline**: Only edit files directly related to the user's objective. Do not reformat unrelated files.
- **Strict Verification**: Execute real CLI verification commands (`dart format`, `flutter analyze`, `flutter test`) in the target Flutter root. Never claim passes without running commands.

---

## 8. Code Examples

### Dynamic Flutter Root Discovery & Execution
```bash
# Locate pubspec.yaml anywhere in the repo
Get-ChildItem -Path . -Filter "pubspec.yaml" -Recurse | Select-Object FullName

# Navigate to discovered Flutter root and sync dependencies
cd apps/mobile_app
flutter pub get

# Create feature branch
git checkout -b feat/user-auth-flow
```

### Standardized GitHub Execution Report
```markdown
## GitHub Repository Task Report

- **Repository**: `https://github.com/acme/mobile-app`
- **Discovered Flutter Root**: `apps/client`
- **Architecture**: Layer-First with Provider
- **Branch**: `feat/refresh-user-profile`

### Changes Made
- Modified `lib/services/user_service.dart`: Added caching layer.
- Modified `lib/screens/profile_screen.dart`: Handled Loading, Error, Empty, and Success states.
- Added `test/services/user_service_test.dart`: Unit tests with mocktail.

### Verification Results
- `dart format`: 0 unformatted files
- `flutter analyze`: 0 new warnings (2 pre-existing warnings in legacy files noted)
- `flutter test`: All 8 tests passed
```

---

## 9. Common Mistakes

| Mistake | Correct Approach |
| :--- | :--- |
| Assuming `pubspec.yaml` is always in the root directory | Search subdirectories (`apps/`, `packages/`) for monorepos |
| Rewriting an existing Provider app into BLoC | Respect and extend the existing state management solution |
| Guessing a repository URL when none was provided | Ask the user directly for the GitHub link |
| Modifying code on the `main` or `master` branch | Always create a dedicated branch (`git checkout -b feat/...`) |
| Blaming changes for pre-existing linter warnings | Run a pre-flight `flutter analyze` baseline before changing code |
| Forgetting `if (!context.mounted) return;` across async gaps | Always verify context mounting before using `BuildContext` |

---

## 10. Testing and Verification

From the discovered Flutter project root, execute:
```bash
# 1. Format check
dart format --output=none --set-exit-if-changed .

# 2. Static analysis
flutter analyze

# 3. Unit & widget tests
flutter test

# 4. Git diff audit
git status --short
git diff --stat
```

---

## 11. Completion Criteria

A GitHub repository task is complete only when:
- [ ] GitHub URL successfully ingested and topology discovered.
- [ ] Architecture, state management, and dependencies profiled and recorded in `docs/MEMORY.md`.
- [ ] Pre-flight baseline established before modifying code.
- [ ] Changes implemented following existing project conventions on an isolated branch.
- [ ] 4 UI states handled for all modified asynchronous UI screens.
- [ ] `dart format` passes cleanly.
- [ ] `flutter analyze` introduces 0 new warnings.
- [ ] All new and existing tests pass cleanly.
- [ ] Standardized GitHub execution summary reported to the user.

---

## 12. Related Skills

| Skill | Purpose |
| :--- | :--- |
| `coding-standards` | Shared Flutter & Dart coding standards and 8-step AI workflow |
| `project-analysis` | Non-destructive codebase discovery and dependency tracing |
| `flutter-architecture` | Layered Clean Architecture and Feature-First modularization |
| `state-management` | Selection, refactoring, and conventions for BLoC/Riverpod/Provider |
| `testing` | Unit, widget, and integration test authoring |
| `code-review` | Severity-based triage and quality verification |
| `production-readiness` | 50-point pre-flight launch checklist |
