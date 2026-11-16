# ValueNotifier & ValueListenableBuilder Rules

These rules govern the use of Flutter's zero-dependency, built-in reactive primitives: `ValueNotifier<T>` and `ValueListenableBuilder<T>`.

---

## 1. When to Use ValueNotifier
`ValueNotifier<T>` is the simplest, most performant way to manage a single observable value without adding third-party state management dependencies.

### Ideal Use Cases:
- Toggle switches (e.g., password visibility in text fields)
- Simple counters or badge values
- Search query debouncing
- Modal bottom sheet dynamic heights

---

## 2. Implementation Pattern

```dart
class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordInputField({required this.controller, super.key});

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _obscurePassword.dispose(); // ALWAYS dispose ValueNotifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscurePassword,
      builder: (context, isObscured, child) {
        return TextField(
          controller: widget.controller,
          obscureText: isObscured,
          decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
              icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
              onPressed: () => _obscurePassword.value = !_obscurePassword.value,
            ),
          ),
        );
      },
    );
  }
}
```

---

## 3. Critical ValueNotifier Invariants
1. **Value Equality Check**: `ValueNotifier` only notifies listeners if `newValue != oldValue`. If mutating an existing object or list in place without changing the reference, listeners will **not** be triggered. Assign a new copy or use `notifyListeners()`:
   ```dart
   // WRONG - Will not notify listeners
   itemsNotifier.value.add(newItem);

   // CORRECT - Assigns new list reference
   itemsNotifier.value = [...itemsNotifier.value, newItem];
   ```
2. **Mandatory Disposal**: If initialized inside a `StatefulWidget`, the `ValueNotifier` must be explicitly disposed in `dispose()`.
