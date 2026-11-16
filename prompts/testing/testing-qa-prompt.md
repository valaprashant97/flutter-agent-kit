# Testing & QA Strategy Execution Prompt

You are acting as a Senior QA Automation Engineer and Test Architect guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application**: [APP NAME]
- **Target Feature / Layer**: [PATH TO FEATURE OR CLASS BEING TESTED]
- **Requirements Reference**: `docs/PRD.md`, `docs/ARCHITECTURE.md`, `rules/testing/`

---

## 2. OBJECTIVE
Author and execute a comprehensive automated test suite spanning unit tests, widget tests, golden regression tests, and edge case validations, ensuring 100% test pass rate and high branch coverage.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE CURRENT TEST COVERAGE, UNTESTED CODE PATHS, OR DEFICIENT TEST SUITES]

---

## 4. REQUIRED INVESTIGATION
1. Inspect the code under test to identify public API methods, state streams, and error branches.
2. Check existing tests in `test/` for established mocking patterns (`mocktail` vs `mockito`).
3. Identify external I/O boundaries (HTTP clients, databases, platform channels) requiring mock doubles.

---

## 5. CONSTRAINTS
- Tests in `test/` must never make actual network requests or write to persistent production storage.
- Never weaken assertions (e.g. replacing `expect(x, 42)` with `expect(x, isNotNull)`) to force passing builds.
- Use `tester.pumpAndSettle()` rather than arbitrary `Future.delayed()` sleeps.
- Follow the Arrange-Act-Assert (AAA) pattern strictly.

---

## 6. ACCEPTANCE CRITERIA
- [ ] Unit tests cover domain use cases, view models, and repository mapping.
- [ ] Widget tests verify all 4 UI states: Loading, Success, Empty, and Error.
- [ ] Mocks created cleanly using `mocktail` with fallbacks registered in `setUpAll()`.
- [ ] All tests execute and pass with 0 failures: `flutter test`.
- [ ] `flutter analyze` passes with 0 warnings.

---

## 7. EDGE CASES
- Network timeout and unhandled server 500 error scenarios.
- Empty list returns, null fields, and boundary string lengths.
- Widget unmounting mid-operation (`context.mounted` verification).
- Device rotation or viewport resizing during asynchronous loads.

---

## 8. TESTING REQUIREMENTS
- Execute the test suite with coverage:
  ```bash
  flutter test test/path/to/test.dart --coverage
  ```
- Verify zero skipped or commented-out test assertions.

---

## 9. EXPECTED OUTPUT
1. Test architecture and test matrix breakdown.
2. Complete, runnable test file implementation.
3. Actual console execution output proving 100% test pass rate.
