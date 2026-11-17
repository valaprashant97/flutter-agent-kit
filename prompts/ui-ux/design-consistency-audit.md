# Design Consistency & System Audit Prompt

You are acting as a Principal Flutter UI/UX Architect and Design Systems Specialist guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application**: [APP NAME & ROOT DIRECTORY]
- **Target Platforms**: [Windows Desktop, Android, iOS, Web, macOS, Linux]
- **Standards & Specifications**: `docs/DESIGN_SYSTEM_STANDARDS.md`, `skills/design-system/`, `workflows/design-consistency-audit/`
- **Design Tokens Source**: `docs/DESIGN.md` (or `templates/DESIGN.md` if establishing baseline)

---

## 2. OBJECTIVE
Conduct a comprehensive visual design consistency audit across all application screens to identify and eliminate design drift, hardcoded styling, arbitrary spacing, mismatched corner radii, competing icon sets, and light/dark theme contrast failures—ensuring that every screen feels like part of one cohesive, professional product.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE CURRENT SCREEN APPEARANCES, DETECTED VISUAL INCONSISTENCIES, HARDCODED COLORS, OR FRACTURED THEMES]

---

## 4. REQUIRED INVESTIGATION
1. Inspect `lib/core/theme/` and `docs/DESIGN.md` to identify the established brand tokens and design direction archetype.
2. Scan all presentation widgets in `lib/` for:
   - Raw `Color(0x...)` or `Colors.<color>` calls inside build methods.
   - Arbitrary spacing and padding numbers deviating from the 4pt/8pt grid (`AppSpacing`).
   - Mismatched `BorderRadius` values across cards, buttons, dialogs, and text fields.
   - Competing icon libraries (e.g. sharp Material mixed with Cupertino or outline icons).
   - Unreadable text or low-contrast surfaces in Dark mode.
3. Classify all detected inconsistencies using the 4-tier Severity Matrix (Critical, Major, Minor, Polish) defined in `docs/DESIGN_SYSTEM_STANDARDS.md`.

---

## 5. CONSTRAINTS
- One application, one coherent visual identity: do not allow individual screens to invent private styling.
- Zero hardcoded colors: all colors must resolve from `Theme.of(context).colorScheme` or custom `ThemeExtension`.
- Zero magic spacing numbers: standardize on the 4pt/8pt modular grid (`4, 8, 12, 16, 24, 32, 48dp`).
- Preserve existing brand identity: do not perform unsolicited total redesigns unless explicitly instructed.
- Reusable component priority: reuse existing buttons, text fields, cards, and feedback views from `lib/core/presentation/widgets/`.
- Honesty in visual verification: never claim visual inspection if no actual visual rendering or screenshot review took place.

---

## 6. ACCEPTANCE CRITERIA
- [ ] Audit Findings Report generated detailing Screen/Component, File Path, Inconsistency, Severity, and Remediation.
- [ ] All Critical (contrast/dark mode) and Major (conflicting visual language) defects resolved.
- [ ] Centralized tokens in `lib/core/theme/` consumed consistently across all modified screens.
- [ ] Reusable UI components from `lib/core/presentation/widgets/` utilized instead of duplicate implementations.
- [ ] Light and Dark modes render with accessible contrast (WCAG AA 4.5:1 for body copy).
- [ ] Mandatory 13-point Design Checklist fully satisfied.
- [ ] `flutter analyze` passes with 0 errors and 0 warnings.

---

## 7. EDGE CASES
- High-contrast accessibility mode and large system font scaling (1.5x / 2.0x).
- Extreme window aspect ratios and multi-monitor mixed DPI scaling on desktop.
- Dark theme rendering on OLED vs LCD displays (tonal surfaces vs true black).
- Incomplete data rendering: ensuring empty and error states look visually harmonious with populated screens.

---

## 8. TESTING REQUIREMENTS
- Author or update widget tests verifying theme resolution and contrast in both Light and Dark modes.
- Author or update golden regression tests (`skills/golden-testing/`) to establish unified visual baselines.
- Execute `flutter test` across all presentation test suites.

---

## 9. EXPECTED OUTPUT
1. **Design Inconsistency Audit Report**: Structured table containing identified defects, severity ratings, and exact file paths.
2. **Surgical Remediation Diffs**: Clean, focused code modifications harmonizing widgets to global design tokens.
3. **Checklist & Verification Evidence**: Completed 13-point design checklist, test execution outputs, and static analysis verification (`flutter analyze`).
