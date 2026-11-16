# Core Engineering Standards: Dart & Flutter

This document defines the single source of truth for production engineering standards, coding principles, and architectural requirements within the **Flutter Agent Kit**. All AI agents (Cursor, Claude Code, OpenAI Codex, Gemini CLI, GitHub Copilot, Antigravity) must strictly adhere to these standards.

---

## 1. Modern Dart 3.x Standards

### Sound Null Safety
- **No `dynamic`**: Avoid `dynamic` unless explicitly interfacing with un-typed external JSON or platform channels. Use `Object?` when a value can be anything, or define typed models.
- **Never abuse `!` (Bang operator)**: Force-unwrapping (`user!.name`) is strictly prohibited unless preceded by an explicit null check or invariant guarantee. Prefer null-aware operators (`?.`, `??`, `??=`) or pattern matching.
- **Explicit return types**: Every public function, method, and getter must declare an explicit return type.

### Modern Language Features (Dart 3+)
- **Pattern Matching & Switch Expressions**: Prefer switch expressions over nested `if-else` cascades for state evaluation:
  ```dart
  Widget buildStateWidget(AuthState state) => switch (state) {
    AuthInitial() => const InitialView(),
    AuthLoading() => const LoadingIndicator(),
    AuthAuthenticated(:final user) => UserProfileView(user: user),
    AuthError(:final message) => ErrorBanner(message: message),
  };
  ```
- **Sealed Class Hierarchies**: Model domain states, events, and results using `sealed` classes to guarantee compile-time exhaustiveness:
  ```dart
  sealed class Result<T, E extends Failure> {
    const Result();
  }
  final class Success<T, E extends Failure> extends Result<T, E> {
    final T data;
    const Success(this.data);
  }
  final class Err<T, E extends Failure> extends Result<T, E> {
    final E failure;
    const Err(this.failure);
  }
  ```
- **Records**: Use records for lightweight, typed multi-value returns instead of creating throwaway tuple classes:
  ```dart
  (double min, double max) calculateBounds(List<double> values) { ... }
  ```

---

## 2. Flutter Widget Composition & Lifecycle Standards

### StatelessWidget vs. StatefulWidget
- **Default to StatelessWidget**: Always prefer `StatelessWidget` combined with a decoupled state management solution (BLoC, Riverpod, Provider, ValueNotifier) to separate business logic from the view.
- **When StatefulWidget is Permitted**: Use `StatefulWidget` only for local, transient ephemeral UI state:
  - Animation controllers (`TickerProviderStateMixin`)
  - Form field controllers (`TextEditingController`, `FocusNode`)
  - Tab controllers (`TabController`)
  - Scroll position listeners

### BuildContext Safety Across Async Gaps
- **Never use `BuildContext` after an `await` without `mounted` check**:
  ```dart
  // WRONG - Crashes if widget unmounted during async operation
  Future<void> submit() async {
    await api.login();
    Navigator.of(context).pushNamed('/home');
  }

  // CORRECT
  Future<void> submit() async {
    await api.login();
    if (!context.mounted) return;
    Navigator.of(context).pushNamed('/home');
  }
  ```

### The 4 Mandatory UI States
Every asynchronous UI screen or component must explicitly handle all 4 states:
1. **Loading State**: Clear visual indication (Skeleton shimmer or centered progress indicator).
2. **Success State**: The primary data display.
3. **Empty State**: Friendly illustration/message when a query returns zero records, plus a call-to-action.
4. **Error State**: Informative error message with an actionable **Retry** button.

---

## 3. Resource Management & Memory Hygiene

### Explicit Disposal
Every disposable resource initialized in a `StatefulWidget` or service must be cleaned up in `dispose()`:
```dart
@override
void dispose() {
  _textController.dispose();
  _focusNode.dispose();
  _animationController.dispose();
  _streamSubscription?.cancel();
  super.dispose();
}
```

### Const Constructors
- **Enforce `const`**: Always use `const` constructors on widgets and subtrees where properties are compile-time constants. This avoids unnecessary element re-creation and GC pressure during build passes.

---

## 4. Greenfield vs. Brownfield Development Framework

### Greenfield Projects (New Applications)
- **Establish Strong Foundations**: Start from `templates/PRD.md`, `templates/ARCHITECTURE.md`, and `templates/DESIGN.md`.
- **Enforce Feature-First Clean Architecture**: Slice by domain feature (`features/<feature_name>/{data, domain, presentation}`) rather than layer-first folders.
- **Select State Management Intentionally**: Choose Riverpod or BLoC based on team requirements. Set up dependency injection (`get_it` or Riverpod providers) from day one.
- **Configure CI & Quality Gates**: Set up `flutter analyze` and `flutter test` checks in GitHub Actions immediately.

