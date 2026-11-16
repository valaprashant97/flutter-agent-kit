# Project Memory & Current State (MEMORY.md)

This document tracks the current working state of the codebase, recent milestones, active tasks, known issues, and next steps. Update after completing tasks.

---

## 1. Project Overview & Discovered Architecture
- **Application Name**: [APP_NAME]
- **Target Platforms**: [Windows, Android, iOS, macOS, Linux, Web]
- **Architecture Pattern**: Feature-First Clean Architecture (`lib/features/`)
- **State Management**: [BLoC / Riverpod / Provider]
- **Database**: Drift (SQLite)
- **Networking**: Dio with QueuedInterceptor

---

## 2. Completed Milestones
- [x] Initial project scaffolding & repository setup.
- [x] Core theme tokens & design system configuration.
- [x] Routing setup with declarative GoRouter.

---

## 3. Active Task in Progress
- **Current Task**: [TASK-ID: e.g., TASK-008: Implement Login Screen UI]
- **Working Files**:
  - `lib/features/auth/presentation/pages/login_page.dart`
  - `lib/features/auth/presentation/widgets/login_form.dart`

---

## 4. Known Issues & Technical Debt
- Minor: Skeleton loading animation needs smoothing on slow devices.
- Note: Sideloading MSIX package requires installing the self-signed test certificate.

---

## 5. Immediate Next Steps
1. Complete unit tests for current active task.
2. Run `flutter analyze` and `flutter test`.
3. Proceed to next task in `docs/TASKS.md`.
