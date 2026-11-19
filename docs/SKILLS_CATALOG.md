# Flutter Agent Kit: Skills Catalog

This catalog provides a comprehensive index of all 37 specialized skills included in the **Flutter Agent Kit**. Each skill is packaged in a self-contained directory under `skills/<skill-name>/` and adheres strictly to the open Agent Skills specification with YAML frontmatter and the 12 canonical sections.

---

## Skills Index & Matrix (37 Production Skills)

| Category | Skill Directory | Primary Trigger & Purpose |
| :--- | :--- | :--- |
| **Remote Repository** | [`github-repository`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/github-repository/SKILL.md) | Ingests arbitrary GitHub URLs, verifies authorization, discovers Flutter root across monorepos, auto-detects architecture/state management, and adapts coding standards |
| **Standards** | [`coding-standards`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/coding-standards/SKILL.md) | 8-step Mandatory AI Development Workflow; shared Flutter & Dart coding standards reference (`docs/FLUTTER_CODING_STANDARDS.md`) |
| **Discovery** | [`project-analysis`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/project-analysis/SKILL.md) | Non-destructive audit of existing codebase, dependencies, and patterns |
| **Task Lifecycle** | [`task-management`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/task-management/SKILL.md) | Mandatory 15-phase SDLC, hierarchical task breakdown, in-project documentation, sequential execution, and .gitignore protection |
| **Architecture** | [`flutter-architecture`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/flutter-architecture/SKILL.md) | Layered Clean Architecture, feature-first modularization, service layer |
| **Dart Engineering** | [`dart-best-practices`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/dart-best-practices/SKILL.md) | Idiomatic Dart 3.x, patterns, records, sealed types, concurrency |
| **UI Engineering** | [`ui-implementation`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/ui-implementation/SKILL.md) | Production widget composition, micro-interactions, layouts, loading skeletons |
| **Design System** | [`design-system`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/design-system/SKILL.md) | Global design consistency, 13 color roles, modular spacing, 13-point design checklist, `ThemeExtension` |
| **Animations** | [`animations`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/animations/SKILL.md) | Design, implement, and optimize 60/120fps implicit, explicit, staggered, and physics animations |
| **Custom Graphics** | [`custom-painter`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/custom-painter/SKILL.md) | High-performance 2D drawing, charting, dials, and custom canvas effects |
| **Responsive UI** | [`responsive-design`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/responsive-design/SKILL.md) | Breakpoints, `LayoutBuilder`, multi-pane master-detail desktop layouts |
| **State Management**| [`state-management`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/state-management/SKILL.md) | BLoC, Riverpod, Provider, ValueNotifier selection & refactoring |
| **Navigation** | [`navigation`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/navigation/SKILL.md) | Declarative routing with `go_router`, deep links, authentication guards |
| **Navigation UX** | [`navigation-clarity`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/navigation-clarity/SKILL.md) | Navigation clarity, icon usability, action discoverability, a11y labels |
| **Data Persistence**| [`database-integration`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/database-integration/SKILL.md) | Drift (SQLite), Hive, Isar, schema migrations, and relational integrity |
| **Networking** | [`api-integration`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/api-integration/SKILL.md) | Dio & HTTP clients, auto-retries, caching interceptors, error handling |
| **Error Handling** | [`error-handling`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/error-handling/SKILL.md) | Dual global hooks, typed sealed failures, fallback UI, exponential retries |
| **Data Integrity** | [`real-data-integrity`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/real-data-integrity/SKILL.md) | Prevent dummy data, enforce dynamic real data flow, honest empty states |
| **Security** | [`authentication`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/authentication/SKILL.md) | OAuth, JWT refresh lifecycles, biometric auth, secure token storage |
| **Messaging** | [`notifications`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/notifications/SKILL.md) | Local notifications, background push, Windows toast, action handling |
| **Concurrency** | [`background-execution`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/background-execution/SKILL.md)| Dart Isolates, background workers, long-running processes, task scheduling |
| **Storage & I/O** | [`file-system`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/file-system/SKILL.md) | Cross-platform file I/O, cache directories, PathProvider, sandbox security |
| **Desktop Core** | [`desktop-development`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/desktop-development/SKILL.md) | Desktop layouts, keyboard shortcuts, multi-window, menu bars |
| **Windows Native** | [`windows-development`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/windows-development/SKILL.md) | Single-instance mutex, Per-Monitor V2 DPI, system tray, Win32 interop |
| **Platform Channels**| [`platform-channels`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/platform-channels/SKILL.md) | Pigeon code generation, MethodChannel, EventChannel, native C++ runner |
| **Diagnostics** | [`debugging`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/debugging/SKILL.md) | Root cause isolation, stacktrace symbolization, layout overflow resolution |
| **Quality & Tests** | [`testing`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/testing/SKILL.md) | Unit, widget, golden, integration tests, mocktail fixtures |
| **Golden Tests** | [`golden-testing`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/golden-testing/SKILL.md) | Visual regression testing, multi-theme golden baselines, font mocking |
| **Code Hygiene** | [`code-review`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/code-review/SKILL.md) | Production code review with severity triage: Critical, High, Medium, Low |
| **Security Audit** | [`security-audit`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/security-audit/SKILL.md) | Vulnerability assessment, secret scanning, reverse engineering hardening |
| **Runtime Performance** | [`performance`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/performance/SKILL.md) | DevTools profiling, 60/120 FPS frame budgets, raster jank elimination, rebuild optimization |
| **Algorithmic Efficiency** | [`performance-engineering`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/performance-engineering/SKILL.md) | Big-O time and space complexity, collection pre-indexing, resource disposal, isolate concurrency |
| **A11y** | [`accessibility`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/accessibility/SKILL.md) | Semantics trees, screen readers, accessible contrast, touch target sizes |
| **i18n** | [`localization`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/localization/SKILL.md) | Flutter gen-l10n, ARB translation management, locale switching |
| **Build & Release** | [`packaging`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/packaging/SKILL.md) | Release build optimization, code obfuscation, symbol splitting |
| **Windows Release** | [`msix-release`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/msix-release/SKILL.md) | Windows MSIX packaging, Store manifests, self-signed certificates |
| **Certification** | [`production-readiness`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/skills/production-readiness/SKILL.md)| Pre-flight 50-point audit checklist before store/enterprise submission |

---

## Canonical 12-Section Skill Structure

Every skill adheres to this structure:
1. `1. Skill Name`
2. `2. Purpose`
3. `3. When to Use`
4. `4. When Not to Use`
5. `5. Required Project Context`
6. `6. Step-by-Step Workflow`
7. `7. Engineering Rules`
8. `8. Code Examples`
9. `9. Common Mistakes`
10. `10. Testing and Verification`
11. `11. Completion Criteria`
12. `12. Related Skills`
