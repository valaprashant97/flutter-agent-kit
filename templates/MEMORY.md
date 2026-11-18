# Project Memory & Execution State (MEMORY.md)

# [PROJECT / APPLICATION NAME]

**Memory Version**: 1.0.0  
**Current Phase**: Phase 1: Project Foundation  
**Active Task**: None (Ready to begin TASK-001)  
**Last Updated**: [YYYY-MM-DD]  

---

## 1. Project Context & Discovered Architecture

- **Project Name**: [Project Name]
- **Technology Stack**: [Flutter / Dart / React / Next.js / Node.js / Python]
- **Target Platforms**: [Windows Desktop, Android, iOS, macOS, Linux, Web]
- **Architecture Pattern**: [Feature-First Clean Architecture / Modular / MVVM]
- **State Management**: [BLoC / Riverpod / Provider / ValueNotifier]
- **Local Persistence**: [Drift SQLite / Isar / Hive / SecureStorage]
- **Networking**: [Dio / Http with Interceptors]
- **Source Directory**: `lib/` (or `src/`)
- **Test Directory**: `test/` (or `tests/`)

---

## 2. Phase Execution Status

| Phase | Phase Name | Total Tasks | Completed | In Progress | Status |
| :---: | :--- | :---: | :---: | :---: | :--- |
| **01** | Project Foundation & Baseline | 4 | 0 | 0 | Not Started |
| **02** | Data Architecture & Authentication | 5 | 0 | 0 | Not Started |
| **03** | Core Domain Features (Vertical Slices) | 5 | 0 | 0 | Not Started |
| **04** | Platform Specialization & UX Polish | 4 | 0 | 0 | Not Started |
| **05** | Hardening, Certification & Release | 4 | 0 | 0 | Not Started |

---

## 3. Completed Phases & Milestones

- *No phases completed yet.*

---

## 4. Completed Tasks Log

| Task ID | Task Title | Completed Date | Verification Proof | Key Deliverable |
| :--- | :--- | :---: | :--- | :--- |
| *None* | — | — | — | — |

---

## 5. Active Task

- **Task ID**: [None / In Progress Task ID]
- **Title**: [Task Title]
- **Objective**: [Concise goal of current task]
- **Working Files**:
  - `path/to/file1.dart`
  - `path/to/file2.dart`
- **Current Step**: [e.g. Inspecting existing models]

---

## 6. Pending Tasks in Current Phase

- [ ] `TASK-001`: Analyze Existing Codebase & Establish Baseline Architecture
- [ ] `TASK-002`: Configure Core Design Tokens & Theme System
- [ ] `TASK-003`: Configure Declarative Routing & Navigation Guards
- [ ] `TASK-004`: Baseline Health Verification & Linter Hardening

---

## 7. Important Implementation Details & Architectural Invariants

- **Zero Dummy Data**: All UI screens must handle real data flow. Empty states must render an honest call-to-action button; never use hardcoded mock lists.
- **Design System First**: Consume `Theme.of(context).colorScheme`, `TextTheme`, and `AppSpacing` (4pt/8pt grid). Zero hardcoded hex colors or arbitrary paddings.
- **Navigation Clarity**: Maintain 3–5 mobile bottom nav destinations with visible text labels. Unambiguous icons only; action-descriptive accessibility semantics.
- **Performance Engineering**: Keep `build()` methods pure, enforce `const` constructors, use granular state rebuild selectors (`context.select`), and explicitly dispose controllers in `dispose()`.
- **Error Handling**: Register dual global exception hooks (`FlutterError.onError` + `PlatformDispatcher.onError`); map domain exceptions to typed sealed failures.

---

## 8. Known Issues, Blockers & Technical Debt

- *No active blockers.*
- *Technical Debt*: Document any temporary compromises or items requiring future refactoring.

---

## 9. Next Recommended Action

1. Select `TASK-001` from `tasks/TASKS.md` (or `TASKS.md`).
2. Inspect relevant codebase files without modifying application logic.
3. Record findings in this document.
