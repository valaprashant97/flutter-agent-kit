# Workflow: UI Redesign & Visual Polish

This workflow defines the systematic visual upgrade process for elevating Flutter UI screens from prototype to production quality.

---

## 1. Entry Conditions
- Screen identified for visual overhaul or design alignment.
- `docs/DESIGN.md` or design tokens available.

---

## 2. Step-by-Step Procedure

### Phase 1: Visual Audit
1. Inspect the existing screen implementation.
2. Check for common visual defects:
   - Inconsistent padding (mixing 7px, 13px, 20px).
   - Hardcoded hex colors instead of theme tokens.
   - Low contrast text.
   - Missing loading skeletons or abrupt blank states.
   - Poor desktop stretching on wide screens.

### Phase 2: Design Token Binding
1. Replace hardcoded colors with `Theme.of(context).colorScheme.<role>`.
2. Replace hardcoded paddings with `AppSpacing` (8, 16, 24dp).
3. Standardize card elevations, borders, and border radiuses.

### Phase 3: Polish Interactions & State Transitions
1. Add loading skeletons using `Skeletonizer` or shimmer placeholders.
2. Add friendly empty state illustration with call-to-action button.
3. Ensure mouse hover effects (`MouseRegion`) are active for desktop users.

### Phase 4: Responsive Verification
1. Test screen at 375px (mobile), 768px (tablet), and 1200px (desktop).
2. Constrain form max-widths on widescreen displays.

### Phase 5: Verification
```bash
flutter analyze
flutter test test/path/to/screen_test.dart
```

---

## 3. Exit Criteria
- Screen visually adheres to `docs/DESIGN.md`.
- Both Light and Dark modes render with accessible contrast.
- All 4 UI states are implemented.
