# Design System Specification (DESIGN.md)

This document defines the single source of truth for the visual design system, brand personality, design tokens, and component guidelines for this application. All UI screens and widgets must strictly consume these specifications.

---

## 1. Product Personality & Visual Direction

- **Product Archetype**: [Select one: Professional & Enterprise | Productivity-Focused | Creative & Expressive | Elegant & Premium | Friendly & Approachable | Data-Focused & Analytical | Minimal & Modern]
- **Target Audience & Environment**: [e.g., Office desktop analysts under indoor lighting / Mobile field agents under bright daylight]
- **Brand Personality**: [e.g., Trustworthy, crisp, high-density, minimal decoration]
- **Aesthetic Invariant**: One application, one coherent visual identity. Different screens may serve different purposes, but they must feel like parts of the same product.

---

## 2. Color Palette (13 Canonical Roles)

### Light Theme
- `primary`: `#4F46E5` (Indigo 600) — Main brand actions, active navigation
- `onPrimary`: `#FFFFFF` — Text/icons on primary
- `secondary`: `#06B6D4` (Cyan 600) — Accent highlights, secondary buttons
- `onSecondary`: `#FFFFFF` — Text on secondary
- `tertiary`: `#EC4899` (Pink 600) — Badges, notification pills
- `surface`: `#F8FAFC` (Slate 50) — Scaffold background canvas
- `surfaceContainer`: `#FFFFFF` (White) — Resting cards, modal sheets
- `surfaceContainerHigh`: `#F1F5F9` (Slate 100) — Form input fills, table headers
- `onSurface`: `#0F172A` (Slate 900) — Primary high-contrast text
- `onSurfaceVariant`: `#64748B` (Slate 500) — Captions, subtitles, placeholder text
- `outlineVariant`: `#E2E8F0` (Slate 200) — Card borders, dividers (1.0dp)
- `error`: `#EF4444` (Red 500) — Destructive actions, validation alerts
- `onError`: `#FFFFFF` — Text on error surfaces

### Dark Theme
- `primary`: `#818CF8` (Indigo 400) — Muted for accessible dark surface contrast
- `onPrimary`: `#0F172A` — High-contrast dark text on bright primary
- `secondary`: `#22D3EE` (Cyan 400) — Accent highlights
- `onSecondary`: `#0F172A` — Text on secondary
- `tertiary`: `#F472B6` (Pink 400) — Badges, notification pills
- `surface`: `#0B0F19` (Slate 950) — Deep canvas background
- `surfaceContainer`: `#1E293B` (Slate 800) — Resting cards
- `surfaceContainerHigh`: `#334155` (Slate 700) — Form input fills, modals
- `onSurface`: `#F8FAFC` (Slate 50) — Primary text
- `onSurfaceVariant`: `#94A3B8` (Slate 400) — Captions, secondary text
- `outlineVariant`: `#334155` (Slate 700) — Card borders, dividers (1.0dp)
- `error`: `#F87171` (Red 400) — Error alerts
- `onError`: `#0F172A` — Text on error surfaces

### Semantic Brand Extension (`ThemeExtension<BrandColors>`)
- `success`: Light `#10B981` / Dark `#34D399` (Completed tasks, positive metrics)
- `warning`: Light `#F59E0B` / Dark `#FBBF24` (Cautionary badges, pending items)
- `info`: Light `#3B82F6` / Dark `#60A5FA` (Informational alerts, tips)

---

## 3. Spacing Grid (4pt / 8pt Modular Scale)

All margins, paddings, and flex gaps must consume `AppSpacing`:
- `xxs`: `4.0dp` — Micro gaps, badge inner padding, icon-text gap
- `xs`: `8.0dp` — Tight spacing, chip padding, inner row gaps
- `sm`: `12.0dp` — Compact spacing, card inner padding, list item gaps
- `md`: `16.0dp` — Standard screen margin on mobile, default card padding
- `lg`: `24.0dp` — Section spacing, gaps between card groups
- `xl`: `32.0dp` — Modal padding, page header vertical spacing
- `xxl`: `48.0dp` — Hero spacing, desktop margins, empty state vertical gap

---

## 4. Typography Scale

