# Network Error Handling & Failure Mapping Rules

These rules establish robust network failure translation from raw transport errors (`DioException`, `SocketException`) to typed domain failures.

---

## 1. Domain Failure Hierarchy

Never expose raw `DioException` or `HttpException` instances to the presentation/UI layer. Map them to domain failures:

```dart
sealed class NetworkFailure implements Exception {
  final String userMessage;
  const NetworkFailure(this.userMessage);
}

final class NoInternetFailure extends NetworkFailure {
  const NoInternetFailure() : super('No internet connection. Please check your network.');
}

final class TimeoutFailure extends NetworkFailure {
  const TimeoutFailure() : super('The request timed out. Please try again.');
}

final class ServerFailure extends NetworkFailure {
  final int statusCode;
  const ServerFailure(this.statusCode, [String message = 'Server error occurred.'])
      : super(message);
}

final class UnauthorizedFailure extends NetworkFailure {
  const UnauthorizedFailure() : super('Session expired. Please log in again.');
}

final class UnknownNetworkFailure extends NetworkFailure {
  const UnknownNetworkFailure([String message = 'An unexpected network error occurred.'])
      : super(message);
}
```

---

## 2. Safe Exception Mapping Function

```dart
NetworkFailure mapDioException(DioException error) {
  return switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => const TimeoutFailure(),

    DioExceptionType.connectionError => const NoInternetFailure(),

    DioExceptionType.badResponse => switch (error.response?.statusCode) {
      401 => const UnauthorizedFailure(),
      403 => const ServerFailure(403, 'You do not have permission to access this resource.'),
      404 => const ServerFailure(404, 'Requested resource not found.'),
      500 || 502 || 503 => const ServerFailure(500, 'Server temporarily unavailable. Try again later.'),
      final code? => ServerFailure(code, 'Server error: $code'),
      null => const UnknownNetworkFailure(),
    },

    DioExceptionType.cancel => const UnknownNetworkFailure('Request was cancelled.'),
    _ => const UnknownNetworkFailure(),
  };
}
```

UI screens catch `NetworkFailure` and render friendly user banners with retry actions, rather than displaying raw stacktraces or technical JSON error codes.
