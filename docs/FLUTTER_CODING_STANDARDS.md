# Flutter & Dart Coding Standards

> **Single Source of Truth**: This document extends `core/engineering-standards.md`. All AI agents must read this before writing or reviewing Flutter/Dart code.

---

## 1. Dart Coding Standards

### Naming Conventions
| Element | Convention | Example |
| :--- | :--- | :--- |
| Variables, functions, parameters | `lowerCamelCase` | `userName`, `fetchData()` |
| Classes, enums, typedefs, extensions | `UpperCamelCase` | `UserRepository`, `AuthState` |
| Files, directories | `snake_case` | `user_repository.dart`, `auth_state.dart` |
| Constants (top-level / static) | `lowerCamelCase` | `const maxRetryCount = 3;` |
| Library names | `snake_case` | `library auth_service;` |

### Null Safety
- **No `dynamic`**: use `Object?` for truly unknown types; parse immediately into typed models.
- **No force-unwrap without guard**: `value!` requires an explicit null check or invariant assertion immediately before it.
- **Prefer null-aware operators**: `?.`, `??`, `??=`, null patterns (`value ?? const EmptyState()`).

### Type Safety & Immutability
- **Explicit return types** on all public functions, methods, and getters.
- **`final` by default**: declare all local variables and class fields `final` unless mutation is required.
- **`const` everywhere possible**: constructors, literals, widget subtrees — if it can be `const`, it must be.
- **Sealed class hierarchies** for domain states, events, and results:
  ```dart
  sealed class AuthState { const AuthState(); }
  final class AuthLoading extends AuthState { const AuthLoading(); }
  final class AuthAuthenticated extends AuthState {
    final User user;
    const AuthAuthenticated(this.user);
  }
  final class AuthError extends AuthState {
    final String message;
    const AuthError(this.message);
  }
  ```

### Async / Await
- **Always `await`** — never fire-and-forget unless inside an isolate or background task.
- **Return `Future<T>` not `void`** for testable async functions.
- **Never `async` without `await`** — a synchronous function marked `async` unnecessarily wastes resources.
- **Handle errors** in every async call: use typed `try/catch` or `.catchError()` with specific types.

### Exception Handling
- Catch **specific types**, never bare `catch (e)` or `catch (Object e)` without re-throwing or logging.
- **Never swallow exceptions silently**: always log, convert to a typed `Failure`, or rethrow.
- Use `try/catch/finally` for resource cleanup.

### Code Formatting
- Run `dart format` before every commit — enforced by CI.
- **80-character soft line limit** (hard limit: 120). Break arguments and chains across lines.
- Use `analysis_options.yaml` with `lints` or `flutter_lints` package enforced — zero warnings policy.

---

## 2. Flutter Architecture

### Feature-First Clean Architecture
```
lib/
  features/
    auth/
      data/
        datasources/      # Remote & local data sources
        models/           # DTOs with JSON serialization
        repositories/     # Repository implementations
      domain/
        entities/         # Immutable domain models
        repositories/     # Abstract repository interfaces
        usecases/         # Complex multi-repository orchestration only
      presentation/
        bloc/ or controllers/
        pages/
        widgets/
  core/
    errors/               # Failure hierarchy
    network/              # Dio client, interceptors
    utils/
    presentation/widgets/ # Shared reusable widgets
```

### Dependency Rule
- Dependencies point **inward only**: Data → Domain ← Presentation.
- Domain must have **zero dependencies** on Flutter UI, Dio, or database drivers.
- Presentation must **never** make direct HTTP requests or raw DB queries.

### Repository Pattern
- One abstract interface in `domain/repositories/` per feature.
- One concrete implementation in `data/repositories/`.
- Repository returns `Result<T, Failure>` or `Either<Failure, T>` — never raw exceptions.

### Dependency Injection
- Use `get_it` (service locator) or Riverpod providers.
- Register dependencies in a dedicated `injection_container.dart` or `providers.dart`.
- Use constructor injection — never use `GetIt.instance.get()` inside widget trees.

### UseCases
- Create a UseCase class **only** for complex multi-repository orchestration.
- Simple single-method repository calls do **not** require a UseCase wrapper.

---

## 3. Widget Standards

### StatelessWidget vs StatefulWidget
- **Default to `StatelessWidget`** combined with a state management solution.
- Use `StatefulWidget` **only** for local ephemeral UI state:
  - Animation controllers (`TickerProviderStateMixin`)
  - `TextEditingController`, `FocusNode`, `ScrollController`
  - `TabController`, page indices
- **Never** store business logic or remote data in `StatefulWidget` state.

### Single Responsibility
- Each widget has **one responsibility**. Extract when a widget exceeds ~60 lines or is reused in 2+ places.
- Widget files: one primary widget per file.

### BuildContext Safety
```dart
// WRONG — crashes if widget unmounted during async
Future<void> submit() async {
  await api.login();
  Navigator.of(context).pushNamed('/home'); // ❌
}

// CORRECT
Future<void> submit() async {
  await api.login();
  if (!mounted) return;                     // ✅
  Navigator.of(context).pushNamed('/home');
}
```

