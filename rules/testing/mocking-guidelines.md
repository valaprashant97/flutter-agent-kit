# Mocking Guidelines & Test Doubles (Mocktail)

These rules govern mocking, stubbing, and verification in Dart and Flutter test suites using `mocktail`.

---

## 1. Why Mocktail Over Mockito?
- **No Code Generation Required**: `mocktail` leverages Dart reflection and type arguments, eliminating the need to run `dart run build_runner build` just to generate `*.mocks.dart` files.
- **Null Safety Built-in**: Clean syntax with type-safe argument matchers.

---

## 2. Standard Mocktail Pattern

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// 1. Declare Mock class
class MockAuthRepository extends Mock implements AuthRepository {}
class FakeUserEntity extends Fake implements UserEntity {}

void main() {
  late MockAuthRepository mockAuthRepo;

  setUpAll(() {
    // Register fallbacks for custom types used in any() matchers
    registerFallbackValue(FakeUserEntity());
  });

  setUp(() {
    mockAuthRepo = MockAuthRepository();
  });

  test('successfully verifies method invocation', () async {
    when(() => mockAuthRepo.saveUser(any()))
        .thenAnswer((_) async => true);

    await mockAuthRepo.saveUser(const UserEntity(id: '1', email: 'test@example.com'));

    verify(() => mockAuthRepo.saveUser(any())).called(1);
  });
}
```

---

## 3. Mocking Invariants

1. **Register Fallback Values**: If using `any()` with custom non-primitive types, you **must** call `registerFallbackValue(FakeMyClass())` in `setUpAll()`. Failing to do so causes runtime `ArgumentError` in mocktail.
2. **Never Mock What You Do Not Own**:
   - Do not mock low-level `HttpClientRequest` or raw sockets.
   - Mock your own repository contracts (`AuthRepository`, `ProductService`).
3. **Verify Meaningful Interactions**:
   - Don't just assert `expect(...)`; verify that critical side-effects occurred:
     ```dart
     verify(() => analyticsService.logEvent('purchase_completed')).called(1);
     ```
   - Use `verifyNever(() => paymentClient.charge(any()))` to verify that invalid input did not trigger a dangerous remote operation.
