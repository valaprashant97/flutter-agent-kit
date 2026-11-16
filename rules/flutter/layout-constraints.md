# Flutter Layout Constraints & Overflow Rules

These rules establish the foundational Flutter layout law and techniques to prevent `RenderFlex` overflows and unbounded height/width exceptions.

---

## 1. The Core Law of Flutter Layout

> **Constraints go down. Sizes go up. Parent sets position.**

1. A parent widget passes **BoxConstraints** (min/max width and height) down to its child.
2. The child determines its own **Size** within those constraints.
3. The parent positions the child within the parent's coordinate space.

---

## 2. Preventing Unbounded Height/Width Errors

### The Problem
When a scrollable widget (e.g., `ListView`, `GridView`) or an unconstrained widget is placed directly inside a flex widget (`Column`, `Row`), Flutter throws:
`"Vertical viewport was given unbounded height"` or `"RenderFlex children have non-zero flex but incoming height constraints are unbounded."`

### Solutions
- **Wrap Scrollables in `Expanded` or `Flexible`**:
  ```dart
  Column(
    children: [
      const HeaderWidget(),
      Expanded(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => ItemTile(item: items[index]),
        ),
      ),
    ],
  )
  ```
- **Use `shrinkWrap: true` and `NeverScrollableScrollPhysics`** only for short, bounded lists nested inside larger scroll views:
  ```dart
  ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: items.length,
    itemBuilder: (context, index) => ItemTile(item: items[index]),
  )
  ```
  *Note*: For large lists, avoid `shrinkWrap: true` as it forces all items to be built upfront, defeating lazy-loading performance.

---

## 3. Preventing Yellow-and-Black `RenderFlex` Overflows
- **In Rows**: When text or widgets exceed available width, wrap the expanding widget in `Expanded` or `Flexible`, and set `overflow: TextOverflow.ellipsis` on `Text` widgets:
  ```dart
  Row(
    children: [
      const Icon(Icons.person),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          user.longDisplayName,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    ],
  )
  ```
- **In Forms on Mobile**: Keyboards reduce available screen height. Always wrap forms in a `SingleChildScrollView`:
  ```dart
  Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: LoginForm(),
      ),
    ),
  )
  ```
