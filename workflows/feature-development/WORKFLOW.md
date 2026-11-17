# Workflow: Feature Development (Vertical Slice)

This workflow defines the vertical-slice implementation strategy for building new features safely and incrementally.

---

## 1. Entry Conditions
- User requests a new feature or picks an approved item from `docs/TASKS.md`.
- `docs/ARCHITECTURE.md` and `docs/DESIGN.md` are accessible.

---

## 2. Step-by-Step Procedure

### Phase 1: Context Isolation
Read only the files directly related to the feature:
- Existing feature models or entities
- Direct dependency contracts
- Target route location

### Phase 2: Implementation Plan
Formulate a minimal plan:
- Slice 1: Domain entity & repository interface
- Slice 2: Data source & repository implementation
- Slice 3: State controller / BLoC
- Slice 4: Presentation UI widget & route entry

### Phase 3: Vertical Slice Execution
1. **Domain Layer**: Author immutable entity in `domain/entities/` and contract in `domain/repositories/`.
2. **Data Layer**: Author DTO in `data/models/` and implement repository in `data/repositories/`.
3. **State Layer**: Author BLoC/Notifier in `presentation/bloc/` or `controllers/`.
4. **Presentation Layer**:
   - Compose UI widgets in `presentation/widgets/` and `presentation/pages/`.
   - Connect UI reactively to real repository/database streams. Zero dummy data (`docs/REAL_DATA_INTEGRITY.md`).
   - Adhere strictly to the global design system: consume `Theme.of(context).colorScheme`, `TextTheme`, and `AppSpacing` tokens; reuse shared widgets from `lib/core/presentation/widgets/` (`docs/DESIGN_SYSTEM_STANDARDS.md`).
   - Explicitly implement the 4 mandatory states: Loading, Success, Empty (honest message with call-to-action; never insert fake items), and Error (honest message with Retry button).
   - Enforce performance engineering standards: pure `build()` methods, `const` subtrees, granular state selectors, resource disposal in `dispose()`, and algorithmic complexity assessment (`docs/PERFORMANCE_ENGINEERING_STANDARDS.md`).
   - Register route in `lib/core/routing/app_router.dart`.
   - Verify compliance against the 13-point design checklist and 15-point performance checklist.

### Phase 4: Automated Testing
1. Add unit test for state transitions in `test/features/<feature>/`.
2. Add widget test for critical interactions (tap, validation, empty state, error view).
3. Add persistence test verifying data survives app restart.

### Phase 5: Verification & Review
```bash
flutter analyze
flutter test test/features/<feature>/
```

---

## 3. Exit Criteria
- Feature works end-to-end across all 4 UI states with genuine data.
- Zero hardcoded sample records or fake metrics introduced.
- Visuals adhere to `docs/DESIGN.md` and satisfy the 13-point design checklist.
- Performance adheres to `docs/PERFORMANCE_ENGINEERING_STANDARDS.md` and satisfies the 15-point checklist.
- Saved data persists across complete application process restart.
- All new and existing tests pass.
- `flutter analyze` reports 0 errors and 0 warnings.
- `docs/TASKS.md` updated with completed item.

---

## 4. Related Skills & Rules
- `skills/real-data-integrity/`
- `skills/design-system/`
- `skills/performance-engineering/`
- `skills/ui-implementation/`
- `skills/flutter-architecture/`
- `skills/database-integration/`
- `skills/api-integration/`
- `docs/REAL_DATA_INTEGRITY.md`
- `docs/DESIGN_SYSTEM_STANDARDS.md`
- `docs/PERFORMANCE_ENGINEERING_STANDARDS.md`

