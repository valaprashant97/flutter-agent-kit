# Visual Design System Specification Prompt

You are acting as a Senior Product Designer and UX/UI Design Systems Engineer specializing in Flutter applications under the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application**: [APP NAME & DOMAIN]
- **Target Platforms**: [Windows Desktop, Android, iOS, Web, macOS, Linux]
- **Foundation Documents**: `docs/PRD.md`, `docs/ARCHITECTURE.md`, and `docs/DESIGN_SYSTEM_STANDARDS.md`

---

## 2. OBJECTIVE
Author a comprehensive, production-grade `docs/DESIGN.md` using `templates/DESIGN.md` that serves as the single source of truth for the visual design system, defining product archetype, design tokens, 13 canonical color roles, typography scales, 4pt/8pt spacing grids, component states, and responsive breakpoints.

---

## 3. EXISTING BEHAVIOR
- Greenfield: No existing design system; establish consistent brand tokens from scratch.
- Brownfield: [DESCRIBE EXISTING THEMING, BRAND ASSETS, OR CURRENT UI PAIN POINTS]

---

## 4. REQUIRED INVESTIGATION
1. Review `docs/PRD.md` to identify target user demographics, usage lighting conditions, and device form factors.
2. Select an intentional product archetype from the 7 design direction archetypes in `docs/DESIGN_SYSTEM_STANDARDS.md` (e.g. Professional & Enterprise, Productivity-Focused, Creative & Expressive, Data-Focused).
3. Check Material 3 guidelines and color science rules for WCAG AA compliance (contrast ratio $\ge$ 4.5:1).
4. If Figma tokens or brand style guides exist, inspect them for exact hex values and typography weights.

---

## 5. CONSTRAINTS
- Strict compliance with Material 3 theming paradigms and `docs/DESIGN_SYSTEM_STANDARDS.md`.
- One application, one coherent visual identity: do not design screens in isolation.
- Complete palette definitions required for **both Light and Dark modes** across all 13 canonical color roles.
- Standardize on the 4pt/8pt spacing scale (`AppSpacing`) and standard corner radii (`AppRadii`).
- All interactive components must define states: Default, Hover (desktop/web), Pressed, Focused, Disabled, Loading, and Error.
- Do not write Dart code during this design token specification phase.

---

## 6. ACCEPTANCE CRITERIA
- [ ] Product archetype and brand personality clearly specified.
- [ ] Complete color palette with hex codes and role assignments across 13 roles (Primary, Surface, Error, Containers, Outlines).
- [ ] Semantic tokens defined via `ThemeExtension`: Success, Warning, Info.
- [ ] Typography scale mapped directly to Flutter's `TextTheme` (Display, Headline, Title, Body, Label).
- [ ] 4pt/8pt spacing grid (`AppSpacing`) and corner radius tokens (`AppRadii`) established.
- [ ] Responsive layout breakpoints: Mobile (<600dp), Tablet (600-1024dp), Desktop (>1024dp).
- [ ] Specifications for Skeleton loading shimmer and honest Empty states.
- [ ] Mandatory 13-point Design Checklist included.

---

## 7. EDGE CASES
- High-contrast accessibility modes and large dynamic text scaling (1.5x / 2.0x).
- Desktop mouse hover vs mobile touch interaction feedback.
- Window resizing across arbitrary aspect ratios on desktop.
- Dark mode readability on OLED vs LCD displays.

---

## 8. TESTING REQUIREMENTS
- Design specifications must be verifiable via Golden visual regression tests (`skills/golden-testing/`).
- Color combinations must pass automated WCAG AA contrast ratio calculations.

---

## 9. EXPECTED OUTPUT
A clean, complete Markdown document ready to save directly as `docs/DESIGN.md` matching `templates/DESIGN.md`.
