---
name: design-system
description: Design tokens, Material 3 theming, typography hierarchy, and ThemeExtension implementation.
---

# design-system

## 1. Skill Name
`design-system`

## 2. Purpose
Establishes a unified, cohesive design system for Flutter applications. Standardizes color tokens, typography scales, spacing grids, card elevations, button styles, and custom `ThemeExtension` classes across both Light and Dark modes.

## 3. When to Use
- When initiating a new Flutter project's theme.
- When consolidating fragmented, hardcoded colors and font sizes into a clean design system.
- When adding custom brand colors that fall outside the standard Material 3 color roles.

## 4. When Not to Use
- When making a one-line styling tweak that already consumes existing theme tokens.

## 5. Required Project Context
- Brand style guide, Figma tokens, or `docs/DESIGN.md`
- Existing `ThemeData` configuration

## 6. Step-by-Step Workflow
1. **Define Core Palette**: Select primary, secondary, tertiary, and neutral seed colors.
2. **Generate `ColorScheme`**: Generate light and dark `ColorScheme` instances using `ColorScheme.fromSeed()`.
3. **Establish Spacing Constants**: Define standard spacing tokens (4, 8, 12, 16, 24, 32, 48dp) in `AppSpacing`.
4. **Configure Typography**: Build `TextTheme` with consistent headline, title, body, and label styles.
5. **Create `ThemeExtension`**: Build a custom `ThemeExtension` for semantic colors (success, warning, info, danger badges).
6. **Apply Component Themes**: Define app-wide defaults for `AppBarTheme`, `CardTheme`, `ElevatedButtonTheme`, and `InputDecorationTheme`.

## 7. Engineering Rules
- **Contrast Guarantee**: Text displayed on a surface must use `onSurface`; text on primary must use `onPrimary`.
- **Both Themes Required**: Every design system must provide both a Light and a Dark theme variation.
- **ThemeExtension Immutability**: All fields in custom `ThemeExtension` classes must be `final` and implement `copyWith` and `lerp`.

## 8. Code Examples
```dart
// Custom Brand Tokens Extension
@immutable
class BrandTokens extends ThemeExtension<BrandTokens> {
  final Color success;
  final Color warning;
  final double cardBorderRadius;

  const BrandTokens({
    required this.success,
    required this.warning,
    required this.cardBorderRadius,
  });

  @override
  BrandTokens copyWith({Color? success, Color? warning, double? cardBorderRadius}) {
    return BrandTokens(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
    );
  }

  @override
  BrandTokens lerp(ThemeExtension<BrandTokens>? other, double t) {
    if (other is! BrandTokens) return this;
    return BrandTokens(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      cardBorderRadius: lerpDouble(cardBorderRadius, other.cardBorderRadius, t)!,
    );
  }
}
```

## 9. Common Mistakes
- Overriding colors locally on every widget instead of configuring global component themes.
- Missing the `lerp()` implementation in `ThemeExtension`, causing jarring snap-transitions when switching between light and dark modes.

## 10. Testing and Verification
- Verify that toggling between `ThemeMode.light` and `ThemeMode.dark` updates all components smoothly without text disappearing against inverted backgrounds.
- Run `flutter test` to verify theme extension lookup.

## 11. Completion Criteria
- Centralized theme files exist in `lib/core/theme/`.
- Light and Dark modes are fully supported.
- `flutter analyze` passes cleanly.

## 12. Related Skills
- `ui-implementation`
- `responsive-design`
- `accessibility`
