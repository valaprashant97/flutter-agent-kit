---
name: coding-standards
description: Professional Flutter & Dart coding standards, 8-step mandatory AI development workflow, and quality guidelines for consistent, production-grade implementation across all Flutter projects.
---

# coding-standards

## 1. Skill Name
`coding-standards`

## 2. Purpose
Establishes a **single shared reference** for all Flutter & Dart coding standards used by AI agents. Ensures consistent, professional, production-grade code quality across all features, refactors, and agent sessions. Integrates the 8-step Mandatory AI Development Workflow into every coding task.

## 3. When to Use
- When beginning **any** new Flutter feature, file, or refactor.
- During code review to validate compliance with standards.
- When an AI agent is unsure which pattern or convention to follow.
- When onboarding to a project — read this skill first, before writing any code.
- When reviewing another agent's output for quality issues.

## 4. When Not to Use
- For project-specific architecture design decisions → use `flutter-architecture`.
- For debugging active runtime errors → use `debugging`.
- For release packaging → use `production-readiness` or `packaging`.
- When an existing project has an established convention that conflicts — **prefer existing project consistency** over forcing a new standard.

## 5. Required Project Context
- `pubspec.yaml` — Dart SDK version, dependencies, platform targets
- `analysis_options.yaml` — lint rules and severity configuration
- `docs/FLUTTER_CODING_STANDARDS.md` — comprehensive shared standards reference (all 12 areas)
- `docs/GITHUB_REPOSITORY_STANDARDS.md` — GitHub repository ingestion and adaptation protocol
- `core/engineering-standards.md` — single source of truth for architectural invariants

## 6. Step-by-Step Workflow

Every AI coding session **must** follow this 8-step Mandatory AI Development Workflow:

### Step 1 — INSPECT
Read the existing project before writing a single line:
- If a GitHub repository URL is provided: clone/access it, ask for the link if missing, and discover the Flutter root (root, `apps/*`, or `packages/*`).
- `pubspec.yaml` (SDK version, existing dependencies, platforms)
- Folder structure (`lib/`, `test/`, `analysis_options.yaml`)
- Existing architecture (feature-first? layered? monolith?)
- State management in use (BLoC? Riverpod? Provider? ValueNotifier?)
- Existing shared widgets in `lib/core/presentation/widgets/`

### Step 2 — ANALYZE
Understand **conventions, patterns, and constraints** before proposing changes:
- Identify the existing naming patterns, file naming style, and code organization.
- Note which packages are already in use — do not add redundant alternatives.
- Identify any project-specific rules in `AGENTS.md`, `core/`, or `docs/`.
- Never assume a blank slate. Every project has existing patterns.

### Step 3 — PLAN
Define the **minimal correct change**:
- For small tasks (< 1 hour): describe the change in a comment or inline.
- For large tasks: create/update `tasks/TASKS.md` with a 13-field task schema.
- Identify: files to create, files to modify, files to leave untouched.
- Plan the data flow: entity → repository → state → UI.

### Step 4 — IMPLEMENT
Write code that conforms to all 12 areas of `docs/FLUTTER_CODING_STANDARDS.md`:
- Dart Standards: null safety, typed models, `const`, sealed classes.
- Widget Standards: `StatelessWidget` by default, 4 UI states, `mounted` checks.
- State: immutable, granular rebuilds, no logic in `build()`.
- Error handling: typed failures, global hooks, user-safe messages.
- Security: no hardcoded secrets, `flutter_secure_storage` for tokens.

### Step 5 — TEST
Write or verify tests covering all relevant cases:
- **Unit tests** for domain logic, repositories, and utilities.
- **Widget tests** for each of the 4 UI states (Loading / Success / Empty / Error).
- **Integration tests** for critical user flows.
- Use `mocktail` for all mocking — no real HTTP/DB in unit tests.
- Regression test: every fixed bug gets a test that fails without the fix.

