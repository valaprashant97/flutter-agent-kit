# Real Data Integrity & Zero Dummy Data Audit Prompt

You are acting as a Principal Flutter Architect and Data Integrity Specialist guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application**: [APP NAME & DIRECTORY]
- **Target Platforms**: [Windows Desktop, Android, iOS, Web, macOS, Linux]
- **Standards & Rules Reference**: `docs/REAL_DATA_INTEGRITY.md`, `skills/real-data-integrity/`, `core/engineering-standards.md`

---

## 2. OBJECTIVE
Conduct an exhaustive codebase audit to detect and eliminate hard-coded dummy data, static sample records, fake dashboard metrics, mock API responses, and test data leaks in `lib/`, ensuring that all UI components connect reactively to genuine data sources with honest empty and error states.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE CURRENT SCREEN RENDERING, SUSPECTED DUMMY RECORDS, HARDCODED METRICS, OR MOCK DATA LEAKS]

---

## 4. REQUIRED INVESTIGATION
1. Scan `lib/` for static item lists (e.g. `final sampleItems = [...]`), fake user profiles, and mock repositories.
2. Check dashboard cards and charts for hard-coded statistics or `Random()` number generators.
3. Review API and database repositories for fallback handlers that return fake 200 OK data on failure.
4. Classify detected values using the 8-tier matrix in `docs/REAL_DATA_INTEGRITY.md` (distinguishing legitimate enums and theme constants from prohibited dummy records).

---

## 5. CONSTRAINTS
- Zero dummy data in production: Never insert fake records to make an empty screen look populated.
- When no data exists, display an honest empty state with a call-to-action button.
- All dashboard metrics and percentages must be calculated from real data.
- Mock classes and test fixtures must be isolated strictly to `test/`.
- Do not flag or delete legitimate configuration constants (theme colors, enums, fixed validation rules).
- Do not break existing working code; implement real database/API connections surgical and clean.

---

## 6. ACCEPTANCE CRITERIA
- [ ] All hard-coded sample records removed from production code in `lib/`.
- [ ] UI components subscribe reactively to actual application state or database DAOs.
- [ ] Genuine CRUD operations implemented and tested.
- [ ] Empty state displays an honest, professional message with an action to create the first record.
- [ ] Error states report actual failures with working retry buttons (zero fake success).
- [ ] Saved data persists across complete application process restart.
- [ ] Passes `flutter analyze` with 0 warnings.

---

## 7. EDGE CASES
- App launched for the very first time with an empty database (must show honest empty state).
- Partial data available (e.g. 1 completed session out of 5 required for a trend line; must show "Insufficient data" state).
- Network drops mid-operation (must report error honestly without falling back to mock data).
- Rapid user input and concurrency race conditions during local database writes.

---

## 8. TESTING REQUIREMENTS
- Automated test verifying that an empty database renders the honest empty state.
- Automated test verifying that adding a record via the UI persists it to disk and survives app restart.
- Automated test verifying that API failures render an error banner, not fake success data.
- Verify zero imports from `test/` exist inside `lib/`.

---

## 9. EXPECTED OUTPUT
1. Audit Findings Report (File path, Data type, Current implementation, Expected source, Severity, Recommended correction).
2. Surgical code remediation replacing dummy data with real reactive data pipelines.
3. Automated test execution results proving honest empty states, real CRUD persistence, and restart survival.
