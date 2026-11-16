# Responsive & Adaptive Design Rules

These rules govern multi-platform layouts supporting Mobile, Tablet, and Desktop screen widths in Flutter.

---

## 1. Standard Breakpoints

Flutter applications should align with the following standard viewport breakpoints:

| Form Factor | Screen Width (`dp`) | Layout Strategy |
| :--- | :--- | :--- |
| **Mobile (Compact)** | `< 600 dp` | Single-column, bottom navigation bar, modal bottom sheets |
| **Tablet (Medium)** | `600 dp - 1024 dp` | Two-column grid, navigation rail, centered content max-width |
| **Desktop (Expanded)** | `> 1024 dp` | Persistent navigation drawer / sidebar, multi-pane master-detail |

---

## 2. Layout Tools: `LayoutBuilder` vs. `MediaQuery`

### Rule: Prefer `LayoutBuilder` for Component Adaptability
- `MediaQuery.sizeOf(context).width` returns the **entire window / screen width**.
- `LayoutBuilder` provides the **BoxConstraints of the parent container**.
- When building reusable components that could appear in a sidebar or a split-pane modal, use `LayoutBuilder` so the widget adapts to its allocated space rather than assuming it spans the full window width.

```dart
class AdaptiveCardList extends StatelessWidget {
  final List<Item> items;
  const AdaptiveCardList({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: items.length,
            itemBuilder: (context, i) => ItemCard(item: items[i]),
          );
        } else if (constraints.maxWidth > 600) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: items.length,
            itemBuilder: (context, i) => ItemCard(item: items[i]),
          );
        } else {
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) => ItemCard(item: items[i]),
          );
        }
      },
    );
  }
}
```

---

## 3. Desktop Max-Width Centering
On ultra-wide desktop monitors (1440p, 4K), forms and article text must not stretch edge-to-edge. Constrain content with `ConstrainedBox`:
```dart
Center(
  child: ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 800),
    child: child,
  ),
)
```