### Step 6 — ANALYZE CODE
Run static analysis and formatting checks:
```bash
flutter analyze            # Must return 0 warnings
dart format --output=none --set-exit-if-changed .  # Must return 0 (no unformatted files)
```
Fix **all** issues. Do not suppress warnings without explicit justification.

### Step 7 — REVIEW
Self-review against the 12 coding standard areas:
- [ ] Null safety: no unguarded `!`, no `dynamic`
- [ ] Const: all immutable literals and subtrees are `const`
- [ ] 4 UI states: every data screen handles Loading/Success/Empty/Error
- [ ] dispose(): all controllers, subscriptions, focus nodes disposed
- [ ] No hardcoded secrets or colors
- [ ] No magic numbers (all extracted as named `const`)
- [ ] No dead/commented-out code
- [ ] Business logic separated from UI

### Step 8 — REPORT
Summarize the completed work concisely:
- Files created / modified / deleted
- Tests added
- Verification commands run and results
- Known limitations or deferred work (with references to `tasks/TASKS.md`)

---

## 7. Engineering Rules

> Full standards reference: [`docs/FLUTTER_CODING_STANDARDS.md`](../docs/FLUTTER_CODING_STANDARDS.md)

**Non-negotiable rules — zero exceptions:**

| Rule | Requirement |
| :--- | :--- |
| No `dynamic` | Use typed models or `Object?`; parse JSON immediately |
| No hardcoded secrets | `--dart-define` or `flutter_secure_storage` |
| No dummy production data | Real data only; honest empty states |
| No unguarded force-unwrap | `value!` requires explicit null check before it |
| 4 UI states mandatory | Loading / Success / Empty / Error on every data screen |
| `dispose()` mandatory | All controllers, subscriptions, focus nodes must be disposed |
| `const` everywhere | Every immutable literal and widget subtree must be `const` |
| `dart analyze` 0 warnings | Zero warnings before task completion — fix all, suppress none |
| Meaningful names | No single-letter names (except loop indices); no ambiguous abbreviations |

---

## 8. Code Examples

### 4 Mandatory UI States
```dart
// CORRECT: exhaustive switch expression covering all 4 states
Widget build(BuildContext context) {
  return BlocBuilder<ItemCubit, ItemState>(
    builder: (context, state) => switch (state) {
      ItemLoading()              => const LoadingIndicator(),
      ItemError(:final message)  => ErrorView(message: message, onRetry: context.read<ItemCubit>().load),
      ItemEmpty()                => const EmptyStateView(message: 'No items yet. Add one to get started.'),
      ItemLoaded(:final items)   => ItemListView(items: items),
    },
  );
}
```

### Correct dispose() Pattern
```dart
class _MyWidgetState extends State<MyWidget> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  StreamSubscription<Event>? _subscription;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _subscription = eventBus.on<Event>().listen(_handleEvent);
  }

  @override
  void dispose() {
    _controller.dispose();   // ✅ Always dispose
    _focusNode.dispose();    // ✅ Always dispose
    _subscription?.cancel(); // ✅ Always cancel
    super.dispose();
  }
}
```

### Typed Failure + Result Pattern
```dart
sealed class Failure { final String message; const Failure(this.message); }
final class NetworkFailure extends Failure { const NetworkFailure(super.message); }
final class CacheFailure extends Failure { const CacheFailure(super.message); }

// Repository returning Result
Future<Result<List<Item>, Failure>> getItems() async {
  try {
    final items = await _remoteSource.fetchItems();
    return Success(items.map((dto) => dto.toEntity()).toList());
  } on DioException catch (e) {
    return Err(NetworkFailure(e.message ?? 'Network error'));
  }
}
```

