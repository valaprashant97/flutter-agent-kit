# Material 3 & Custom Theming Rules

These rules govern visual consistency, Material 3 adoption, and theme structures in Flutter.

---

## 1. Material 3 Enablement & Configuration

In modern Flutter (Flutter 3.16+), Material 3 is enabled by default (`useMaterial3: true`).

### Standard Theme Definition (`lib/core/theme/app_theme.dart`):
```dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6366F1), // Primary Brand Seed
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6366F1),
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
        ),
      ),
    );
  }
}
```

---

## 2. Invariants for UI Styling
1. **Never Hardcode Hex Colors in Widgets**: Always reference colors via `Theme.of(context).colorScheme.<color>` (e.g., `primary`, `surface`, `error`, `outlineVariant`) or a custom `ThemeExtension`.
2. **Never Hardcode Font Families**: Define fonts centrally in `ThemeData.textTheme` so the entire typography hierarchy scales consistently.
3. **Use `ColorScheme.on<Surface>` for Contrast**: Text on `primary` must use `colorScheme.onPrimary`. Text on `surface` must use `colorScheme.onSurface`. This guarantees accessible contrast in both light and dark themes.
