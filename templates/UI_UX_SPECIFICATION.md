# UI/UX & Interaction Specification: [Project Name]

## 1. Visual Hierarchy & Reading Flow
- **Archetype**: [e.g. Modern Clean / Professional Enterprise / Data Dense]
- **Reading Pattern**: Left-to-right, top-to-bottom visual hierarchy.
- **Visual Weighting**:
  1. Level 1: Primary Action Button (High emphasis, filled container).
  2. Level 2: Screen Heading & Key Metric Cards (Prominent font weight, distinct elevation).
  3. Level 3: List Items & Data Rows (Scannable typography, subtle borders).
  4. Level 4: Secondary Actions & Metadata (Tonal/outlined buttons, muted secondary text).

---

## 2. Interaction Behaviors & Gestures
- **Tap / Click**: Immediate ripple feedback (< 50ms response).
- **Long Press**: Contextual tooltip or context menu overlay.
- **Swipe-to-Dismiss**: Available only on non-destructive list items; requires undo snackbar.
- **Pull-to-Refresh**: Available on scrollable feeds and overview dashboards.
- **Keyboard Navigation (Desktop & Web)**:
  - `Tab` / `Shift+Tab`: Forward / backward element traversal.
  - `Enter` / `Space`: Activate focused button or toggle switch.
  - `Esc`: Dismiss active modal, bottom sheet, or dropdown menu.
  - `Ctrl+F` / `Cmd+F`: Focus search input.

---

## 3. Micro-Interactions & Transitions
- **Button Press**: Slight scale down ($0.98\times$) on tap down, returning on release.
- **Page Transitions**: Shared axis or slight horizontal slide with ease-in-out curve ($200\text{--}300\text{ ms}$).
- **Skeleton Shimmer**: Linear gradient shimmer moving left to right at $1200\text{ ms}$ period.
- **Form Validation**: Immediate inline checkmark upon valid entry; subtle error shake on submit with invalid fields.

---

## 4. Accessibility & Inclusive Design (WCAG 2.1 AA)
- **Contrast Ratios**:
  - Normal text (< 18pt): Minimum $4.5:1$ against surface background.
  - Large text ($\ge 18\text{pt}$ or bold $\ge 14\text{pt}$): Minimum $3:1$ against background.
  - Interactive UI components & icons: Minimum $3:1$ against background.
- **Touch Target Dimensions**: Minimum $48 \times 48\text{ pt}$ for all touch targets.
- **Screen Reader Support**: All icons, images, and custom buttons must provide `Semantics(label: '...')`.
- **Motion Reduction**: Respect platform `prefers-reduced-motion` settings by disabling non-essential animations.
