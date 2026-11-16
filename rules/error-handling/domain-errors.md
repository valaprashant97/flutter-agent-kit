# Domain Error Modeling & Typed Failure Hierarchies

This guide outlines production rules for modeling, propagating, and handling errors using **sealed classes** and functional **Result** patterns in Flutter.

---

## 1. The Anti-Pattern: Untyped Exceptions & String Errors

### Prohibited Patterns
```dart
// PROHIBITED: Untyped string throws
throw 'Something went wrong';

// PROHIBITED: Catching dynamic and ignoring failure causes
try {
  await repository.fetchData();
} catch (e) {
  print(e); // Swallows context, leaves UI hanging
}
```

### Production Principle: Errors as Values
In production Dart 3.x applications, domain failures must be modeled as strongly typed data structures returned via a `Result<T, E>` container, reserving unhandled `throw` statements exclusively for unrecoverable programmer errors (e.g. `ArgumentError`, `StateError`).

---

## 2. The Sealed `Failure` Hierarchy

```dart
sealed class Failure {
  final String message;
  final String? code;
  const Failure(this.message, [this.code]);
}

// 1. Network & Connectivity Failures
final class NetworkFailure extends Failure {
  final int? statusCode;
  const NetworkFailure(super.message, [super.code, this.statusCode]);
}

// 2. Authentication & Authorization Failures
final class AuthFailure extends Failure {
  const AuthFailure(super.message, [super.code]);
}

// 3. Local Cache & Database Failures
final class CacheFailure extends Failure {
  const CacheFailure(super.message, [super.code]);
}

// 4. Form & Business Validation Failures
final class ValidationFailure extends Failure {
  final Map<String, String> fieldErrors;
  const ValidationFailure(super.message, this.fieldErrors, [super.code]);
}

// 5. Host Platform Failures (Win32 / Android / iOS)
final class PlatformFailure extends Failure {
  const PlatformFailure(super.message, [super.code]);
}
```

---

## 3. The Functional `Result<T, E>` Pattern

```dart
sealed class Result<T, E extends Failure> {
  const Result();

  bool get isSuccess => this is Success<T, E>;
  bool get isFailure => this is FailureResult<T, E>;

  T? get dataOrNull => switch (this) {
    Success(:final data) => data,
    FailureResult() => null,
  };
}

final class Success<T, E extends Failure> extends Result<T, E> {
  final T data;
  const Success(this.data);
}

final class FailureResult<T, E extends Failure> extends Result<T, E> {
  final E failure;
  const FailureResult(this.failure);
}
```

---

## 4. Exhaustive UI Pattern Matching

In the presentation layer, map domain failures to user-facing states with compile-time exhaustiveness:

```dart
String resolveErrorMessage(Failure failure) => switch (failure) {
  NetworkFailure(:final statusCode) => statusCode == 404
      ? 'Requested item was not found.'
      : 'Network connection issue. Please check your internet.',
  AuthFailure() => 'Your session has expired. Please log in again.',
  CacheFailure() => 'Unable to read saved local data.',
  ValidationFailure(:final fieldErrors) => fieldErrors.values.firstOrNull ?? 'Invalid input provided.',
  PlatformFailure() => 'A hardware or native system error occurred.',
};
```

---

## 5. Data Source Error Mapping Rule

Repositories must intercept low-level exceptions (e.g. `DioException`, `SocketException`, `IsarError`) and map them to domain `Failure` instances before returning:

```dart
class UserRepositoryImpl implements UserRepository {
  final RemoteUserDataSource remoteSource;

  UserRepositoryImpl({required this.remoteSource});

  @override
  Future<Result<User, Failure>> getUser(String id) async {
    try {
      final userDto = await remoteSource.fetchUser(id);
      return Success(userDto.toDomain());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        return const FailureResult(NetworkFailure('Connection timed out', 'TIMEOUT'));
      }
      return FailureResult(NetworkFailure(e.message ?? 'Server error', 'HTTP_ERR', e.response?.statusCode));
    } catch (e) {
      return FailureResult(CacheFailure('Unexpected error: $e'));
    }
  }
}
```
