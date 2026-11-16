# Root Cause Debugging Prompt

You are acting as a Principal Debugging Engineer and Systems Diagnostician guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application**: [APP NAME]
- **Target Platform**: [Windows Desktop, Android, iOS, Web, macOS, Linux]
- **Error Description & Stacktrace**:
  ```text
  [PASTE ERROR MESSAGE, STACKTRACE, OR DIAGNOSTIC LOGS HERE]
  ```

---

## 2. OBJECTIVE
Diagnose the defect, identify the systemic technical root cause, author a minimal reproduction test, apply the smallest safe surgical fix, and verify zero regressions.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE OBSERVED DEFECT, CRASH, HANG, OR ANOMALOUS BEHAVIOR AND STEPS TO REPRODUCE]

---

## 4. REQUIRED INVESTIGATION
1. Trace the stacktrace down to the exact source file and line number.
2. Read surrounding code in concentric rings (`core/token-efficiency.md`).
3. Check recent git history to determine when and why the failing line was modified.

---

## 5. CONSTRAINTS
- Strict surgical changes: Modify only the target lines directly causing the bug (`core/change-discipline.md`).
- Zero symptom masking: Never wrap failing code in generic empty `catch (e) {}` blocks.
- Never weaken or delete existing test assertions to force a test pass.
- Do not refactor adjacent working code or reorganize imports.

---

## 6. ACCEPTANCE CRITERIA
- [ ] Root cause mechanism explained clearly (What failed, Why it failed, How the fix resolves it).
- [ ] Automated reproduction test authored in `test/`.
- [ ] Minimal surgical fix implemented.
- [ ] Reproduction test passes.
- [ ] `flutter analyze` passes with 0 warnings and 0 errors.

---

## 7. EDGE CASES
- Null or unexpected boundary values triggering secondary exceptions.
- Widget unmounted during asynchronous suspension (`!context.mounted`).
- Layout constraint collapse when parent size becomes zero or unbounded.
- Isolate memory boundary violations or unhandled stream cancellation.

---

## 8. TESTING REQUIREMENTS
- Run reproduction test: `flutter test <path_to_reproduction_test>`.
- Run full test suite: `flutter test`.
- Verify static analysis: `flutter analyze`.

---

## 9. EXPECTED OUTPUT
1. Root cause diagnostic report (Mechanism and contributing factors).
2. Reproduction test code.
3. Surgical fix diff.
4. Actual verification command output proving the fix and regression-free test suite.
