# Unit Testing & Modern Assertions Rules

These rules govern unit testing domain logic, repository transformations, and data models in Flutter.

---

## 1. Test Structure: AAA Pattern (Arrange, Act, Assert)

Every unit test must clearly separate the three test phases:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockUserRepository mockRepository;
  late GetUserProfileUseCase useCase;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUserProfileUseCase(mockRepository);
  });

  group('GetUserProfileUseCase', () {
    const tUserId = 'user-123';
    const tUser = UserEntity(id: tUserId, email: 'test@example.com');

    test('returns UserEntity when repository call succeeds', () async {
      // 1. Arrange
      when(() => mockRepository.getUser(tUserId))
          .thenAnswer((_) async => tUser);

      // 2. Act
      final result = await useCase.execute(tUserId);

      // 3. Assert
      expect(result, equals(tUser));
      verify(() => mockRepository.getUser(tUserId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('throws ServerFailure when repository throws Exception', () async {
      // 1. Arrange
      when(() => mockRepository.getUser(tUserId))
          .thenThrow(const ServerFailure(500));

      // 2. Act & Assert
      expect(
        () async => await useCase.execute(tUserId),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
```

---

## 2. Using the Modern `checks` Package
In modern Dart 3, Google recommends `package:checks` for clearer, more expressive assertions:
```dart
import 'package:checks/checks.dart';
import 'package:test/test.dart';

test('validates user properties', () {
  final user = User(name: 'Alice', age: 30, tags: ['developer', 'flutter']);

  check(user.name).equals('Alice');
  check(user.age).isGreaterThan(18);
  check(user.tags).contains('flutter');
});
```

---

## 3. Unit Testing Invariants
1. **Zero External I/O**: Unit tests must never make real HTTP requests or write to real host disks. Always mock or inject in-memory equivalents (`MockClient`, `MemoryCacheStore`).
2. **Deterministic Execution**: Tests must not rely on random values, real system clocks (`DateTime.now()`), or unpredictable timers without clock mocking.
3. **Focused Assertions**: Test one logical behavior per test case. Avoid 50-line test blocks asserting 20 unrelated properties.
