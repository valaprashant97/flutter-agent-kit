# Const Constructors & Element Caching Rules

These rules govern the use of `const` constructors to eliminate unnecessary widget allocations and minimize garbage collection pauses.

---

## 1. Why `const` Matters in Flutter

When a widget is instantiated with `const`:
1. **Canonical Instance**: Dart creates a single, immutable instance of the widget in memory at compile time and reuses that identical instance across all rebuild passes.
2. **Short-Circuiting the Element Tree**: During a parent rebuild pass, Flutter's element reconciliation checks:
   ```dart
   if (identical(oldWidget, newWidget)) {
     // SKIP: Do not rebuild this entire subtree!
     return;
   }
   ```
   If the widget is `const`, `identical()` evaluates to `true`, and Flutter skips rebuilding that subtree entirely.

---

## 2. Invariants for `const` Usage

### Rule 1: Always Add `const` to Widgets Without Dynamic Inputs
```dart
// BAD - Allocates new objects on every rebuild
return Column(
  children: [
    SizedBox(height: 16),
    Icon(Icons.star),
    Text('Featured Items'),
    ProductList(items: products),
  ],
);

// GOOD - Zero allocations during rebuilds
return Column(
  children: [
    const SizedBox(height: 16),
    const Icon(Icons.star),
    const Text('Featured Items'),
    ProductList(items: products),
  ],
);
```

### Rule 2: Declare `const` Constructors on Custom Widgets
Whenever all fields in a custom widget are `final`, declare a `const` constructor:
```dart
class EmptyStateView extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyStateView({
    required this.message,
    this.icon = Icons.inbox,
    super.key,
  });

  @override
  Widget build(BuildContext context) { ... }
}
```

### Rule 3: Enforce Linter Rules
Ensure `prefer_const_constructors`, `prefer_const_declarations`, and `prefer_const_literals_to_create_immutables` are active in `analysis_options.yaml`. Never bypass these warnings with ignores.
