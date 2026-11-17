---
name: design-system
description: Global design consistency, design tokens, Material 3 theming, typography hierarchy, and ThemeExtension implementation.
---

# design-system

## 1. Skill Name
`design-system`

## 2. Purpose
Establishes and enforces a unified, cohesive design system across all screens in Flutter applications. Standardizes design tokens (colors, typography, modular spacing, corner radii, elevation, iconography), establishes brand identity archetypes, ensures Light and Dark mode parity, and promotes reusable UI components to guarantee that every screen feels like part of the same application.

## 3. When to Use
- When initiating a new Flutter project's theme or design foundation.
- When establishing `docs/DESIGN.md` from product requirements.
- When standardizing fragmented, hardcoded colors, arbitrary paddings, and font sizes across multiple screens.
- When creating custom semantic brand tokens (success, warning, info) via `ThemeExtension`.
- When enforcing screen-to-screen visual consistency between dashboards, forms, lists, dialogs, and detail views.

## 4. When Not to Use
- When making a single-line bugfix that already consumes existing theme tokens properly.
- For backend, database, or network-only features devoid of presentation UI.

## 5. Required Project Context
- `docs/DESIGN.md` or brand style guide / Figma design tokens.
- Existing `ThemeData` configuration in `lib/core/theme/`.
- Target application archetype (e.g. Enterprise, Productivity, Creative, Analytical).
- `docs/DESIGN_SYSTEM_STANDARDS.md` (Global Design Consistency System specification).

## 6. Step-by-Step Workflow
1. **Discover & Classify Archetype**: Understand the app's purpose and users. Select one of the 7 design direction archetypes (e.g., Professional Enterprise, Productivity-Focused, Data-Focused).
2. **Define Foundation Tokens**:
   - Establish 13 canonical color roles (Primary, Secondary, Surface, Text, Borders, Success, Warning, Error) for Light and Dark modes.
   - Define a 4pt/8pt modular spacing grid (`AppSpacing`: xxs: 4, xs: 8, sm: 12, md: 16, lg: 24, xl: 32, xxl: 48dp).
   - Standardize corner radii (`AppRadii`: sm: 6, md: 10, lg: 16, xl: 24, full: 999dp).
   - Select a single consistent icon library (e.g., `Icons.*_rounded`) and optical sizing scale (16, 20, 24, 32, 48dp).
3. **Configure Flutter Native Theming**:
   - Author `ColorScheme.fromSeed` or explicit light and dark `ColorScheme` instances.
   - Author `TextTheme` mapped to standard typography tokens.
   - Wire global component themes in `ThemeData`: `AppBarTheme`, `CardTheme`, `ElevatedButtonTheme`, `OutlinedButtonTheme`, `InputDecorationTheme`, `DialogTheme`.
4. **Implement Custom `ThemeExtension`**: Build immutable `ThemeExtension` for semantic status colors (`success`, `warning`, `info`) and custom brand attributes.
5. **Author Core Reusable Widgets**: Establish shared buttons, text fields, cards, dialogs, empty states, and shimmer loading skeletons in `lib/core/presentation/widgets/`.
6. **Execute Design Review Checklist**: Verify all screens against the 13-point design checklist before marking UI tasks complete.

## 7. Engineering Rules
- **One Coherent Design Language**: Every screen must look and feel like part of the same application. Never invent independent styling on isolated screens.
- **Zero Hardcoded Hex Colors**: Hardcoding `Color(0xFF...)` inside widget build methods is strictly forbidden. All colors must resolve from `Theme.of(context).colorScheme` or `ThemeExtension`.
- **Zero Magic Spacing Numbers**: Never use arbitrary margins or paddings (e.g., `EdgeInsets.all(17.3)`). Always use `AppSpacing` tokens.
- **ThemeExtension Immutability**: All fields in custom `ThemeExtension` classes must be `final` and implement `copyWith` and `lerp`.
- **Accessible Contrast Guarantee (WCAG AA)**: Normal text must meet at least 4.5:1 contrast against its background. Text on primary must use `colorScheme.onPrimary`; text on surface must use `colorScheme.onSurface`.
- **Light & Dark Theme Parity**: Every component must look intentional and polished in both Light and Dark themes. Never use light-only or dark-only color assumptions.
- **Honest Visual Verification**: When screenshot or emulator preview is available, inspect rendered widgets. Never claim visual verification occurred if no visual inspection took place.

## 8. Code Examples
```dart
// Custom Semantic Brand Tokens Extension
import 'dart:ui';
import 'package:flutter/material.dart';

@immutable
class BrandColors extends ThemeExtension<BrandColors> {
  final Color success;
  final Color warning;
  final Color info;

  const BrandColors({
    required this.success,
    required this.warning,
    required this.info,
  });

  @override
  BrandColors copyWith({Color? success, Color? warning, Color? info}) {
    return BrandColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  BrandColors lerp(ThemeExtension<BrandColors>? other, double t) {
    if (other is! BrandColors) return this;
    return BrandColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }

  static const light = BrandColors(
    success: Color(0xFF10B981),
    warning: Color(0xFFF59E0B),
    info: Color(0xFF3B82F6),
  );

  static const dark = BrandColors(
    success: Color(0xFF34D399),
    warning: Color(0xFFFBBF24),
    info: Color(0xFF60A5FA),
  );
}
```

## 9. Common Mistakes
- Hardcoding colors and font sizes in individual widget files instead of configuring global component themes in `ThemeData`.
- Missing `lerp()` implementations in `ThemeExtension`, which causes jarring visual snaps during light/dark theme switches.
- Mixing multiple unrelated icon libraries (e.g., pairing sharp Cupertino icons with rounded Material icons).
- Using random corner radii across identical visual elements (e.g., 8dp on cards on screen A, 16dp on screen B).
- Neglecting empty states or rendering static fake records instead of honest empty views.

## 10. Testing and Verification
- Run `flutter test` to verify theme lookup and `ThemeExtension` resolution.
- Execute golden tests (`skills/golden-testing/`) to verify pixel-perfect theme rendering across Light and Dark modes.
- Verify color contrast ratios against WCAG AA requirements (4.5:1 for normal text).
- Execute the 13-point design checklist prior to PR submission.

## 11. Completion Criteria
- Centralized theme architecture established in `lib/core/theme/`.
- `docs/DESIGN.md` authored and aligned with `docs/DESIGN_SYSTEM_STANDARDS.md`.
- Light and Dark modes both supported with 100% color role parity.
- Reusable UI component library established in `lib/core/presentation/widgets/`.
- `flutter analyze` passes cleanly with 0 warnings.

## 12. Related Skills
- `ui-implementation`
- `responsive-design`
- `golden-testing`
- `accessibility`
- `real-data-integrity`
