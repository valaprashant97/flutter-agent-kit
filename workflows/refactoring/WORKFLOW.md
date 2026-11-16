# Workflow: Refactoring & Technical Debt Reduction

This workflow guides refactoring code to improve readability and maintainability without altering external behavior.

---

## 1. Entry Conditions
- Identified code smell, technical debt, or architectural violation.
- Target code has an existing test suite, or baseline characterization tests can be written first.

---

## 2. Step-by-Step Procedure

### Phase 1: Establish Safety Net
1. Run existing tests to verify baseline green status:
   ```bash
   flutter test test/path/to/target/
   ```
2. If tests do not exist for the module, write **characterization tests** capturing existing behavior before touching production code.

### Phase 2: Incremental Transformation
Apply small, atomic refactorings:
- **Extract Widget**: Break 400-line monolithic build methods into focused, private `StatelessWidget` classes.
- **Extract Method / Class**: Move domain calculations into pure helper functions.
- **Invert Dependencies**: Replace hardcoded `new ApiClient()` with constructor-injected interfaces.

### Phase 3: Step-by-Step Verification
Execute tests after every incremental edit:
```bash
flutter test test/path/to/target/
```
If a test fails, revert the immediate edit and retry cleanly.

### Phase 4: Clean Up Dead Code
1. Remove unused imports and orphaned private methods created by the refactoring.
2. Run static analysis:
   ```bash
   flutter analyze
   ```

---

## 3. Exit Criteria
- Code complexity reduced (smaller methods, decoupled classes).
- 100% of existing tests continue to pass.
- Zero behavior changes introduced.
