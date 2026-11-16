# Design Tokens & ThemeExtension Rules

These rules govern spacing systems, typography tokens, and custom brand properties using Flutter's `ThemeExtension`.

---

## 1. 8-Point Spacing Grid

All layout margins, paddings, and gaps must follow an 8-point (or 4-point for micro-elements) modular scale:

```dart
abstract final class AppSpacing {
  static const double xxs = 4.0;
  static const double xs  = 8.0;
  static const double sm  = 12.0;
  static const double md  = 16.0;
  static const double lg  = 24.0;
  static const double xl  = 32.0;
  static const double xxl = 48.0;
}
```

*Rule*: Never use arbitrary magic numbers (e.g., `padding: EdgeInsets.all(17.3)`). Always use standard spacing constants.

---

## 2. Custom Brand Tokens via `ThemeExtension`

When an application requires custom styling properties (such as semantic success/warning colors or card border radiuses) that are not part of Material 3's `ColorScheme`, use `ThemeExtension`:

```dart
import 'package:flutter/material.dart';

@immutable
class AppCustomColors extends ThemeExtension<AppCustomColors> {
  final Color success;
  final Color warning;
  final Color info;

  const AppCustomColors({
    required this.success,
    required this.warning,
    required this.info,
  });

  @override
  AppCustomColors copyWith({Color? success, Color? warning, Color? info}) {
    return AppCustomColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  AppCustomColors lerp(ThemeExtension<AppCustomColors>? other, double t) {
    if (other is! AppCustomColors) return this;
    return AppCustomColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }

  static const light = AppCustomColors(
    success: Color(0xFF10B981),
    warning: Color(0xFFF59E0B),
    info: Color(0xFF3B82F6),
  );

  static const dark = AppCustomColors(
    success: Color(0xFF34D399),
    warning: Color(0xFFFBBF24),
    info: Color(0xFF60A5FA),
  );
}
```

### Accessing in Widgets:
```dart
final customColors = Theme.of(context).extension<AppCustomColors>()!;
final badgeColor = customColors.success;
```
