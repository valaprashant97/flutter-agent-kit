# BLoC & Cubit State Management Rules

These rules govern the implementation of `flutter_bloc` in production Flutter applications.

---

## 1. When to Use BLoC vs. Cubit
- **Use Cubit**: For simple to medium state management where state transitions are triggered directly by synchronous or asynchronous methods (e.g., `cubit.fetchUser()`, `cubit.toggleTheme()`). Cubit reduces boilerplate by eliminating separate Event classes.
- **Use BLoC**: When event buffering, debouncing (e.g., search autocomplete), throttling, or advanced reactive stream transformations (`rxdart`) are required.

---

## 2. Invariants & Rules for BLoC / Cubit

### Immutability of State
All States emitted by a BLoC or Cubit **must be immutable**. Extend `Equatable` or use `@freezed` to ensure structural equality:
```dart
import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthAuthenticated extends AuthState {
  final User user;
  const AuthAuthenticated(this.user);
  @override
  List<Object?> get props => [user];
}
final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
  @override
  List<Object?> get props => [message];
}
```

### UI Consumption Patterns: `BlocBuilder` vs `BlocListener` vs `BlocConsumer`
- **`BlocBuilder`**: Purely for building UI based on state. Must not trigger navigation, dialogs, or snackbars.
- **`BlocListener`**: For side-effects that execute once per state change (navigating to a new route, showing a SnackBar).
- **`BlocConsumer`**: Combines `builder` and `listener` in one widget when both UI rebuilding and side-effects are needed.
- **`BlocSelector`**: Use `BlocSelector` when a widget only cares about a single field of a large state object to prevent unnecessary rebuilds:
  ```dart
  BlocSelector<CartBloc, CartState, int>(
    selector: (state) => state.itemCount,
    builder: (context, count) => Badge(label: Text('$count')),
  )
  ```

### Scope and Cleanup
- Always provide BLoCs using `BlocProvider(create: (context) => ...)`.
- Let `BlocProvider` manage closing the BLoC automatically when the widget tree pops.
- If sharing an existing BLoC across routes, use `BlocProvider.value(value: existingBloc)`.
