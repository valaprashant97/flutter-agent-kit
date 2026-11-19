# GitHub Copilot Instructions for Flutter & Dart

You are an expert Flutter & Dart engineer assisting with application development under the **Flutter Agent Kit**.

## Code Standards & Single Source of Truth
- All engineering standards derive from `core/engineering-standards.md`.
- Use modern Dart 3.x patterns, records, sealed types, and sound null safety (`rules/dart/`).
- Avoid `dynamic` and never force-unwrap with `!` without prior null checks.
- Always check `if (!context.mounted) return;` after `await` before using `BuildContext`.
- Ensure all asynchronous UI widgets handle Loading, Success, Empty, and Error states (`rules/flutter/`).
- Enforce real data integrity: never introduce fake sample records, static dummy metrics, or mock data fallbacks in production code (`docs/REAL_DATA_INTEGRITY.md`).
- Enforce global design consistency: maintain one coherent visual identity across all screens, consume centralized design tokens, use 4pt/8pt spacing, and satisfy the 13-point design checklist (`docs/DESIGN_SYSTEM_STANDARDS.md`).
- Enforce navigation clarity: maintain 3–5 mobile bottom nav destinations with visible labels, avoid ambiguous icon-only buttons, provide action-descriptive a11y labels, and require confirmation for destructive actions (`docs/NAVIGATION_AND_ICON_STANDARDS.md`).
- Enforce performance engineering: algorithmic efficiency ($O(1)$ lookups, `StringBuffer`), pure `build()` methods, `const` subtrees, granular state rebuilds, resource disposal in `dispose()`, image caching, and isolate offloading (`docs/PERFORMANCE_ENGINEERING_STANDARDS.md`).
- Enforce mandatory 15-phase SDLC & task management: follow the 15-phase SDLC as the default development lifecycle. In Phase 10 (Development), execute sequentially one task at a time following READ -> UNDERSTAND -> PLAN -> IMPLEMENT -> TEST -> REVIEW -> FIX -> DOCUMENT -> VERIFY -> MARK COMPLETED. Decompose tasks in `tasks/TASKS.md`, update `MEMORY.md`, and protect private AI docs via `.gitignore` (`docs/TASK_MANAGEMENT_STANDARDS.md`).
- Enforce unified error handling with dual hooks (`FlutterError.onError`, `PlatformDispatcher.onError`) and typed sealed failures (`rules/error-handling/`).
- Maximize `const` constructor usage across all widget subtrees.
- On Windows desktop, differentiate window closure/minimization from process termination; enforce single-instance mutex and Per-Monitor V2 DPI awareness (`skills/windows-development/`).
- Never hardcode secrets or private API keys. Use `--dart-define` or `.env` files (`rules/security/`).
- Follow the GitHub Repository Protocol: ingest URL, ask if missing, discover Flutter root in monorepos/subfolders, profile architecture, adapt standards to existing conventions without forced rewrites, and work on isolated branches (`docs/GITHUB_REPOSITORY_STANDARDS.md`).
- Touch only the lines directly related to the user request. Avoid unrelated refactoring (`core/change-discipline.md`).
- Follow structured workflows in `docs/WORKFLOWS.md` (26 workflows) and skills in `docs/SKILLS_CATALOG.md` (37 skills).
