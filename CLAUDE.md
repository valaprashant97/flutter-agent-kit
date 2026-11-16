# Claude Code Guidelines (CLAUDE.md)

Guidelines for Claude Code CLI operating in Flutter and Dart codebases under the **Flutter Agent Kit**.

---

## 1. Core Operating Principles

- **Single Source of Truth**: All engineering standards derive from `core/engineering-standards.md`.
- **Think Before Coding**: State assumptions upfront. Inspect existing architecture before generating diffs (`core/project-understanding.md`).
- **Simplicity First**: Write the minimum code that solves the problem. No speculative abstractions.
- **Surgical Changes**: Modify only the target lines. Never reformat, clean up, or refactor adjacent working code (`core/change-discipline.md`).
- **Verify Real Output**: Run real CLI commands before claiming success (`core/verification-policy.md`).

---

## 2. Essential Commands

| Task | Command |
| :--- | :--- |
| **Analyze Dart Code** | `flutter analyze` or `dart analyze` |
| **Run All Tests** | `flutter test` |
| **Run Targeted Test** | `flutter test test/path/to/test_file.dart` |
| **Test with Coverage** | `flutter test --coverage` |
| **Run Windows Desktop** | `flutter run -d windows` |
| **Build Windows Release** | `flutter build windows --release` |
| **Create MSIX Installer** | `dart run msix:create` |

---

## 3. Strict Rules & Invariants

- **Zero Fabricated Verification**: Never claim tests passed without executing `flutter test` or `flutter analyze`.
- **Never Delete or Relax Tests**: Fix the underlying defect instead of deleting or weakening assertions.
- **Unified Error Handling**: Enforce dual global handlers (`FlutterError.onError`, `PlatformDispatcher.onError`) and typed sealed failures (`rules/error-handling/`).
- **BuildContext Safety**: Always verify `if (!context.mounted) return;` after `await` before using `context`.
- **UI States & Real Data Only**: Every asynchronous UI widget must handle Loading, Success, Empty, and Error states honestly. Never insert fake dummy records or fabricated metrics (`docs/REAL_DATA_INTEGRITY.md`).
- **Windows Lifecycle**: Differentiate window minimization to tray from process termination; enforce single-instance mutex and Per-Monitor V2 DPI awareness.
- **Skills & Workflows**: Consult `docs/SKILLS_CATALOG.md` (32 skills) and `docs/WORKFLOWS.md` (21 workflows).
