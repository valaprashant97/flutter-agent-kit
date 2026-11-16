# Workflow: Bug Fixing & Root Cause Remediation

This workflow establishes a strict, 6-step root-cause debugging procedure that treats causes rather than symptoms and avoids collateral regressions.

---

## 1. Entry Conditions
- User reports a defect, crash, unhandled exception, or visual glitch.
- Error log, stacktrace, or reproduction steps are provided.

---

## 2. Step-by-Step Procedure

### Phase 1: Failure Isolation
1. Inspect the stacktrace to pinpoint:
   - Exception class (e.g., `LateInitializationError`, `RangeError`, `TypeError`, `FlutterError`).
   - Exact file name and line number where the exception occurred.

### Phase 2: Root Cause Investigation
1. Trace upstream state transitions that produced the invalid condition.
2. Determine *why* the failure occurred (e.g., async gap unmounted context, missing list bounds check, unexpected null in JSON payload).

### Phase 3: Author Reproduction Test
1. Write a failing unit or widget test in `test/` that reproduces the exact failure.
2. Run the test to confirm it fails:
   ```bash
   flutter test test/path/to/reproduction_test.dart
   ```

### Phase 4: Apply Minimal Surgical Fix
1. Modify only the necessary lines to resolve the root cause.
2. Do NOT refactor adjacent methods, comments, or styling.

### Phase 5: Regression & Build Verification
1. Run the reproduction test to verify it now passes:
   ```bash
   flutter test test/path/to/reproduction_test.dart
   ```
2. Run full test suite and static analysis:
   ```bash
   flutter test
   flutter analyze
   ```

### Phase 6: Report Findings
Summarize:
- What failed.
- Why it failed (root cause).
- Minimal fix applied.
- Verification results.

---

## 3. Exit Criteria
- Reproduction test passes.
- Full test suite is 100% green.
- Zero unrelated code modified.
