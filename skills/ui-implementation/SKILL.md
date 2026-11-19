---
name: ui-implementation
description: Production-quality Flutter UI widget composition, design system consistency, loading states, empty states, and micro-interactions.
---

# ui-implementation

## 1. Skill Name
`ui-implementation`

## 2. Purpose
Guides agents in crafting polished, resilient, production-ready Flutter widgets that strictly adhere to the global design system. Ensures proper widget composition, layout constraint handling, responsive adaptability, loading skeletons, honest empty states, and micro-interactions while preventing visual fragmentation and generic AI-generated aesthetic flaws.

## 3. When to Use
- When building new UI screens, components, cards, forms, or dialogs.
- When turning design mockups (Figma, screenshots, or PRDs) into Flutter code.
- When upgrading substandard UI screens to production quality.
- When harmonizing fragmented screens to match the application's global design language.

## 4. When Not to Use
- When implementing pure backend or headless domain logic without visual components.

## 5. Required Project Context
- `lib/core/theme/` (Theme tokens, colors, typography, spacing, radii)
- `lib/core/presentation/widgets/` (Reusable component library)
- `docs/DESIGN.md` and `docs/DESIGN_SYSTEM_STANDARDS.md`
- Target screen requirements or mockups

## 6. Step-by-Step Workflow
1. **Inspect Existing Design System First**: Check `docs/DESIGN.md` and `lib/core/presentation/widgets/` to reuse existing buttons, text fields, cards, and empty states.
2. **Deconstruct the UI**: Break the screen into atomic, reusable widgets (Header, FilterBar, ItemList, EmptyView).
3. **Handle the 4 Mandatory States**:
   - Loading: Render skeleton placeholder (using `skeletonizer` or custom shimmer).
   - Success: Render primary data list or details.
   - Empty: Render friendly illustration/icon and call-to-action button when real data is empty.
   - Error: Render error message with an actionable **Retry** button.
4. **Respect Constraints**: Wrap unbounded flex children in `Expanded` or `Flexible` to prevent `RenderFlex` overflows.
5. **Apply Theme Tokens**: Bind all colors, paddings, and text styles to `Theme.of(context)` or `ThemeExtension`.
6. **Add Micro-Interactions**: Implement ripple feedback (`InkWell`), hover states for desktop (`MouseRegion`), and smooth hero or fade animations.
7. **Verify Responsive Layout**: Ensure UI looks balanced on mobile (375px), tablet (768px), and desktop (1200px+).
8. **Run 13-Point Design Checklist**: Verify cross-screen cohesion before marking the UI complete (`docs/DESIGN_SYSTEM_STANDARDS.md`).

## 7. Engineering Rules
- **One Coherent Design Language**: Every screen must look and feel like part of the same application. Never invent independent styling on isolated screens (`docs/DESIGN_SYSTEM_STANDARDS.md`).
- **Zero Dummy Data Invariant**: Never hardcode sample records, fake users, or static item lists in widget files. UI components must subscribe reactively to real application state and render an honest empty state when no records exist (`docs/REAL_DATA_INTEGRITY.md`).
- **No Hardcoded Hex Colors**: Hardcoding `Color(0xFF...)` inside widget build methods is strictly forbidden. All colors must resolve from `Theme.of(context).colorScheme` or `ThemeExtension`.
- **Modular Spacing Only**: All margins, paddings, and gaps must consume `AppSpacing` tokens (4, 8, 12, 16, 24, 32, 48dp).
- **Component Reuse Priority**: Always reuse shared components from `lib/core/presentation/widgets/` before authoring custom buttons, cards, or dialogs.
- **Form Keyboard Safety**: Every form on mobile must be scrollable (`SingleChildScrollView`) to prevent keyboard occlusion.
- **Tap Target Compliance**: Interactive elements must meet minimum tap bounds (48x48dp mobile, 32x32dp desktop).

## 8. Code Examples
```dart
class ProductListScreen extends StatelessWidget {
  final AsyncValue<List<Product>> productsState;
  final VoidCallback onRetry;

  const ProductListScreen({
    required this.productsState,
    required this.onRetry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: switch (productsState) {
        AsyncLoading() => const ProductSkeletonList(),
        AsyncError(:final error) => ErrorStateView(
            message: error.toString(),
            onRetry: onRetry,
          ),
        AsyncData(:final value) when value.isEmpty => const EmptyStateView(
            message: 'No products available at this time.',
            icon: Icons.inventory_2_outlined,
          ),
        AsyncData(:final value) => ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: value.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, i) => ProductCard(product: value[i]),
          ),
      },
    );
  }
}
```

## 9. Common Mistakes
- Leaving out the empty state, causing blank white screens when collections have zero items.
- Using `Container(color: Colors.blue)` instead of `Theme.of(context).colorScheme.primary`.
- Forgetting `overflow: TextOverflow.ellipsis` on variable-length text strings inside `Row`.
- Designing screens with arbitrary custom button styles that clash with the rest of the app.

## 10. Testing and Verification
- Write widget tests pumping the widget under all 4 states (Loading, Success, Empty, Error).
- Verify widget passes `flutter test`.
- Verify the 13-point design checklist in `docs/DESIGN_SYSTEM_STANDARDS.md`.

## 11. Completion Criteria
- UI renders cleanly across all 4 operational states.
- Zero layout overflow warnings on small or large viewports.
- All styles consume the active theme and design tokens.
- 13-point design checklist fully verified.

## 12. Related Skills
- `coding-standards` — 8-step AI workflow; Widget Standards (Section 3) and Code Quality (Section 10) of `docs/FLUTTER_CODING_STANDARDS.md`
- `real-data-integrity`
- `design-system`
- `responsive-design`
- `accessibility`
- `golden-testing`
- `testing`