### BuildContext Safety After Async
```dart
// WRONG — crashes if widget unmounted during async
Future<void> submit() async {
  await _repo.save(data);
  Navigator.of(context).pushNamed('/done'); // ❌ BuildContext after await
}

// CORRECT
Future<void> submit() async {
  await _repo.save(data);
  if (!mounted) return;                      // ✅ mounted check
  if (!context.mounted) return;              // ✅ also valid in Dart 3
  Navigator.of(context).pushNamed('/done');
}
```

---

## 9. Common Mistakes

| Mistake | Correct Approach |
| :--- | :--- |
| Starting implementation without reading existing project | Always INSPECT first (Step 1) |
| Using `dynamic` for JSON responses | Parse immediately into typed models with `fromJson()` |
| Hardcoding hex colors or pixel values | Use `Theme.of(context).colorScheme` and `AppSpacing` constants |
| Missing empty state | Render `EmptyStateView` with actionable CTA when list is empty |
| Not disposing controllers | Implement full `dispose()` override — all resources freed |
| Business logic in `build()` | Extract to BLoC / Cubit / Notifier / Controller |
| Force-unwrapping `!` without guard | Add `if (value == null) return;` before `value!` |
| `ListView` with `children: items.map(...)` | Use `ListView.builder` with `itemCount` and `itemBuilder` |
| Catching `Object` or bare `catch (e)` | Catch specific types; convert to typed `Failure`; never swallow |
| Skipping `flutter analyze` | Run analyze and format checks before every commit |

---

## 10. Testing and Verification

```bash
# 1. Static analysis — must return 0 warnings
flutter analyze

# 2. Format check — must return 0 (no unformatted files)
dart format --output=none --set-exit-if-changed .

# 3. Full test suite — all must pass
flutter test

# 4. Release build verification — must succeed without errors
flutter build windows --release   # or: apk / ios / web / macos / linux

# 5. Coverage report (optional but recommended)
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

---

## 11. Completion Criteria

A task is complete **only** when **all** of the following are true:

- [ ] All 8 workflow steps completed and reported to user.
- [ ] `flutter analyze` returns 0 warnings.
- [ ] `dart format` returns 0 unformatted files.
- [ ] All 4 UI states (Loading / Success / Empty / Error) implemented on every data screen.
- [ ] No hardcoded secrets, tokens, colors, or magic numbers introduced.
- [ ] All new controllers, subscriptions, and focus nodes properly disposed.
- [ ] Unit and/or widget tests written for new logic.
- [ ] `flutter build --release` succeeds for the target platform.

---

## 12. Related Skills

| Skill | Responsibility |
| :--- | :--- |
| `github-repository` | Remote GitHub repository ingestion, topology discovery, and adaptive development |
| `flutter-architecture` | Clean Architecture, feature-first folder structure, dependency injection |
| `dart-best-practices` | Idiomatic Dart 3.x — sealed types, records, switch expressions, null safety |
| `ui-implementation` | Widget composition, 4 UI states, micro-interactions, skeletons |
| `state-management` | BLoC / Riverpod / Provider / ValueNotifier — selection and patterns |
| `database-integration` | Drift, Hive, Isar, schema migrations, relational integrity |
| `api-integration` | Dio, interceptors, error mapping, caching strategy |
| `error-handling` | Dual global hooks, typed Failure hierarchy, retry with backoff |
| `security-audit` | Secret scanning, obfuscation, vulnerability assessment |
| `testing` | AAA pattern, mocktail, golden tests, coverage targets |
| `performance` | DevTools profiling, jank elimination, 60/120 fps frame budgets |
| `performance-engineering` | Big-O complexity, collection pre-indexing, Isolate offloading |
| `production-readiness` | 50-point pre-flight checklist before store/enterprise release |
| `code-review` | Severity triage: Critical / High / Medium / Low |
| `accessibility` | WCAG AA, semantic trees, touch targets, screen readers |
| `windows-development` | Win32 interop, single-instance mutex, DPI awareness, tray |
| `desktop-development` | Multi-window, menu bars, keyboard shortcuts, file I/O |