### 4 Mandatory UI States
Every screen that loads data **must** handle all four states:

| State | Widget |
| :--- | :--- |
| Loading | `CircularProgressIndicator` / skeleton shimmer |
| Success | Data list or detail view |
| Empty | `EmptyStateView` with actionable CTA |
| Error | `ErrorView` with retry button |

### Responsive Layouts
- Use `LayoutBuilder` and `MediaQuery` — never hardcode pixel widths.
- Mobile: single-column; Tablet: two-pane; Desktop: master-detail.
- Use `AdaptiveLayout` or breakpoint constants from `core/presentation/breakpoints.dart`.

### Accessibility
- Every interactive widget must have a `Semantics` label describing the **action** (not the icon graphic).
- Minimum touch target: 48×48 dp.
- Contrast ratio ≥ 4.5:1 (WCAG AA) for all text on background.

---

## 4. State Management

### Selection Rule
Follow the **existing project convention** — never switch state management libraries without profiling evidence and team agreement.

| Library | Recommended For |
| :--- | :--- |
| `flutter_bloc` / BLoC | Complex event-driven flows, large teams |
| Riverpod | Reactive dependency injection, compile-safe |
| Provider | Small-to-medium apps, simple reactive state |
| ValueNotifier | Local widget-level state |

### Rules
- **UI/Logic separation**: zero business logic inside `build()` methods or widget classes.
- **Immutable state objects**: state classes must be immutable (`const` or `copyWith()`).
- **Granular rebuilds**: use `BlocSelector`, `select()`, or `ValueListenableBuilder` to rebuild only the affected subtree.
- **No unnecessary rebuilds**: profile with Flutter DevTools before adding broad `Consumer` or `BlocBuilder` wrappers.

---

## 5. Database & API Standards

### Repository / Datasource Separation
```
RemoteDataSource (Dio/HTTP) ─┐
                              ├─→ RepositoryImpl → Repository (interface) ← UseCase / BLoC
LocalDataSource  (Drift/Hive)─┘
```

### Database Rules
- Use **transactions** for every multi-step write operation.
- Define **schema migrations** for every column/table change.
- Never expose raw DB rows to the presentation layer — always map to domain entities.
- Use `Drift` for relational data, `Hive`/`Isar` for simple key-value or document storage.

### API / Networking Rules
- Use **Dio** with interceptors: authentication (token injection), retry (exponential backoff), logging.
- Map HTTP errors to typed `Failure` subclasses — never surface raw `DioException` to UI.
- Cache GET responses with TTL strategy; implement offline-first with a sync queue for writes.
- Never log full request/response bodies containing PII or auth tokens.

---

## 6. Performance Optimization

| Rule | Detail |
| :--- | :--- |
| `const` subtrees | Mark every immutable widget and literal `const` |
| Lazy lists | `ListView.builder` / `SliverList` for all lists (never `Column` + map for >10 items) |
| Isolate offload | CPU tasks >8 ms → `Isolate.run()` |
| Image memory | Set `cacheWidth`/`cacheHeight` proportional to display DPR |
| Pure `build()` | No I/O, no parsing, no heavy calculations inside `build()` |
| O(1) lookups | Use `Map`/`Set` for repeated lookups, never `List.firstWhere` in loops |
| `dispose()` mandatory | Controllers, focus nodes, subscriptions, timers — always disposed |
| `StringBuffer` in loops | Never concatenate strings with `+` inside a loop |

---

## 7. Error Handling & Logging

### Global Error Hooks
Register **both** hooks before `runApp()`:
```dart
FlutterError.onError = (details) => FirebaseCrashlytics.instance.recordFlutterFatalError(details);
PlatformDispatcher.instance.onError = (error, stack) {
  FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  return true;
};
```

### Typed Failure Hierarchy
```dart
sealed class Failure { final String message; const Failure(this.message); }
final class NetworkFailure extends Failure { const NetworkFailure(super.message); }
final class CacheFailure extends Failure { const CacheFailure(super.message); }
final class ValidationFailure extends Failure { const ValidationFailure(super.message); }
final class AuthFailure extends Failure { const AuthFailure(super.message); }
```

### Rules
- **User-safe messages**: show human-readable messages in UI; never expose stack traces or internal errors.
- **Structured logging**: include timestamp, feature, severity level. Never log PII, tokens, or passwords.
- **Exponential backoff**: retry transient network errors with backoff (1s, 2s, 4s — max 3 retries).

---

## 8. Security Standards

| Rule | Implementation |
| :--- | :--- |
| Zero hardcoded secrets | `--dart-define=API_KEY=…` or `.env` via `flutter_dotenv` |
| Secure token storage | `flutter_secure_storage` — never `SharedPreferences` for sensitive data |
| Input validation | Server-side is authoritative; client-side for UX only |
| Certificate pinning | Required for financial/health data endpoints |
| Release obfuscation | `flutter build --obfuscate --split-debug-info=symbols/` |
| No PII in logs | Scrub names, emails, IDs from all log entries |
| Dependency audits | Run `flutter pub outdated` and check for known CVEs before release |

