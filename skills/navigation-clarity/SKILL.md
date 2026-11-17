---
name: navigation-clarity
description: Navigation architecture clarity, icon usability audits, action discoverability, and accessibility labels.
---

# navigation-clarity

## 1. Skill Name
`navigation-clarity`

## 2. Purpose
Enforces unambiguous, predictable navigation hierarchies, recognizable icon usage, action discoverability, and screen-reader accessibility labels across Flutter applications. Eliminates obscure icon-only buttons, prevents overcrowded bottom navigation bars, organizes secondary actions into accessible menus, and ensures every interactive control clearly communicates its purpose.

## 3. When to Use
- When designing or auditing mobile bottom navigation bars (`NavigationBar`) or desktop sidebars (`NavigationRail`, `NavigationDrawer`).
- When reviewing screens with ambiguous or excessive icon-only buttons.
- When organizing primary, secondary, and contextual actions into menus (`PopupMenuButton`, `MenuAnchor`).
- When implementing accessible semantic descriptions (`Semantics`, `IconButton.tooltip`) for screen readers.
- When conducting a navigation usability audit on an existing application.

## 4. When Not to Use
- When configuring underlying declarative routing logic (e.g., path parsing or authentication redirect logic in `GoRouter`; use `navigation` skill instead).
- For non-interactive purely decorative graphics with `excludeFromSemantics: true`.

## 5. Required Project Context
- Target screen presentation files in `lib/features/`
- Navigation scaffold and routes in `lib/core/routing/`
- `docs/NAVIGATION_AND_ICON_STANDARDS.md`

## 6. Step-by-Step Workflow
1. **Audit Navigation Density**:
   - On Mobile: Ensure bottom navigation contains 3–5 essential, frequently used destinations with visible text labels.
   - On Desktop: Evaluate screen space to configure `NavigationRail` or persistent `NavigationDrawer`.
2. **Classify Interactive Actions**:
   - Triage actions into Primary, Secondary, Contextual, and Destructive.
   - Ensure primary daily workflows are prominently visible on the screen.
3. **Audit Icon-Only Controls**:
   - Inspect every `IconButton`. If the icon is not universally recognizable (like Search, Settings, Close), convert it to a labeled button (`FilledButton.icon`, `OutlinedButton.icon`) or menu item.
4. **Attach Action-Descriptive A11y Labels**:
   - Ensure every `IconButton` provides a `tooltip` describing the resulting action (e.g. `"Search invoice history"` rather than `"search icon"`).
   - Wrap custom gestures with `Semantics(button: true, label: '...')`.
5. **Organize Secondary Actions into Menus**:
   - Relocate infrequent actions (*Export*, *Help*, *Advanced Filters*) into an app bar or card `MenuAnchor` / `PopupMenuButton`.
   - Separate destructive actions with a divider and require explicit confirmation dialogs.
6. **Verify 10-Point Checklist**:
   - Review against the 10 points in `docs/NAVIGATION_AND_ICON_STANDARDS.md`.

## 7. Engineering Rules
- **No Mystery Meat Navigation**: Users must never have to guess what an icon does. If an icon is domain-specific or ambiguous, a visible text label is mandatory.
- **The 3–5 Destination Rule**: Mobile bottom navigation bars must have between 3 and 5 destinations. Fewer than 3 or more than 5 is prohibited.
- **Action-Descriptive Semantics**: Screen reader labels must describe the action performed, never the icon graphic name.
- **Tooltip Reliance Prohibition**: Never rely on tooltips as the sole cognitive explanation for touchscreens, as tooltips require long-press gestures on mobile.
- **Mandatory Confirmation for Destructive Actions**: Delete, reset, or purge operations must have a confirmation modal with red warning visual styling.
- **Touch Target Bounds**: Maintain 48x48dp interactive bounding boxes on mobile and 32x32dp on desktop.

## 8. Code Examples
```dart
// Labeled Action Button for Domain Operations
FilledButton.icon(
  onPressed: _reconcileLedger,
  icon: const Icon(Icons.sync_alt_rounded),
  label: const Text('Reconcile Ledger'),
)

// Accessible Universally Recognizable Icon Button
IconButton(
  icon: const Icon(Icons.search_rounded),
  tooltip: 'Search customer accounts', // Descriptive action, not "search"
  onPressed: _openSearch,
)

// Mobile NavigationBar with 4 Clear Destinations
NavigationBar(
  selectedIndex: currentIndex,
  onDestinationSelected: onTabSelected,
  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
  destinations: const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.receipt_long_outlined),
      selectedIcon: Icon(Icons.receipt_long_rounded),
      label: 'Invoices',
    ),
    NavigationDestination(
      icon: Icon(Icons.analytics_outlined),
      selectedIcon: Icon(Icons.analytics_rounded),
      label: 'Analytics',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline_rounded),
      selectedIcon: Icon(Icons.person_rounded),
      label: 'Profile',
    ),
  ],
)
```

## 9. Common Mistakes
- Placing 6 or 7 tabs in a mobile bottom bar, causing labels to wrap or truncate.
- Using an obscure icon like `Icons.flare` or `Icons.auto_awesome` without a label to perform a critical AI generation task.
- Providing semantic labels like `"button"` or `"icon"` that tell screen reader users nothing about what happens when tapped.
- Hiding the primary "Create New" action inside an obscure tertiary sub-menu.

## 10. Testing and Verification
- Assert all `IconButton` widgets provide non-empty `tooltip` or `Semantics.label` values.
- Verify screen reader reading order with `showSemanticsDebugger: true`.
- Run widget tests asserting that navigation bar destination taps trigger expected route changes.
- Verify `flutter analyze` passes cleanly with 0 warnings.

## 11. Completion Criteria
- Primary navigation contains 3–5 clearly labeled destinations on mobile.
- All ambiguous icon-only buttons replaced with labeled controls or clear menu items.
- All interactive controls have action-descriptive semantic labels.
- Destructive actions safeguarded with confirmation dialogs.
- 10-point Navigation & Icon checklist verified.

## 12. Related Skills
- `navigation`
- `ui-implementation`
- `accessibility`
- `design-system`
- `responsive-design`
