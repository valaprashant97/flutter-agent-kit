# Vertical Slice Feature Development Prompt

You are acting as a Senior Full-Stack Flutter Engineer guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Feature Name / Task ID**: [TASK_ID / FEATURE_NAME]
- **Target Feature Scope**: [SHORT DESCRIPTION OF FEATURE GOALS]
- **Project Guidelines**: `docs/PRD.md`, `docs/ARCHITECTURE.md`, `docs/DESIGN.md`, `docs/DESIGN_SYSTEM_STANDARDS.md`, and `core/engineering-standards.md`

---

## 2. OBJECTIVE
Implement the specified feature as a complete, vertical slice (Domain $\rightarrow$ Data $\rightarrow$ Presentation/State $\rightarrow$ UI) adhering strictly to the existing codebase patterns, with comprehensive error handling and automated tests.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE CURRENT USER FLOW OR STATE OF THE CODEBASE PRIOR TO THIS FEATURE]

---

## 4. REQUIRED INVESTIGATION
1. Inspect existing models, repositories, and state management controllers in the target domain.
2. Check `pubspec.yaml` to reuse existing packages; do not introduce competing libraries.
3. Review reusable UI components in `lib/core/` before creating custom widgets.

---

## 5. CONSTRAINTS
- Real data only: Never introduce fake sample records, static lists, or fabricated metrics. Connect UI to real database/API streams. Empty states must render honest empty UI with a call-to-action button (`docs/REAL_DATA_INTEGRITY.md`).
- Global design consistency: Adhere to established design tokens (`Theme.of(context)`, `AppSpacing`); reuse existing components in `lib/core/presentation/widgets/`; verify against the 13-point design checklist (`docs/DESIGN_SYSTEM_STANDARDS.md`).
- Respect existing architecture (e.g. BLoC, Riverpod, Provider, or MVVM).
- Touch only files directly related to this vertical slice (`core/change-discipline.md`).
- BuildContext safety invariant: Always verify `if (!context.mounted) return;` after async operations.
- Handle all 4 mandatory UI states: Loading, Success, Empty, and Error.
- Model domain errors as typed sealed classes (`rules/error-handling/domain-errors.md`).

---

## 6. ACCEPTANCE CRITERIA
- [ ] Domain models and entity contracts implemented with sound null safety.
- [ ] Data sources and repository methods return strongly typed `Result<T, Failure>`.
- [ ] State controller handles state transitions and disposes resources cleanly.
- [ ] UI screen renders all states, uses design system tokens, reuses shared components, and avoids layout overflows.
- [ ] 13-point design checklist satisfied.
- [ ] `flutter analyze` passes with 0 warnings and 0 errors.

---

## 7. EDGE CASES
- Network loss during form submission (safe retries or offline queuing).
- Malformed or null fields in backend API response payloads.
- Rapid duplicate user button clicks (debouncing / disabling while loading).
- Window resizing and orientation switching.

---

## 8. TESTING REQUIREMENTS
- Unit tests for repository mapping and state transitions.
- Widget tests verifying UI state rendering and user interaction flows.
- Minimum 85% branch coverage on newly introduced domain and state code.

---

## 9. EXPECTED OUTPUT
1. Concise vertical slice implementation plan.
2. Surgical, clean code additions/edits.
3. Evidence of test and static analysis execution (`flutter test`, `flutter analyze`).
