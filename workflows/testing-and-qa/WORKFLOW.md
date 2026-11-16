# Workflow: Testing & Quality Assurance (QA)

This workflow establishes an end-to-end testing protocol across unit, widget, golden visual, and integration levels with strict real-data integrity verification.

---

## 1. Entry Conditions
- Newly developed feature, major bugfix, or pre-release candidate requiring verification.

---

## 2. Step-by-Step Procedure

### Phase 1: Unit Test Suite
1. Target pure domain logic, entities, and state reducers.
2. Structure tests using AAA pattern (Arrange, Act, Assert).
3. Mock external dependencies using `mocktail`.
4. Run unit tests:
   ```bash
   flutter test test/unit/
   ```

### Phase 2: Widget & Component Tests
1. Test UI component rendering, text formatting, and interactive callbacks.
2. Verify behavior under all 4 states: Loading, Success, Empty (honest empty state with action), and Error (honest error state with retry).
3. Verify tap, scroll, and text entry with `WidgetTester`.
4. Run widget tests:
   ```bash
   flutter test test/widgets/
   ```

### Phase 3: Integration, Real Data & E2E Tests
1. Test complete user journeys (e.g. Login -> Add Item -> Persist -> Restart -> Verify).
2. Verify that mock fixtures are 100% isolated to `test/` and never leak into `lib/` (`docs/REAL_DATA_INTEGRITY.md`).
3. Run integration tests:
   ```bash
   flutter test integration_test/
   ```

### Phase 4: Coverage Analysis
1. Run test suite with coverage collection:
   ```bash
   flutter test --coverage
   ```
2. Inspect `coverage/lcov.info` to identify untested critical business paths.

---

## 3. Exit Criteria
- Critical business logic has automated test coverage.
- Real data integrity verified: empty states, real CRUD, restart persistence, and failure handling tested.
- Zero mock fixtures leak into production code (`lib/`).
- All test suites execute cleanly with 0 failures and 0 errors.

---

## 4. Related Skills & Rules
- `skills/real-data-integrity/`
- `skills/testing/`
- `skills/golden-testing/`
- `docs/REAL_DATA_INTEGRITY.md`
