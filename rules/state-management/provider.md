# Provider & ChangeNotifier Rules

These rules govern the use of `package:provider` and `ChangeNotifier`.

---

## 1. Principles of ChangeNotifier
`ChangeNotifier` is Flutter's built-in observable class. When combined with `provider`, it provides simple, lightweight state management.

```dart
import 'package:flutter/foundation.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return; // Prevent duplicate notifications
    _themeMode = mode;
    notifyListeners();
  }
}
```

---

## 2. Consumption Invariants

### `context.watch<T>()` vs `context.read<T>()` vs `context.select<T, R>()`
- **`context.watch<T>()`**: Use in `build()` to rebuild when any property of `T` changes.
- **`context.read<T>()`**: Use strictly in click handlers / callbacks to invoke methods. Never use in `build()`.
- **`context.select<T, R>()`**: The golden standard for preventing rebuilds:
  ```dart
  // Only rebuilds when cartItemCount changes, ignoring other cart state updates
  final count = context.select<CartProvider, int>((cart) => cart.itemCount);
  ```

### `Consumer` Widget
Use `Consumer` to restrict rebuilds to the smallest possible sub-tree:
```dart
Scaffold(
  appBar: AppBar(title: const Text('Store')), // Does NOT rebuild
  body: Consumer<CartProvider>(
    builder: (context, cart, child) {
      return Text('Total: ${cart.totalPrice}');
    },
  ),
);
```

---

## 3. Disposing ChangeNotifier
- Always let `ChangeNotifierProvider(create: (_) => ...)` manage disposal automatically.
- Never call `notifyListeners()` after a `ChangeNotifier` has been disposed. Check `hasListeners` or guard with a boolean if async operations complete after disposal.
