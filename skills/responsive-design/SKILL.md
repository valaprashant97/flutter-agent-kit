---
name: responsive-design
description: Adaptive and responsive layout design for Mobile, Tablet, and Desktop screen widths in Flutter.
---

# responsive-design

## 1. Skill Name
`responsive-design`

## 2. Purpose
Provides architectures and layout techniques for creating fluid, responsive Flutter applications that run seamlessly across Mobile (<600dp), Tablet (600-1024dp), and Desktop (>1024dp) viewports.

## 3. When to Use
- When adapting mobile-first Flutter apps to run on Windows, macOS, Linux, or Web.
- When creating multi-pane master-detail views or adaptive dashboards.
- When fixing layout stretching on widescreen monitors.

## 4. When Not to Use
- For dedicated mobile-only applications that do not support tablet or desktop orientations.

## 5. Required Project Context
- `lib/features/` target screen
- Viewport specifications

## 6. Step-by-Step Workflow
1. **Identify Breakpoint Thresholds**: Standardize on Mobile (<600dp), Tablet (600-1024dp), and Desktop (>1024dp).
2. **Select Navigation Primitive**:
   - Mobile: `NavigationBar` (bottom).
   - Tablet: `NavigationRail` (side rail with icons).
   - Desktop: Full `NavigationDrawer` or persistent sidebar.
3. **Implement Adaptive Layout Scaffold**: Use `LayoutBuilder` to toggle between bottom navigation and sidebar based on available width.
4. **Build Master-Detail Views**: On desktop/tablet, display list on left pane and active details on right pane; on mobile, push details via Navigator.
5. **Constrain Content**: Wrap wide body content in `ConstrainedBox(constraints: BoxConstraints(maxWidth: 1200))` to prevent excessive horizontal stretching.

## 7. Engineering Rules
- **Prefer `LayoutBuilder` over `MediaQuery.sizeOf`**: Components should adapt to their parent container's allocated width, not the full device window.
- **Orientation Awareness**: Account for mobile landscape orientation (where height is constrained).

## 8. Code Examples
```dart
class AdaptiveScaffold extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;

  const AdaptiveScaffold({
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          // Desktop: Expanded Sidebar
          return Scaffold(
            body: Row(
              children: [
                NavigationDrawer(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onDestinationSelected,
                  children: [
                    for (final d in destinations)
                      NavigationDrawerDestination(icon: d.icon, label: Text(d.label)),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: body),
              ],
            ),
          );
        } else if (constraints.maxWidth >= 600) {
          // Tablet: NavigationRail
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onDestinationSelected,
                  destinations: [
                    for (final d in destinations)
                      NavigationRailDestination(icon: d.icon, label: Text(d.label)),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: body),
              ],
            ),
          );
        } else {
          // Mobile: Bottom Navigation Bar
          return Scaffold(
            body: body,
            bottomNavigationBar: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              destinations: destinations,
            ),
          );
        }
      },
    );
  }
}
```

## 9. Common Mistakes
- Hardcoding fixed pixel widths on cards, causing horizontal overflow on small mobile screens.
- Allowing single-line text fields to span 2560px on ultra-wide desktop monitors.

## 10. Testing and Verification
- Test widget rendering across standard test viewports: 375x667 (mobile), 768x1024 (tablet), 1920x1080 (desktop) using `tester.view.physicalSize`.
- Ensure zero `RenderFlex` overflow errors.

## 11. Completion Criteria
- Layout adapts cleanly across Mobile, Tablet, and Desktop breakpoints.
- Navigation shifts appropriately between Bottom Bar, Rail, and Drawer.

## 12. Related Skills
- `ui-implementation`
- `desktop-development`
- `windows-development`