---

## 9. Testing Standards

### Test Pyramid
```
                 ┌─────────────┐
                 │ Integration │  (happy paths, critical flows)
                ┌┤─────────────│
               / │   Widget    │  (4 UI states per screen)
              /  └─────────────┘
             /   ┌─────────────┐
            /    │    Unit     │  (domain logic, repositories, utils)
           /     └─────────────┘
```

### Rules
- **AAA pattern**: every test must have clear Arrange / Act / Assert sections.
- **`mocktail`** for mocking — never use real HTTP or DB in unit/widget tests.
- **Never mock the class under test**.
- **4 UI states per screen**: write one widget test per state (Loading, Success, Empty, Error).
- **Regression tests**: every fixed bug must have a corresponding test that fails without the fix.
- **Golden tests**: critical UI components (cards, charts, branded layouts) have golden baselines.
- **Coverage target**: ≥80% line coverage on domain and data layers.

---

## 10. Code Quality

| Rule | Detail |
| :--- | :--- |
| Meaningful names | No single-letter names except loop indices; no ambiguous abbreviations |
| Small functions | Prefer <30 lines per function/method; extract helpers when exceeded |
| No magic numbers | Extract as named `const`: `const kAnimationDuration = Duration(ms: 300)` |
| DRY | Extract shared logic to `core/utils/` or shared widgets — never copy-paste |
| No dead code | Delete commented-out code; remove unused imports and variables |
| No TODO in production | Resolve all TODOs before marking a task completed |
| `dart analyze` 0 warnings | Zero warnings policy — fix all, suppress none without justification |

---

## 11. Desktop & Platform-Specific Standards

### Windows Desktop
- **Single-instance mutex**: implement in `windows/runner/main.cpp` to prevent duplicate processes.
- **Per-Monitor V2 DPI**: set `DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2` for crisp rendering.
- **Tray minimize**: closing window ≠ exiting app when tray is configured (`tray_manager`).
- **Background tasks**: post-process-termination tasks need Windows Task Scheduler — Dart isolates stop with the process.
- **MSIX packaging**: use `msix` package; configure publisher, certificate, and capabilities in `pubspec.yaml`.

### macOS
- Configure entitlements (`*.entitlements`) for network, file, camera, microphone access.
- Respect macOS app lifecycle (`applicationShouldTerminateAfterLastWindowClosed`).
- Use `path_provider` — never hardcode macOS paths.

### Linux
- Target GTK3 compatibility; test on Ubuntu LTS.
- Use `path_provider` for config/data directories.

### All Desktop Platforms
- **Keyboard shortcuts**: use `Shortcuts` + `Actions` widgets for all standard operations (Ctrl+S, Ctrl+Z, etc.).
- **Multi-window**: manage window lifecycle explicitly; dispose resources on window close.
- **File system**: always use `path_provider` for portable paths; never hardcode `/home` or `C:\Users`.

---

## 12. Production Readiness

| Checkpoint | Detail |
| :--- | :--- |
| Release builds | Verify `flutter build --release` succeeds for all target platforms |
| Crash handling | Global error hooks registered before `runApp()` |
| Schema migrations | Every DB column/table change has a migration script |
| Security review | No hardcoded secrets; all tokens in secure storage; pinning configured |
| Performance profiling | DevTools timeline shows <16ms frame budgets in release mode |
| Obfuscation | `--obfuscate --split-debug-info` on all release builds |
| 50-point pre-flight | Complete `skills/production-readiness/SKILL.md` checklist before submission |

---

## Related Skills

| Skill | Responsibility |
| :--- | :--- |
| `coding-standards` | This document's companion skill with 8-step AI workflow |
| `flutter-architecture` | Clean Architecture and feature-first folder structure |
| `dart-best-practices` | Idiomatic Dart 3.x — sealed types, records, pattern matching |
| `ui-implementation` | Widget composition, 4 UI states, micro-interactions |
| `state-management` | BLoC / Riverpod / Provider / ValueNotifier selection and patterns |
| `database-integration` | Drift, Hive, Isar, migrations, relational integrity |
| `api-integration` | Dio, interceptors, error mapping, caching |
| `error-handling` | Dual global hooks, typed failures, retry policy |
| `security-audit` | Secret scanning, obfuscation, vulnerability assessment |
| `testing` | AAA, mocktail, golden tests, coverage |
| `performance` | DevTools profiling, jank elimination, frame budgets |
| `performance-engineering` | Big-O complexity, collection pre-indexing, isolate offloading |
| `production-readiness` | 50-point pre-flight checklist |
| `code-review` | Severity triage: Critical / High / Medium / Low |
| `accessibility` | WCAG AA, semantic trees, touch targets |
| `windows-development` | Win32, single-instance, DPI, tray |
| `desktop-development` | Multi-window, menu bars, keyboard shortcuts |
