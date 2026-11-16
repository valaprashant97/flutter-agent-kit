# Workflow: Real Data Integrity Audit & Dummy Data Elimination

This workflow guides an AI coding agent through systematically scanning, auditing, classifying, and eliminating hard-coded dummy data, fabricated metrics, and mock data leaks across a Flutter application, ensuring that all production UI components connect to legitimate, dynamic data sources.

---

## 1. Entry Conditions
- An existing codebase requires a data integrity audit.
- Hardcoded prototype data, static sample records, or fake API responses are suspected in `lib/`.
- Preparing an application for production launch certification.

---

## 2. Step-by-Step Procedure

### Phase 1: Static Codebase Scan for Dummy Data
Search the `lib/` directory for common dummy data anti-patterns:
1. **Static Collections**:
   - Grep for `sample`, `dummy`, `mock`, `fake`, `temp`, `testData`, `placeholder`:
     ```powershell
     Get-ChildItem -Path "lib" -Recurse -Include "*.dart" | Select-String -Pattern "dummy|sample|fake|mockItems|mockData|testUser"
     ```
2. **Hard-Coded Lists in Widgets**:
   - Check `ListView.builder` or `Column` children fed by in-file `List<Model>` constants instead of controllers or repositories.
3. **Random Number Generators in Production Metrics**:
   - Search for `Random().nextInt` or `Random().nextDouble` used in UI widgets or dashboard cards.
4. **Mock Repositories in Production DI**:
   - Verify `get_it` or Riverpod provider registrations do not register `Mock...Repository` in production.
5. **Fake Fallback Handlers**:
   - Search for `catch` blocks in repositories that return static mock lists when remote requests fail.

### Phase 2: Data Classification & Triage
Classify each detected data structure using the 8-tier matrix in `docs/REAL_DATA_INTEGRITY.md`:
- **Legitimate Constants (Keep)**: App theme colors, font scales, route strings, enum values, static dropdown choices (e.g. state/country codes), fixed validation limits.
- **Prohibited Dummy Data (Flag)**: Hardcoded user profiles, fake transaction history, static habit lists, fabricated dashboard percentages.

### Phase 3: Dynamic Data Pipeline Remediation
For every flagged prohibited dummy data structure:
1. **Identify Expected Real Source**: Determine whether the record belongs in the local database (Drift/Isar/Hive), remote API (Dio), or user secure preferences.
2. **Implement Missing Data Layer**:
   - Author or update database table/collection schema.
   - Author DAO query methods (`watchAll()`, `insert()`, `update()`, `delete()`).
   - Wire repository implementation.
3. **Connect UI to Reactive State**:
   - Replace static list with `StreamBuilder`, `BlocBuilder`, or `ref.watch`.
4. **Implement Honest Empty State**:
   - If the database returns 0 records, render a professional empty state with an actionable button (e.g. "Add your first item"). Never insert dummy items to populate the UI.
5. **Implement Real Derived Metrics**:
   - Compute dashboard statistics from actual database records. If insufficient records exist, display an honest "Insufficient data" placeholder.

### Phase 4: Mock Isolation Hygiene
1. Move all mock classes, dummy generators, and JSON fixtures from `lib/` to `test/fixtures/`.
2. Verify that `lib/` contains **zero imports from `test/`**.
3. If an explicit demo mode is required, isolate it under `--dart-define=DEMO_MODE=true` with a persistent visual watermark banner.

### Phase 5: Verification & Automated Testing
1. Author or execute tests verifying:
   - Fresh installation with empty database renders the honest empty state.
   - Creating a record persists to the database and appears in the UI.
   - Terminating and restarting the app preserves saved records.
   - Network failure displays an honest error state, not fake fallback data.
2. Run `flutter analyze` and `flutter test`.

---

## 3. Audit Finding Report Template

Document all findings in the audit report using this structure:

```markdown
### Finding: [TITLE]
- **File Path**: `lib/features/dashboard/presentation/dashboard_screen.dart:45`
- **Data Type**: Dashboard completion metric
- **Current Implementation**: Hard-coded `final completionRate = 0.85;`
- **Actual Expected Source**: Computed from `HabitRepository.watchWeeklyCompletionRate()`
- **Severity**: High (Misleading production metric)
- **Recommended Correction**: Wire `completionRate` to calculate dynamically from actual completed records in SQLite; show "No data yet" if zero habits exist.
- **Remediation Status**: Resolved / Verified
```

---

## 4. Exit Criteria & Quality Gates
- [ ] Zero hard-coded sample records or static arrays exist in production code (`lib/`).
- [ ] All production screens subscribe to real application state controllers.
- [ ] Empty states render honest empty UI with a call-to-action button.
- [ ] Error states report actual failure without substituting fake data.
- [ ] All mock classes and fixtures are isolated exclusively to `test/`.
- [ ] Automated tests verify empty state, real record CRUD, and persistence across restarts.

---

## 5. Related Skills & Rules
- `skills/real-data-integrity/`
- `skills/database-integration/`
- `skills/api-integration/`
- `skills/testing/`
- `core/engineering-standards.md`
- `docs/REAL_DATA_INTEGRITY.md`
