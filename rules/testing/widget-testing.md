# Widget Testing & Interaction Rules

These rules govern component-level UI testing using Flutter's built-in `WidgetTester`.

---

## 1. Standard Widget Test Pattern

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PrimaryButton Widget Tests', () {
    testWidgets('renders title and triggers callback on tap', (WidgetTester tester) async {
      var tapped = false;

      // 1. Pump the widget inside a MaterialApp scaffold
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              label: 'Submit',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      // 2. Verify visual presence
      expect(find.text('Submit'), findsOneWidget);

      // 3. Simulate tap interaction
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle(); // Await ripple animations

      // 4. Verify behavioral outcome
      expect(tapped, isTrue);
    });

    testWidgets('displays CircularProgressIndicator when isLoading is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              label: 'Submit',
              isLoading: true,
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Submit'), findsNothing);
    });
  });
}
```

---

## 2. Invariants for Widget Testing

### `pump()` vs `pumpAndSettle()`
- **`tester.pump()`**: Advances the clock by a single frame (or specified duration). Use when testing specific intermediate frames of an animation.
- **`tester.pumpAndSettle()`**: Repeatedly advances frames until no scheduled animations or timers remain.
- *Caution*: Never call `pumpAndSettle()` if the widget contains an infinite animation (e.g., repeating loading spinners or pulse animations), as it will throw a `FlutterError: pumpAndSettle timed out`. In those cases, use `tester.pump(const Duration(milliseconds: 500))`.

### Providing Ancestors
Widgets that use `Theme.of(context)`, `MediaQuery.of(context)`, or `Navigator.of(context)` must always be pumped inside a `MaterialApp` or `CupertinoApp`.

### Finding Widgets
- Prefer semantic finders (`find.text('...')`, `find.byIcon(...)`, `find.byTooltip(...)`).
- Use `find.byKey(...)` when multiple identical text labels or icons exist on screen.
- Avoid finding by generic raw widgets (`find.byType(Container)`) as Flutter layouts frequently wrap elements in internal containers.
