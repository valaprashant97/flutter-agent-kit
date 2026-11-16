# Golden Visual Regression Testing Rules

This guide outlines production rules for authoring, maintaining, and automating visual regression and **Golden file** tests in Flutter.

---

## 1. When to Use Golden Tests
- **Recommended For**:
  - Design system component libraries (buttons, cards, badges, inputs in all visual states: default, hover, focused, disabled, error).
  - Complex custom UI screens (e.g. dashboards, charts, checkout summaries).
  - Responsive layout validation across multiple device sizes (mobile, tablet, desktop) and theme modes (light vs dark).
  - Accessibility visual checks (high contrast modes, text scaling 1.5x / 2.0x).
- **Not Recommended For**:
  - Simple business logic or state transitions with no novel visual presentation (use standard unit tests).
  - High-frequency volatile screens undergoing daily redesign.

---

## 2. Production Golden Test Pattern

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('PrimaryButton renders correctly in all states', (tester) async {
    // 1. Set explicit surface size for deterministic rendering
    tester.view.physicalSize = const Size(400, 600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // 2. Build Widget with Theme
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        home: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Confirm Action'),
            ),
          ),
        ),
      ),
    );

    // 3. Match against golden baseline image
    await expectLater(
      find.byType(ElevatedButton),
      matchesGoldenFile('goldens/primary_button_default.png'),
    );
  });
}
```

---

## 3. Critical Golden Test Invariants

1. **Deterministic Environment & Viewport**:
   - Always lock `tester.view.physicalSize` and `tester.view.devicePixelRatio` before capturing the golden image.
   - Always reset sizes in `addTearDown()`.
2. **Font Handling**:
   - Standard Flutter tests replace all text with the black block `Ahem` font to ensure deterministic cross-platform sizing.
   - If testing real fonts or design system typography, use a package like `golden_toolkit` with `loadAppFonts()` to load real `.ttf` assets.
3. **Cross-Platform Anti-Aliasing Differences**:
   - Subpixel anti-aliasing renders slightly differently between Windows, macOS, and Linux.
   - **Production Rule**: Generate and verify golden tests inside a standardized CI environment (e.g. Linux container in GitHub Actions) to prevent local OS rendering differences from failing builds.
4. **Tagging & Separation**:
   - Tag all golden tests with `@Tags(['golden'])` at the top of the file so developers can run fast unit tests without triggering golden image comparisons:
   ```bash
   # Run only unit/widget tests
   flutter test --exclude-tags=golden

   # Run and update goldens
   flutter test --tags=golden --update-goldens
   ```
5. **Animation Settling**:
   - Always call `await tester.pumpAndSettle()` before matching goldens to ensure all transitions, micro-animations, and tickers have reached their steady terminal state.
