# Design System Specification (DESIGN.md)

## 1. Visual Direction & Principles
- **Aesthetic**: Modern, clean, functional, content-first.
- **Standards**: Material 3 with custom brand tokens via `ThemeExtension`.

---

## 2. Color Palette
### Light Theme
- `primary`: `#6366F1` (Indigo 600)
- `surface`: `#F8FAFC` (Slate 50)
- `onSurface`: `#0F172A` (Slate 900)
- `outlineVariant`: `#E2E8F0` (Slate 200)

### Dark Theme
- `primary`: `#818CF8` (Indigo 400)
- `surface`: `#0F172A` (Slate 900)
- `onSurface`: `#F8FAFC` (Slate 50)
- `outlineVariant`: `#334155` (Slate 700)

---

## 3. Spacing Grid (8-Point Modular Scale)
- `xxs`: 4dp (tight gaps, badge padding)
- `xs`: 8dp (inner item spacing)
- `sm`: 12dp (card inner spacing)
- `md`: 16dp (standard screen padding)
- `lg`: 24dp (section headers)
- `xl`: 32dp (page margins)

---

## 4. Typography Scale
- `headlineMedium`: 28sp / SemiBold
- `titleMedium`: 16sp / Medium
- `bodyMedium`: 14sp / Regular (Line height 1.4)
- `labelSmall`: 11sp / Medium

---

## 5. Responsive Breakpoints
- **Mobile (<600dp)**: Single column, bottom navigation bar, modal sheets.
- **Tablet (600-1024dp)**: Two-column grid, NavigationRail.
- **Desktop (>1024dp)**: Multi-pane master-detail, persistent sidebar, centered 1200dp max-width.
