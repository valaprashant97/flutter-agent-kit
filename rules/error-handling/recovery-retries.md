# Error Recovery, Retries & Offline Degradation Rules

This guide outlines production rules for executing automatic retries, exponential backoff with jitter, circuit breaking, and graceful offline fallback in Flutter applications.

---

## 1. Retryable vs. Non-Retryable Error Classification

Never execute blind retries on all failures. Blind retries waste battery, bandwidth, and can exacerbate server overload.

| Status / Failure | Classification | Policy |
| :--- | :--- | :--- |
| **Connection Timeout, SocketException** | Transient / Retryable | Retry with exponential backoff & jitter (max 3 attempts) |
| **HTTP 500, 502, 503, 504** | Transient Server Error | Retry with exponential backoff; if 503 has `Retry-After`, respect header |
| **HTTP 401 Unauthorized** | Non-Retryable (Standard) | Trigger token refresh interceptor once; if refresh fails, logout |
| **HTTP 400, 403, 404, 422** | Non-Retryable / Client Error | Abort immediately; map to domain validation or access failure |
| **JSON Deserialization Exception** | Programmer Error / Non-Retryable | Log to telemetry; abort immediately |

---

## 2. Exponential Backoff with Jitter Implementation

When retrying, add randomized jitter to prevent the "thundering herd" problem where thousands of mobile clients retry simultaneously:

```dart
import 'dart:math';

Future<T> retryWithBackoff<T>({
  required Future<T> Function() operation,
  int maxAttempts = 3,
  Duration baseDelay = const Duration(milliseconds: 500),
  Duration maxDelay = const Duration(seconds: 8),
  bool Function(Exception error)? isRetryable,
}) async {
  int attempt = 0;
  final random = Random();

  while (true) {
    attempt++;
    try {
      return await operation();
    } on Exception catch (e) {
      if (attempt >= maxAttempts || (isRetryable != null && !isRetryable(e))) {
        rethrow;
      }

      // Calculate exponential delay: base * 2^(attempt-1) + jitter
      final expDelayMs = baseDelay.inMilliseconds * pow(2, attempt - 1);
      final jitterMs = random.nextInt(250);
      final totalDelay = Duration(milliseconds: min(expDelayMs.toInt() + jitterMs, maxDelay.inMilliseconds));

      await Future.delayed(totalDelay);
    }
  }
}
```

---

## 3. Offline Degradation & Cache Fallback Strategy

When a network request fails due to lack of internet or server downtime:
1. **Fallback to Local Cache**: Read the last known good state from Drift, Isar, or Hive.
2. **Display Warning Banner**: Show a non-intrusive banner (e.g. "Working Offline - Data last synced 12m ago").
3. **Queue Mutations for Background Sync**: If the user submits a mutation while offline, persist it to a local pending actions queue to be synced when connectivity is restored via `connectivity_plus`.

```dart
Future<Result<Feed, Failure>> getFeed({bool forceRefresh = false}) async {
  if (!forceRefresh) {
    final cached = await localDataSource.getCachedFeed();
    if (cached != null) return Success(cached);
  }

  try {
    final remote = await remoteDataSource.fetchFeed();
    await localDataSource.cacheFeed(remote);
    return Success(remote);
  } on NetworkFailure catch (failure) {
    final cached = await localDataSource.getCachedFeed();
    if (cached != null) {
      // Degrade gracefully with cached data
      return Success(cached);
    }
    return FailureResult(failure);
  }
}
```

---

## 4. User-Driven Manual Recovery

Every screen displaying an error state must provide an actionable **Retry** button wired directly to the feature's reload trigger, allowing the user to recover without restarting the app.
