---
name: error-handling
description: Implement robust, production-grade error handling, global crash interception, typed sealed domain failures, safe retries, and graceful UI degradation.
---

# error-handling

## 1. Skill Name
`error-handling`

## 2. Purpose
Guides agents in establishing comprehensive, defense-in-depth error handling across Flutter applications. Configures dual global interception hooks (`FlutterError.onError`, `PlatformDispatcher.onError`), replaces the red screen of death with `ErrorWidget.builder`, models strongly typed sealed domain failures, enforces exponential backoff with jitter, and protects user data by sanitizing error telemetry.

## 3. When to Use
- When setting up core application error handling during greenfield project bootstrap.
- When handling network request failures, database exceptions, or platform channel errors.
- When replacing unhandled exception crashes with graceful fallback error states.
- When configuring crash reporting tools (Sentry, Firebase Crashlytics) and breadcrumb tracking.

## 4. When Not to Use
- For simple input validation that can be evaluated synchronously via `Form` validators without throwing exceptions.
- For normal control flow (do not use exceptions as a substitute for `if-else` or boolean flags).

## 5. Required Project Context
- `main.dart` error interception architecture.
- Crash reporting packages in `pubspec.yaml` (Sentry, Firebase Crashlytics).
- Domain failure definitions and UI error state presentation components.

## 6. Step-by-Step Workflow
1. **Configure Global Interception**:
   - In `main()`, set `FlutterError.onError` for framework build/layout exceptions.
   - Set `PlatformDispatcher.instance.onError` for uncaught asynchronous Future/isolate exceptions.
   - Configure `ErrorWidget.builder` with `FallbackErrorScreen`.
2. **Define Typed Domain Failures**:
   - Create a `sealed class Failure` hierarchy in `core/errors/failures.dart`.
   - Subtype into `NetworkFailure`, `AuthFailure`, `CacheFailure`, `ValidationFailure`, etc.
3. **Wrap Operations in Result Containers**:
   - Return `Result<T, Failure>` from repository methods instead of letting raw exceptions bubble up.
4. **Implement Smart Retries**:
   - Apply exponential backoff with randomized jitter to transient network calls.
5. **Sanitize Telemetry**:
   - Ensure passwords, auth tokens, and PII are stripped from logged breadcrumbs and reports.
6. **Verify UI Fallback**:
   - Test that deliberate exceptions produce actionable UI states with working Retry buttons.

## 7. Engineering Rules
- **Dual Hook Invariant**: Modern Flutter apps must register both `FlutterError.onError` and `PlatformDispatcher.onError`.
- **No Raw String Throws**: Never write `throw "Error message"`. Use typed exception or failure classes.
- **No Leaked PII Invariant**: Technical stack traces, SQL queries, and auth tokens must never be exposed to users in UI error banners.
- **Actionable Recovery**: Every error state presented to the user must provide an actionable path (Retry button, Re-login, or Return to Home).

## 8. Code Examples
```dart
// Complete main() error bootstrap
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    TelemetryService.recordFlutterError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    TelemetryService.recordAsyncError(error, stack);
    return true; // Prevents crash
  };

  ErrorWidget.builder = (details) => FallbackErrorWidget(details: details);

  runApp(const MyApp());
}
```

## 9. Common Mistakes
- Relying exclusively on `runZonedGuarded` in modern Flutter without `PlatformDispatcher.onError`.
- Catching exceptions with empty catch blocks (`catch (_) {}`), hiding critical failures.
- Retrying 4xx client errors (400, 401, 403, 404) repeatedly, spamming backend services.

## 10. Testing and Verification
- Unit test repository error mapping:
  ```dart
  test('returns NetworkFailure when Dio throws connection timeout', () async {
    when(() => mockDio.get(any())).thenThrow(DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionTimeout,
    ));
    final result = await repository.fetchData();
    expect(result.failure, isA<NetworkFailure>());
  });
  ```
- Widget test UI error states and verify tapping Retry triggers a reload.

## 11. Completion Criteria
- Dual global error handlers are active in `main.dart`.
- Red/gray error screen is replaced with user-friendly fallback.
- Domain operations return strongly typed `Result` or `Failure` objects.
- All error states provide a functional retry or recovery mechanism.

## 12. Related Skills
- `debugging`
- `api-integration`
- `database-integration`
- `security-audit`
- `testing`
