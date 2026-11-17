# Workflow: Design System & Design Tokens Implementation

This workflow guides an AI coding agent through establishing, tokenizing, and implementing a scalable design system for Flutter applications using Material 3, custom ThemeExtensions, `templates/DESIGN.md`, and `docs/DESIGN_SYSTEM_STANDARDS.md`.

---

## 1. Entry Conditions
- Product requirements (`docs/PRD.md`) and UI vision are defined.
- Design tokens, Figma components, or brand guidelines are provided.
- Reference to `docs/DESIGN_SYSTEM_STANDARDS.md`.

---

## 2. Step-by-Step Procedure

### Phase 1: Define Design Tokens (`docs/DESIGN.md`)
1. Create or update `docs/DESIGN.md` using `templates/DESIGN.md`.
2. Classify the product archetype from the 7 design direction archetypes (e.g. Professional & Enterprise, Productivity-Focused, Creative, Data-Focused).
3. Define the foundation tokens:
   - **Color Palette (13 Roles)**: Primary, Secondary, Tertiary, Background, Surface, Surface Container, Text Primary, Text Secondary, Outline, Success, Warning, Error, Disabled (Hex codes for Light & Dark mode).
   - **Typography Scale**: Display, Headline, Title, Body, Label, Caption (Font family, weights, sizes, line heights).
   - **Spacing & Radii Scale**: Fixed 4pt/8pt grid (`AppSpacing`: 4, 8, 12, 16, 24, 32, 48dp) and border radii (`AppRadii`: 6, 10, 16, 24, 999dp).
   - **Elevation & Surface Treatments**: Elevation 0 (flat outlined) to 3 (modal) definitions.
   - **Iconography Standards**: Unified icon family (e.g. `Icons.*_rounded`) and standard optical sizes (16, 20, 24, 32, 48dp).

### Phase 2: Implement Flutter ThemeData & ColorScheme
1. Build `lib/core/theme/color_schemes.dart`:
   - Generate `ColorScheme.fromSeed` or explicit `ColorScheme.light()` and `ColorScheme.dark()`.
2. Build `lib/core/theme/text_theme.dart`:
   - Define canonical `TextTheme` mapped to design typography tokens.
3. Configure `ThemeData` (`lib/core/theme/app_theme.dart`):
   - Wire button themes (`ElevatedButtonThemeData`, `OutlinedButtonThemeData`).
   - Wire input decoration themes (`InputDecorationTheme`).
   - Wire card and dialog themes (`CardTheme`, `DialogTheme`).
   - Wire navigation themes (`NavigationBarThemeData`, `NavigationRailThemeData`).

### Phase 3: Implement Custom ThemeExtensions
For brand tokens outside Material 3 (e.g. custom semantic status colors like `warning`, `info`, `success` or custom card gradients):
```dart
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
}
```

### Phase 4: Atomic UI Component Library
1. Build reusable core components in `lib/core/presentation/widgets/`:
   - `AppButton` (Primary, Secondary, Ghost, Loading, Disabled states)
   - `AppTextField` (Idle, Focused, Error, Disabled states)
   - `AppCard` (Elevated, Outlined, Hover states)
   - `AppBadge` (Success, Warning, Error status chips)
   - `AppEmptyState` (Honest empty state view with icon and action button)
   - `AppErrorView` (Standardized error view with retry callback)
   - `AppLoadingSkeleton` (Shimmer skeleton placeholder)
2. Verify accessibility contrast ratios meet WCAG AA standards (4.5:1 for normal text).

### Phase 5: Golden Visual Baseline Verification & Checklist Gate
1. Author golden tests in `test/goldens/design_system_golden_test.dart`.
2. Generate baseline images via `flutter test --tags=golden --update-goldens`.
3. Verify all 13 items in the Mandatory Design Checklist (`docs/DESIGN_SYSTEM_STANDARDS.md`).

---

## 3. Exit Criteria & Quality Gates
- [ ] `docs/DESIGN.md` contains complete tokens for Light and Dark modes.
- [ ] Both `lightTheme` and `darkTheme` pass WCAG AA color contrast checks.
- [ ] Core atomic components support all interactive states (loading, disabled, hover).
- [ ] Golden baseline images are generated and verified.
- [ ] All 13 items in the Mandatory Design Checklist verified.
- [ ] `flutter analyze` passes cleanly with 0 warnings.

---

## 4. Related Skills & Rules
- `skills/design-system/`
- `skills/golden-testing/`
- `skills/accessibility/`
- `workflows/design-consistency-audit/`
- `rules/ui-ux/material-3.md`
- `rules/ui-ux/design-tokens.md`
- `docs/DESIGN_SYSTEM_STANDARDS.md`
