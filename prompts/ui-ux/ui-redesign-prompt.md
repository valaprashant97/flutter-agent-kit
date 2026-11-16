# UI Redesign & Visual Polish Prompt

You are acting as a Senior Flutter UI/UX Engineer and Frontend Specialist guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Screen / Component**: [FILE PATH TO SCREEN OR COMPONENT UNDER REDESIGN]
- **Design Tokens Source**: `docs/DESIGN.md`
- **Architecture Source**: `docs/ARCHITECTURE.md`

---

## 2. OBJECTIVE
Upgrade the target screen or component to production-quality visual standards by eliminating visual defects, adhering strictly to design tokens, handling all 4 UI states, ensuring responsive layout adaptation, and enhancing desktop ergonomics.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE CURRENT SCREEN RENDERING, VISUAL FLAWS, LAYOUT DEFECTS, OR UNSTYLED RAW WIDGETS]

---

## 4. REQUIRED INVESTIGATION
1. Inspect the existing widget code and its parent layout tree.
2. Identify hardcoded colors, magic padding numbers, and unconstrained flex children.
3. Check state controller integration to identify how Loading, Empty, Success, and Error states are delivered.

---

## 5. CONSTRAINTS
- Zero hardcoded colors: All colors must resolve from `Theme.of(context).colorScheme` or custom `ThemeExtension`.
- Zero magic spacing numbers: Standardize on the 4pt/8pt grid (`rules/ui-ux/design-tokens.md`).
- Business logic separation: Do not introduce business logic, direct repository calls, or state mutation inside UI build methods.
- Preserve existing controller contracts and state interfaces.

---

## 6. ACCEPTANCE CRITERIA
- [ ] Visual hierarchy is clear with distinct typography levels (Headline, Body, Label).
- [ ] All 4 mandatory UI states are handled: Skeleton Loading, Success, Empty state with call-to-action, and Error state with Retry button.
- [ ] No `RenderFlex` overflow warnings on small or large viewports.
- [ ] Interactive elements provide hover (`MouseRegion` / `InkWell`) and focus indicators for desktop/web.
- [ ] Passes `flutter analyze` with 0 warnings.

---

## 7. EDGE CASES
- Extremely long localized text strings (must truncate with ellipsis or wrap without overflowing).
- Zero-item empty state vs network error state.
- Split-screen multitasking or aggressive window resizing on desktop.
- High-DPI display scaling and dark mode contrast ratios.

---

## 8. TESTING REQUIREMENTS
- Update or author widget tests verifying that all 4 UI states render correctly.
- Update or author golden tests (`skills/golden-testing/`) to capture the upgraded visual baseline.

---

## 9. EXPECTED OUTPUT
1. Audit summary of identified visual defects.
2. Surgical code modifications implementing the redesign.
3. Actual test and static analysis execution output (`flutter analyze`, `flutter test`).
