# Workflow: UI Redesign & Visual Polish

This workflow defines the systematic visual upgrade process for elevating Flutter UI screens from prototype to production quality, enforcing the **One Coherent Design Language** principle (`docs/DESIGN_SYSTEM_STANDARDS.md`).

---

## 1. Entry Conditions
- Screen identified for visual overhaul or design alignment.
- `docs/DESIGN.md` or design tokens available.
- Reference to `docs/DESIGN_SYSTEM_STANDARDS.md`.

---

## 2. Step-by-Step Procedure

### Phase 1: Visual Audit & Inconsistency Triage
1. Inspect the existing screen implementation and its parent widget hierarchy.
2. Check for common visual defects:
   - Inconsistent padding (mixing arbitrary values like 7px, 13px, 20px).
   - Hardcoded hex colors (`Color(0xFF...)`) instead of active theme tokens.
   - Low contrast text or illegible dark mode rendering.
   - Missing loading skeletons or abrupt blank states.
   - Duplicate custom buttons or card wrappers instead of shared `core/` components.
   - Poor desktop stretching on wide screens.

### Phase 2: Design Token & Component Binding
1. Replace hardcoded colors with `Theme.of(context).colorScheme.<role>` or `BrandColors` extension.
2. Replace hardcoded paddings with `AppSpacing` tokens (4, 8, 12, 16, 24, 32, 48dp).
3. Harmonize card elevations, borders, and corner radii using `AppRadii` tokens.
4. Replace ad-hoc buttons, inputs, and cards with shared widgets from `lib/core/presentation/widgets/`.

### Phase 3: Polish Interactions & State Transitions
1. Add loading skeletons using shimmer placeholders matching active theme surface colors.
2. Add honest empty state view with 48dp outlined icon, descriptive text, and actionable CTA button.
3. Ensure mouse hover effects (`MouseRegion` / `InkWell`) and focus rings are active for desktop users.

### Phase 4: Responsive Verification & Contrast Audit
1. Test screen at 375px (mobile), 768px (tablet), and 1200px+ (desktop).
2. Constrain body content max-width (`ConstrainedBox(maxWidth: 1200dp)`) on widescreen desktop displays.
3. Verify WCAG AA contrast (4.5:1 for body copy) in both Light and Dark themes.

### Phase 5: Verification & Checklist Gate
1. Execute the mandatory 13-point design checklist in `docs/DESIGN_SYSTEM_STANDARDS.md`.
2. Run automated validation:
   ```bash
   flutter analyze
   flutter test test/widgets/
   flutter test --tags=golden
   ```

---

## 3. Exit Criteria
- Screen visually adheres to `docs/DESIGN.md` and `docs/DESIGN_SYSTEM_STANDARDS.md`.
- Shared components from `lib/core/presentation/widgets/` utilized.
- Both Light and Dark modes render with accessible contrast.
- All 4 UI states are implemented (Loading, Success, Empty, Error).
- All 13 items in the Mandatory Design Checklist verified.
- `flutter analyze` passes cleanly with 0 warnings.

---

## 4. Related Skills & Rules
- `skills/design-system/`
- `skills/ui-implementation/`
- `skills/responsive-design/`
- `workflows/design-consistency-audit/`
- `rules/ui-ux/design-tokens.md`
- `docs/DESIGN_SYSTEM_STANDARDS.md`
