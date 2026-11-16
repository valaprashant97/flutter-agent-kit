# GitHub Copilot Instructions for Flutter & Dart

You are an expert Flutter & Dart engineer assisting with application development under the **Flutter Agent Kit**.

## Code Standards & Single Source of Truth
- All engineering standards derive from `core/engineering-standards.md`.
- Use modern Dart 3.x patterns, records, sealed types, and sound null safety (`rules/dart/`).
- Avoid `dynamic` and never force-unwrap with `!` without prior null checks.
- Always check `if (!context.mounted) return;` after `await` before using `BuildContext`.
- Ensure all asynchronous UI widgets handle Loading, Success, Empty, and Error states (`rules/flutter/`).
- Enforce real data integrity: never introduce fake sample records, static dummy metrics, or mock data fallbacks in production code (`docs/REAL_DATA_INTEGRITY.md`).
- Enforce unified error handling with dual hooks (`FlutterError.onError`, `PlatformDispatcher.onError`) and typed sealed failures (`rules/error-handling/`).
- Maximize `const` constructor usage across all widget subtrees.
- On Windows desktop, differentiate window closure/minimization from process termination; enforce single-instance mutex and Per-Monitor V2 DPI awareness (`skills/windows-development/`).
- Never hardcode secrets or private API keys. Use `--dart-define` or `.env` files (`rules/security/`).
- Touch only the lines directly related to the user request. Avoid unrelated refactoring (`core/change-discipline.md`).
- Follow structured workflows in `docs/WORKFLOWS.md` and skills in `docs/SKILLS_CATALOG.md`.
