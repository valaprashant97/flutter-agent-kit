# Flutter Widget Keys & Element Identity Rules

These rules govern when and how to use Flutter `Key` objects to maintain element state across rebuilds and reorderings.

---

## 1. When Keys Are Required
Flutter uses the widget's `runtimeType` and `key` to match widgets to underlying `Element` instances. Keys are **not** needed on static widgets, but are **mandatory** when:
1. **Items in a Dynamic or Reorderable Collection Have State**:
   - Swapping, inserting, or deleting items in a `ListView`, `ReorderableListView`, or `AnimatedList`.
   - Without a unique key, Flutter matches the state object to the index rather than the item, resulting in state persisting across swapped items (e.g., checkboxes remaining checked on wrong rows).
2. **Preserving State Across Hierarchy Changes**:
   - Preserving state when reparenting widgets (e.g., swapping layout between two panes using `GlobalKey`).

---

## 2. Which Key Type to Use

| Key Type | When to Use | Example |
| :--- | :--- | :--- |
| **`ValueKey<T>`** | When each item possesses a unique, stable primitive ID (string, int, UUID). | `ValueKey(user.id)` |
| **`ObjectKey`** | When the entire object's identity defines the key. | `ObjectKey(transaction)` |
| **`UniqueKey`** | When you want Flutter to discard and completely recreate the state object on rebuild. | `UniqueKey()` |
| **`GlobalKey`** | For accessing widget state from outside (e.g., `FormState`), reparenting widgets, or getting render box coordinates. Use sparingly. | `final formKey = GlobalKey<FormState>();` |

---

## 3. Key Anti-Patterns
- **Never use list indices as Keys (`ValueKey(index)`)**: This completely defeats the purpose of keys. If item 0 is deleted, the old item 1 becomes item 0 and improperly inherits item 0's state.
- **Never instantiate `UniqueKey()` inside `build()`**:
  ```dart
  // WRONG - Recreates key on EVERY build pass, causing complete state loss
  @override
  Widget build(BuildContext context) {
    return MyCustomStatefulWidget(key: UniqueKey());
  }
  ```
- **Avoid Overusing `GlobalKey`**: GlobalKeys are expensive because they require global map registration and bypass local subtree reconciliation. Prefer callbacks or state management.
