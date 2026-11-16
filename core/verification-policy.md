# Verification Policy & Proof of Work

This document establishes the mandatory verification protocol for certifying that a Flutter task, fix, or feature is production-ready.

---

## 1. The Proof-of-Work Standard

> [!CAUTION]
> **Never Fabricate Successful Verification.**
> An AI agent must never declare a task complete, nor state that tests passed, without executing the relevant CLI commands and receiving clean exit codes. If an environment limitation prevents running tests, state clearly: *"Code implemented, but automated tests could not be executed due to [Reason]."*

---

## 2. Tiered Verification Hierarchy

Not every task requires running the full test suite or compiling a release binary. Execute only the relevant verification commands:

| Scope of Change | Mandatory Verification Commands | Exit Requirement |
| :--- | :--- | :--- |
| **Logic or Widget Edit** | `flutter analyze`<br>`flutter test <path_to_test>` | Exit code 0, 0 issues, all tests pass |
| **Refactoring or Dependency Update** | `flutter analyze`<br>`flutter test` | Exit code 0, full test suite green |
| **Native Platform Change (Windows)** | `flutter build windows --debug` or `--release` | Clean compilation with 0 linker/C++ errors |
| **Package / Pubspec Update** | `flutter pub get`<br>`flutter analyze` | Clean dependency resolution, no version conflicts |

---

## 3. Strict Rules on Test Integrity

1. **Never Delete or Comment Out Tests**: If an existing test fails after your changes, investigate why. Fix the underlying implementation or update the test only if the business requirement explicitly changed.
2. **Never Weaken Assertions**: Do not change `expect(result, equals(expected))` to `expect(result, isNotNull)` merely to bypass a failing test.
3. **No Flaky Test Hacks**: Do not add artificial `Future.delayed(Duration(seconds: 5))` to patch race conditions. Use proper pump cycles (`tester.pumpAndSettle()`) or synchronous stream controllers.

---

## 4. Failure Triage Protocol

When a verification command fails:
1. **Read the Full Error**: Inspect the exact line number, exception type, and stacktrace.
2. **Diagnose Root Cause**: Differentiate between:
   - Compile-time syntax/type errors (`dart analyze`).
   - Assertion failures in unit tests (`flutter test`).
   - Native C++ or platform compilation errors (`flutter build windows`).
3. **Apply Minimal Fix**: Fix the root cause with surgical precision.
4. **Re-execute**: Run the failing verification command again to confirm the fix.
