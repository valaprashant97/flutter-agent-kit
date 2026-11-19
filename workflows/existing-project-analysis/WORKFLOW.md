# Workflow: Existing Project Analysis & Audit

This workflow defines the non-destructive discovery and onboarding procedure for exploring an unfamiliar Flutter codebase.

---

## 1. Entry Conditions
- Agent is opened in an existing Flutter workspace, OR
- A GitHub repository URL is provided for inspection/audit.
- No prior project documentation or understanding exists in the session.

---

## 2. Step-by-Step Procedure

### Phase 1: Dependency & Environment Audit
1. Read `pubspec.yaml`:
   - Note Dart SDK constraints (Dart 2 vs Dart 3).
   - Identify state management packages (`flutter_bloc`, `flutter_riverpod`, `provider`, `get`).
   - Identify database libraries (`drift`, `hive`, `isar`, `shared_preferences`).
   - Identify networking libraries (`dio`, `http`).
   - Identify platform packages (`window_manager`, `tray_manager`, `win32`).

### Phase 2: Architectural Layout & Data Integrity Discovery
1. List top-level directories in `lib/`:
   - Feature-First (`lib/features/`) vs Layer-First (`lib/models/`, `lib/views/`).
   - Clean Architecture boundaries.
2. Data Integrity & Mock Audit:
   - Inspect models, repositories, and UI data bindings.
   - Classify data using the 8-tier matrix in `docs/REAL_DATA_INTEGRITY.md` to detect hard-coded dummy records, fake dashboard metrics, or mock repositories in `lib/`.

### Phase 3: Bootstrap & Entry Point Inspection
1. Read `lib/main.dart`:
   - Inspect initialization sequence (`WidgetsFlutterBinding.ensureInitialized()`, Firebase, database warming, desktop window options).
   - Locate root widget (`runApp(...)`).

### Phase 4: Test Suite Health Check
1. List files in `test/` and `integration_test/`.
2. Execute non-destructive baseline checks:
   ```bash
   flutter pub deps --style=compact
   flutter analyze
   flutter test
   ```

### Phase 5: Documentation Generation
1. Create or update `docs/MEMORY.md` documenting:
   - Discovered architecture and state management.
   - Active routes and data layers.
   - Baseline test pass/fail rate and any existing warnings.

---

## 3. Exit Criteria
- Complete architectural summary provided to user.
- Data integrity posture and any dummy data classified.
- `docs/MEMORY.md` populated.
- Zero source code modifications made during the audit.

---

## 4. Related Skills & Rules
- `skills/github-repository/`
- `workflows/github-repository/`
- `skills/project-analysis/`
- `skills/real-data-integrity/`
- `docs/GITHUB_REPOSITORY_STANDARDS.md`
- `core/project-understanding.md`
- `docs/REAL_DATA_INTEGRITY.md`