### Brownfield Projects (Existing Applications)
- **Inspect Before Changing**: Read `pubspec.yaml`, existing architecture, and directory layout first. Never guess the state management or folder conventions.
- **Preserve Existing Patterns**: If the project uses Provider, GetX, or MVC, build new features using the existing architecture unless explicitly requested to refactor.
- **Never Introduce Duplicate Dependencies**: Never add `http` if `dio` is already present. Never add `shared_preferences` if `hive` or `hydrated_bloc` is already managing local persistence.
- **Surgical Edits**: Modify only the code necessary to implement the feature or fix the bug. Do not reformat or clean up unrelated working files.

---

## 5. Unified Error Handling Standard

Production applications must implement defense-in-depth error handling:

### Dual Global Interception Hooks
All apps must register both framework and asynchronous isolate exception handlers in `main()`:
```dart
void main() {
  // 1. Flutter framework layout & widget build errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    CrashlyticsService.logFlutterError(details);
  };

  // 2. Asynchronous isolate & Future unhandled errors
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    CrashlyticsService.logException(error, stack);
    return true; // Prevents process termination
  };

  runApp(const MyApp());
}
```

### Typed Sealed Domain Failures
Domain and data layer exceptions must be caught and mapped into a sealed `Failure` hierarchy:
```dart
sealed class Failure {
  final String message;
  final String? code;
  const Failure(this.message, [this.code]);
}

final class NetworkFailure extends Failure {
  final int? statusCode;
  const NetworkFailure(super.message, [super.code, this.statusCode]);
}

final class CacheFailure extends Failure {
  const CacheFailure(super.message, [super.code]);
}

final class AuthFailure extends Failure {
  const AuthFailure(super.message, [super.code]);
}
```

### User-Safe Error Messages
- **Never expose raw stack traces, SQL errors, or backend endpoint URLs** to the user.
- Map internal technical errors into user-friendly localized messages.
- Always provide an actionable recovery path (e.g., "Retry", "Check Connection", "Log In").

---

## 6. State Management & UI Boundary Standards

- **Zero Business Logic in UI**: Widgets must only handle rendering and user interaction event forwarding. No HTTP calls, direct database queries, or data parsing inside `build()` or `onPressed`.
- **Pure State Flow**: State must flow unidirectionally from domain/bloc/notifier down to widgets. Events flow up.
- **Controller Lifecycle & Cleanup**: Any state controller, bloc, or notifier must be properly closed/disposed when its scope terminates to prevent memory leaks.

---

## 7. Linting, Static Analysis & Zero Warnings Policy

- All code must comply with the active analysis options (e.g., `package:flutter_lints`).
- **Zero Warnings Policy**: Code must pass `flutter analyze` with 0 errors and 0 warnings before work is deemed complete.
- **No Suppressions**: Never use `// ignore: ...` or `// ignore_for_file: ...` to bypass valid architectural or safety lints unless approved by the user for an external FFI boundary.
- **Verification Rule**: Never mark any task as passed without executing the real validation command and capturing its actual output.

---

## 8. Real Data Integrity & Zero Dummy Data Standard

- **Real Data Only**: AI coding agents must NEVER introduce fake, dummy, static, hard-coded, or fabricated application data and present it as real user data. All production data must originate from actual user inputs, configured databases, real API responses, or legitimate derived calculations.
- **The 12 Prohibited Practices**: Prohibits hardcoded sample records, fake users/entities, static array substitutes for databases, fabricated dashboard metrics, fake API success responses, placeholder records to hide empty states, random number generators for production data, hard-coded fake auth states, dummy fallbacks on network failures, orphaned mock repositories in `lib/`, fake notification feeds, and fabricated success messages.
- **Honest Empty States**: When no records exist in the database, render an honest empty state with an actionable call-to-action button. Never insert fake records to make an interface look populated.
- **Real Analytics & Metrics**: All statistics, charts, and progress bars must be calculated from real stored records. If data is insufficient, show an honest "Insufficient data" state. Never fabricate numbers.
- **Mock Isolation**: Mocks and test fixtures must remain 100% isolated to `test/`. Never import from `test/` into `lib/` and never register mock repositories in production dependency injection.
- **Specification Reference**: See `docs/REAL_DATA_INTEGRITY.md`, `skills/real-data-integrity/SKILL.md`, and `workflows/real-data-audit/WORKFLOW.md`.

