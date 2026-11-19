---
name: testing
description: Comprehensive testing strategy for Flutter: unit testing, widget testing, golden regression tests, mocking with mocktail, and integration tests.
---

# testing

## 1. Skill Name
`testing`

## 2. Purpose
Provides production standards for implementing unit, widget, golden visual, and integration test suites in Flutter. Enforces the Arrange-Act-Assert (AAA) pattern, reliable widget pumping with `WidgetTester`, test doubles with `mocktail`, platform test matrices, and automated coverage analysis.

## 3. When to Use
- When writing tests for newly created features, models, repositories, or widgets.
- When creating regression tests to prevent previously resolved bugs from reoccurring.
- When preparing an application for production release validation across multiple platforms.

## 4. When Not to Use
- When performing speculative manual exploration without automating assertions.

## 5. Required Project Context
- `pubspec.yaml` (`flutter_test`, `mocktail` or `mockito`, `integration_test`)
- Code under test and domain contract interfaces.

## 6. Step-by-Step Workflow
1. **Determine Test Layer**:
   - Pure domain logic, state reducers, models → **Unit Test** (`test/unit/`).
   - Widget rendering, gesture handling, form validation → **Widget Test** (`test/widgets/`).
   - Visual regression, pixel precision, themes → **Golden Test** (`test/goldens/`).
   - End-to-end multi-screen workflows → **Integration Test** (`integration_test/`).
2. **Create Test Doubles**: Define mock classes implementing repository or service contracts using `mocktail`.
3. **Register Fallbacks**: Register any custom parameter types used in `any()` matchers in `setUpAll()`.
4. **Structure Test Cases**: Group tests logically by class and method name using `group()`.
5. **Execute Verification**: Run `flutter test <path_to_test>`.
6. **Check Coverage**: Run `flutter test --coverage` to inspect uncovered branches.

## 7. Engineering Rules
- **Mock Isolation Invariant**: Mocks and fixtures are restricted strictly to `test/`. Never import test doubles or fixture JSON into production code in `lib/`. Never register mock repositories in release builds (`docs/REAL_DATA_INTEGRITY.md`).
- **Real Data & Empty State Testing**: Author tests verifying honest empty states on fresh databases, real CRUD persistence surviving app restarts, and that failed API calls do not display fabricated success.
- **No Real Network / File I/O**: Tests in `test/` must never make actual network requests or touch live external APIs.
- **Never Weaken Assertions**: Assert exact expected values. Do not replace `equals('expected')` with `isNotNull` to make a failing test pass.
- **No Artificial Delays**: Use `tester.pumpAndSettle()` or async pump intervals instead of arbitrary `Future.delayed()`.
- **Tag Isolation**: Tag golden visual regression tests with `@Tags(['golden'])` so fast CI suites can run with `--exclude-tags=golden`.

## 8. Code Examples
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
  });

  testWidgets('shows error banner when login fails', (tester) async {
    when(() => mockRepo.login('user@example.com', 'wrong_pass'))
        .thenAnswer((_) async => const FailureResult(AuthFailure('Invalid credentials')));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoginForm(authRepository: mockRepo),
        ),
      ),
    );

    // Enter credentials
    await tester.enterText(find.byType(TextField).first, 'user@example.com');
    await tester.enterText(find.byType(TextField).last, 'wrong_pass');
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    // Verify error banner is visible
    expect(find.text('Invalid credentials'), findsOneWidget);
  });
}
```

## 9. Platform Test Matrix & Manual QA Checklist

### Automated Test Matrix
| Layer | Scope | Target Execution | Command |
| :--- | :--- | :--- | :--- |
| **Unit** | Domain entities, use cases, view models, data mappers | Fast CI runner (seconds) | `flutter test test/unit/` |
| **Widget** | UI components, forms, error banners, state trees | Fast CI runner | `flutter test test/widgets/` |
| **Golden** | Visual regression, dark/light themes, typography | Standardized Linux CI | `flutter test --tags=golden` |
| **Integration**| Full app flows, deep links, auth state persistence | Emulator / Real device | `flutter test integration_test/` |

### Manual QA Pre-Release Checklist
- [ ] **Responsive Breakpoints**: Test layouts at 360px (mobile), 768px (tablet), and 1280px (desktop).
- [ ] **Offline Handling**: Toggle airplane mode; verify offline cache displays with warning banner.
- [ ] **Keyboard Navigation**: Verify `Tab`, `Shift+Tab`, `Enter`, and `Escape` navigate forms without mouse.
- [ ] **Screen Reader Semantics**: Enable TalkBack / VoiceOver; verify interactive widgets read labels.
- [ ] **Desktop Lifecycle (Windows)**: Minimize to tray; verify app does not terminate; restore from tray.

## 10. Common Mistakes
- Pumping widgets that use `Theme` or `Navigator` without wrapping them in `MaterialApp`.
- Forgetting `registerFallbackValue()` in mocktail, causing cryptic `ArgumentError` exceptions.
- Writing brittle tests that rely on widget tree depth or internal private widget types.

## 11. Completion Criteria
- Comprehensive tests written covering happy paths, edge cases, and failure scenarios.
- All test suites execute cleanly and deterministically with 0 failures.

## 12. Related Skills
- `coding-standards` — Testing Standards (Section 9) of `docs/FLUTTER_CODING_STANDARDS.md`; 8-step AI workflow Step 5 (TEST)
- `real-data-integrity`
- `golden-testing`
- `debugging`
- `error-handling`
- `flutter-architecture`
- `code-review`
