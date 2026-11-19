# Project Understanding Protocol

This document defines the mandatory discovery protocol an AI coding agent must execute when onboarding into an existing Flutter project before making any code modifications.

---

## 1. The Non-Destructive Discovery Rule

> [!IMPORTANT]
> **Observation Precedes Modification.**
> When starting in an existing codebase, the agent's first priority is to discover and understand the project's architecture, dependencies, state management approach, conventions, and test suite. Modifying code during the discovery phase is strictly prohibited.

---

## 2. Step-by-Step Discovery Protocol

```mermaid
graph TD
    A[Step 1: Inspect pubspec.yaml] --> B[Step 2: Detect Architecture & Directory Layout]
    B --> C[Step 3: Identify State Management & Data Patterns]
    C --> D[Step 4: Locate Entry Points & App Initialization]
    D --> E[Step 5: Audit Test Coverage & Fixtures]
    E --> F[Step 6: Record Baseline in docs/MEMORY.md]
```

### Step 1: Inspect `pubspec.yaml`
1. **Dart SDK Constraints**: Check the environment sdk constraint (`environment: sdk: ^3.x.y`) to determine supported Dart features.
2. **Core Dependencies**:
   - State management: `flutter_bloc`, `flutter_riverpod`, `provider`, `get`, `mobx`.
   - Routing: `go_router`, `auto_route`, or native `Navigator 2.0`.
   - Networking: `dio`, `http`, `retrofit`.
   - Persistence: `drift`, `hive`, `isar`, `shared_preferences`, `flutter_secure_storage`.
   - Platform packages: `window_manager`, `tray_manager`, `local_notifier`, `win32`.
3. **Dev Dependencies**: Note testing frameworks (`mocktail`, `mockito`, `patrol`, `golden_toolkit`) and code generators (`build_runner`, `freezed`, `json_serializable`).

### Step 2: Detect Architecture & Directory Layout
Inspect `lib/` directory structure:
- **Feature-First Architecture**: `lib/features/<feature_name>/{data, domain, presentation}`.
- **Layer-First Architecture**: `lib/{models, views, controllers, services}`.
- **Clean Architecture**: `lib/core/` alongside independent feature layers with explicit UseCase boundaries.

### Step 3: Identify State Management & Data Patterns
- Locate existing state stores or notifiers.
- Observe how dependencies are injected: `get_it`, `riverpod` providers, or `InheritedWidget`/`Provider`.
- Check how data flows between repositories and the UI.

### Step 4: Locate Entry Points & App Initialization
- Read `lib/main.dart` and `lib/app.dart`.
- Inspect asynchronous initialization: database warming, Firebase initialization, window manager setup, environment configuration loading.

### Step 5: Audit Test Suite
- Check `test/` directory.
- Determine if tests are unit tests, widget tests, or integration tests.
- Identify how test mocks are defined (e.g., `class MockAuthRepository extends Mock implements AuthRepository {}`).

### Step 6: Record Baseline in `docs/MEMORY.md`
Summarize the discovered project architecture, state management library, routing strategy, and known constraints in `docs/MEMORY.md`.

---

## 3. Ambiguity Resolution Protocol

If a project's architecture is ambiguous or mixed:
1. Identify the pattern used in the most recently authored feature files.
2. If multiple conflicting patterns exist, ask the user a single, concise clarification question:
   > *"I noticed this project contains both Provider and BLoC. Should new work on [Feature] follow the BLoC pattern established in `lib/features/auth` or the Provider pattern in `lib/features/settings`?"*
3. Never silently refactor an entire application from one state management library to another.

---

## 4. GitHub Repository & Arbitrary Codebase Discovery Protocol

When tasked with working on an external or remote GitHub repository:

### 4.1 URL Ingestion & Missing URL Handling
- If a GitHub repository URL is provided, validate and parse the target repository.
- **If no URL is provided**: Immediately ask the user for the repository link before attempting any actions. Never guess or hallucinate repository links.

### 4.2 Authorization & Branch Protection
- Confirm write authorization. If access is read-only, plan changes locally as reviewable diffs or patches.
- Never commit or push directly to `main`, `master`, or release branches. Always work on an isolated feature/fix branch (`git checkout -b feat/<task-name>`).

### 4.3 Flexible Flutter Root Discovery
- Never assume `pubspec.yaml` is in the repository root.
- Recursively locate all `pubspec.yaml` files to support monorepos (`apps/*`, `packages/*`) and Melos workspaces.
- Execute all Flutter and Dart tools from the detected Flutter project root directory.

### 4.4 Automated Profiling & Pre-Flight Baseline
- Audit Dart SDK constraint, state management, dependencies, routing, and linter settings (`analysis_options.yaml`).
- Run baseline diagnostics (`flutter pub get`, `flutter analyze`, `flutter test`) to catalog pre-existing warnings before introducing changes.
- Record baseline findings in `docs/MEMORY.md`.

### 4.5 Adaptive Standards Application
- Preserve existing architecture and state management; do not force unrequested rewrites.
- Apply Flutter Agent Kit coding standards (sound null safety, pure `build()`, 4 UI states, mounted checks, resource disposal) within the established project conventions.
- Reference: `docs/GITHUB_REPOSITORY_STANDARDS.md`, `skills/github-repository/`, and `workflows/github-repository/`.
