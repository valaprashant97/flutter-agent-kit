# Flutter BuildContext & Element Tree Rules

These rules govern safe and efficient use of `BuildContext` in Flutter applications.

---

## 1. What is BuildContext?
`BuildContext` is a handle to the location of a widget within the **Element Tree**. It allows a widget to look up ancestors (such as `Navigator`, `Theme`, `ScaffoldMessenger`, and `Provider`).

---

## 2. The Golden Rules of BuildContext

### Rule 1: Never Use BuildContext Across Async Gaps Without `mounted` Check
When awaiting a `Future`, the widget may be popped or disposed before the future completes. Referencing `context` on an unmounted element throws an exception or causes memory leaks.

```dart
// FORBIDDEN
Future<void> _handleDelete() async {
  await repository.deleteItem(id);
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Item deleted')),
  );
}

// MANDATORY
Future<void> _handleDelete() async {
  await repository.deleteItem(id);
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Item deleted')),
  );
}
```

### Rule 2: Understand the Look-Up Direction
`context` only searches **upwards** toward ancestors. It can never look sideways or downwards.
- If you call `Scaffold.of(context)` inside the widget that returns the `Scaffold`, it will fail because the `context` is outside the `Scaffold`.
- Solution: Wrap the child in a `Builder` widget:
  ```dart
  Scaffold(
    body: Builder(
      builder: (scaffoldContext) => ElevatedButton(
        onPressed: () => Scaffold.of(scaffoldContext).openDrawer(),
        child: const Text('Open Drawer'),
      ),
    ),
  );
  ```

### Rule 3: Avoid Storing BuildContext in Long-Lived Fields or Singletons
- Never pass `BuildContext` into background services, singleton repositories, or long-lived BLOCs.
- Pass domain primitives (strings, IDs, numbers) or use `GlobalKey<NavigatorState>` / navigation services when decoupled navigation is necessary.
