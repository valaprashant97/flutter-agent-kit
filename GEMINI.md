# Gemini CLI Guidelines (GEMINI.md)

Operating standards for Gemini CLI in Flutter and Dart development under the **Flutter Agent Kit**.

---

## 1. Operating Tenets

- **Single Source of Truth**: All engineering standards derive from `core/engineering-standards.md`.
- **Leverage Context Responsibly**: While Gemini models possess large context windows, do not dump entire binary builds or generated files (`.dart_tool/`, `build/`, `*.g.dart`). Read in concentric rings (`core/token-efficiency.md`).
- **Deep Architectural Understanding**: Perform multi-file dependency tracing before executing code changes. Respect existing architecture (`core/project-understanding.md`).
- **Surgical Precision**: Output targeted diffs or minimal file modifications. Avoid full file rewrites when editing specific methods (`core/change-discipline.md`).
- **Real Data Integrity**: Never insert dummy records, fake statistics, or mock data fallbacks in production code (`docs/REAL_DATA_INTEGRITY.md`).
- **Global Design Consistency**: Maintain one cohesive visual identity across all screens. Consume global design tokens, 4pt/8pt spacing, and reusable components. Satisfy the 13-point design checklist (`docs/DESIGN_SYSTEM_STANDARDS.md`).
- **Navigation Clarity & Discoverability**: Maintain 3–5 mobile bottom nav destinations with visible labels. Avoid ambiguous icon-only buttons; provide action-descriptive accessibility labels and require confirmation for destructive actions (`docs/NAVIGATION_AND_ICON_STANDARDS.md`).
- **Performance Engineering & Efficiency**: Enforce algorithmic efficiency ($O(1)$ lookups, `StringBuffer`), pure `build()` methods, `const` subtrees, granular state rebuilds, resource disposal in `dispose()`, image caching, and isolate offloading (`docs/PERFORMANCE_ENGINEERING_STANDARDS.md`).
- **Unified Error Handling**: Enforce `FlutterError.onError`, `PlatformDispatcher.onError`, sealed failures, and user-safe error messages (`skills/error-handling/`, `rules/error-handling/`).

---

## 2. Verification Protocol

Always execute and verify the relevant command (`core/verification-policy.md`):
```bash
# Code Quality Check (Zero warnings policy)
flutter analyze

# Test Execution
flutter test

# Windows Release Validation
flutter build windows --release
```

---

## 3. Reference Architecture

- **Core Engineering**: `core/agent-principles.md` and `core/engineering-standards.md`
- **Real Data Integrity**: `docs/REAL_DATA_INTEGRITY.md` and `skills/real-data-integrity/`
- **Design System Standards**: `docs/DESIGN_SYSTEM_STANDARDS.md` and `skills/design-system/`
- **Navigation & Icon Standards**: `docs/NAVIGATION_AND_ICON_STANDARDS.md` and `skills/navigation-clarity/`
- **Performance Engineering Standards**: `docs/PERFORMANCE_ENGINEERING_STANDARDS.md` and `skills/performance-engineering/`
- **Domain Rules**: `rules/` (Dart, Flutter, Architecture, Error Handling, Testing, Platform)
- **Actionable Skills**: `docs/SKILLS_CATALOG.md` (34 specialized skills)
- **Lifecycle Workflows**: `docs/WORKFLOWS.md` (24 structured workflows)
- **Windows Engineering**: `docs/WINDOWS_DEVELOPMENT.md` and `skills/windows-development/`
