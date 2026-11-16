---
name: golden-testing
description: Author, maintain, and automate visual regression and pixel-accurate Golden file tests across themes, devices, and resolutions.
---

# golden-testing

## 1. Skill Name
`golden-testing`

## 2. Purpose
Guides agents in writing deterministic visual regression tests using Flutter Golden files. Enforces exact viewport sizing, font rendering consistency, theme/state matrix coverage, and CI-standardized image comparison without false positive failures.

## 3. When to Use
- When building or modifying core design system components (buttons, typography, chips, cards, text fields).
- When verifying responsive layouts across mobile, tablet, and desktop viewports.
- When validating dark/light mode themes and high-contrast accessibility modes.
- When guarding against unintentional pixel regressions during framework or dependency upgrades.

## 4. When Not to Use
- For pure logic, data transformations, or state calculations (use unit tests).
- In early wireframing phases where visual components are rapidly changing every hour.

## 5. Required Project Context
- Component specifications and visual state matrix (hover, pressed, disabled, error).
- Target resolutions and theme configurations.

## 6. Step-by-Step Workflow
1. **Define Test File**: Create a dedicated test in `test/goldens/<feature>_golden_test.dart` tagged with `@Tags(['golden'])`.
2. **Lock Viewport**: Set `tester.view.physicalSize` and `tester.view.devicePixelRatio`. Add tear-down resets.
3. **Load Assets/Fonts**: Load app fonts if typography fidelity is required (`loadAppFonts()`).
4. **Pump Widget Matrix**: Render the widget wrapped in `MaterialApp` with explicitly assigned `ThemeData`.
5. **Settle Frame**: Call `await tester.pumpAndSettle()`.
6. **Execute Golden Match**: Call `await expectLater(find.byType(...), matchesGoldenFile(...))`.
7. **Generate Baselines**: Run `flutter test --tags=golden --update-goldens` to generate baseline PNGs.

## 7. Engineering Rules
- **Viewport Locking Rule**: Every golden test must set explicit physical dimensions and reset them in `addTearDown()`.
- **Steady State Rule**: Always call `pumpAndSettle()` prior to `matchesGoldenFile()`. Capturing intermediate animation frames leads to flaky tests.
- **Tag Isolation**: All golden tests must carry `@Tags(['golden'])` to allow fast CI filtering via `--exclude-tags=golden`.
- **CI Consistency**: CI must run golden verifications on standardized Linux runners to avoid cross-OS anti-aliasing mismatch.

## 8. Code Examples
```dart
// Multi-Theme Component Golden Test
@Tags(['golden'])
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('StatusCard renders correctly in light and dark mode', (tester) async {
    tester.view.physicalSize = const Size(360, 200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Light Theme
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        home: const Scaffold(body: StatusCard(status: 'Active', count: 42)),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(find.byType(StatusCard), matchesGoldenFile('goldens/status_card_light.png'));

    // Dark Theme
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: const Scaffold(body: StatusCard(status: 'Active', count: 42)),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(find.byType(StatusCard), matchesGoldenFile('goldens/status_card_dark.png'));
  });
}
```

## 9. Common Mistakes
- Committing golden files generated on macOS and verifying them on Windows CI (anti-aliasing mismatch).
- Forgetting to reset physical dimensions in `addTearDown()`, polluting subsequent tests in the suite.
- Capturing dynamic data (current timestamp, random avatars) causing tests to fail on every run.

## 10. Testing and Verification
- Run `flutter test --tags=golden` to verify matching against existing baselines.
- Verify that a deliberate 1-pixel color or padding change correctly triggers a test failure.

## 11. Completion Criteria
- Golden baseline images are generated and checked into source control.
- Tests pass deterministically in CI environments.
- Tests are tagged and isolated from standard unit tests.

## 12. Related Skills
- `testing`
- `design-system`
- `ui-implementation`
- `responsive-design`