- **Primary Font Family**: `Inter` (or platform native system font)
- **Hierarchy Mapping**:
  - `displayMedium`: 45sp / Bold / Line Height 1.2 — Landing heroes
  - `headlineMedium`: 28sp / SemiBold / Line Height 1.3 — Major screen titles
  - `headlineSmall`: 24sp / SemiBold / Line Height 1.3 — Modal & drawer headers
  - `titleLarge`: 20sp / SemiBold / Line Height 1.3 — Card headers, section titles
  - `titleMedium`: 16sp / Medium / Line Height 1.4 — List tile titles
  - `titleSmall`: 14sp / Medium / Line Height 1.4 — Subheadings, tab labels
  - `bodyLarge`: 16sp / Regular / Line Height 1.5 — Long-form reading text
  - `bodyMedium`: 14sp / Regular / Line Height 1.4 — Standard body copy, table cells
  - `bodySmall`: 12sp / Regular / Line Height 1.3 — Helper text, timestamps
  - `labelLarge`: 14sp / SemiBold / Letter Spacing 0.1 — Button text, tab titles
  - `labelMedium`: 12sp / Medium / Letter Spacing 0.5 — Chips, status badges
  - `labelSmall`: 11sp / Medium / Letter Spacing 0.5 — Captions, micro tags

---

## 5. Shapes & Corner Radii (`AppRadii`)

- `sm`: `6.0dp` — Small controls, badges, chips, progress indicators
- `md`: `10.0dp` — Standard buttons, text fields, search bars
- `lg`: `16.0dp` — Cards, dialogs, bottom sheets, master-detail panes
- `xl`: `24.0dp` — Floating modal dialogs, banners
- `full`: `999.0dp` — Circular avatar frames, pill buttons

---

## 6. Elevation, Borders & Surface Treatment

- **Resting Cards**: Elevation `0`, filled with `surfaceContainer`, outlined with 1.0dp `outlineVariant`.
- **Hovered Desktop Cards**: Elevation `2`, subtle outline transition.
- **Modals & Dialogs**: Elevation `3`, rounded corners `AppRadii.lg` (16dp).
- **Dividers & Strokes**: 1.0dp solid `outlineVariant`. Zero heavy shadows.

---

## 7. Iconography Standards

- **Primary Icon Family**: Material Rounded (`Icons.*_rounded`)
- **Standard Optical Sizing Scale**:
  - `16dp`: Micro icons (inside input helper text, inline chips)
  - `20dp`: Standard action icons (inside buttons, list trailing icons)
  - `24dp`: Navigation bars, app bar actions
  - `32dp`: Section headers, metric card leading icons
  - `48dp+`: Empty state illustrations, error view headers
- **Rule**: Avoid mixing unrelated icon libraries (e.g. sharp Material with Cupertino).

---

## 8. Core Reusable Component Library

The application maintains centralized widgets in `lib/core/presentation/widgets/`:
1. `AppButton`: Primary (Elevated), Secondary (Outlined), Ghost (Text), with built-in loading spinner and disabled states.
2. `AppCard`: Outlined card with 16dp padding, `AppRadii.lg`, and responsive desktop hover state.
3. `AppTextField`: Standardized input decoration, floating label, error text, and keyboard scroll safety.
4. `AppBadge`: Semantic status chip utilizing `BrandColors` (`success`, `warning`, `info`, `error`).
5. `AppEmptyState`: Honest empty view with 48dp outlined icon, `titleMedium` header, `bodyMedium` prompt, and actionable CTA button.
6. `AppLoadingSkeleton`: Shimmer placeholder for async data lists.
7. `AppErrorView`: Error banner with actionable retry callback.

---

## 9. Responsive Breakpoints

- **Mobile (<600dp)**: Single column, bottom `NavigationBar`, full-width modal sheets.
- **Tablet (600-1024dp)**: Two-column grid, persistent `NavigationRail`.
- **Desktop (>1024dp)**: Multi-pane master-detail, persistent `NavigationDrawer` or sidebar, body content wrapped in `ConstrainedBox(maxWidth: 1200dp)`.

---

## 10. Mandatory Design Checklist

Before certifying any UI screen, verify:
- [ ] Existing design system in `lib/core/theme/` and `docs/DESIGN.md` was inspected.
- [ ] Reusable components from `lib/core/presentation/widgets/` were reused where applicable.
- [ ] Screen adheres to the established visual identity and product archetype.
- [ ] Colors use `Theme.of(context).colorScheme` or `BrandColors`; zero hardcoded hex colors.
- [ ] Typography uses `Theme.of(context).textTheme`; zero arbitrary font sizes.
- [ ] Spacing strictly follows the `AppSpacing` 4pt/8pt grid.
- [ ] Corner radii use standard `AppRadii` tokens.
- [ ] Buttons respect visual hierarchy (one primary action per section).
- [ ] Icons belong to the standard icon family and optical size scale.
- [ ] Light and Dark themes both render with accessible contrast (WCAG AA).
- [ ] Layout is responsive across Mobile, Tablet, and Desktop without overflows.
- [ ] Minimum tap targets (48x48dp mobile, 32x32dp desktop) are satisfied.
- [ ] No unnecessary or distracting decorative elements were added.
