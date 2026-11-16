---
name: state-management
description: State management implementation, selection, and optimization across BLoC, Riverpod, Provider, and ValueNotifier.
---

# state-management

## 1. Skill Name
`state-management`

## 2. Purpose
Guides agents in selecting, structuring, and optimizing application state management. Enforces immutability, selective rebuilds, testable controller separation, and respects existing project conventions across BLoC, Riverpod, Provider, and ValueNotifier.

## 3. When to Use
- When managing server or client state for a feature.
- When refactoring stateful widgets that contain excessive business logic into dedicated state controllers.
- When optimizing UI performance by eliminating unnecessary widget rebuilds.

## 4. When Not to Use
- For simple, transient UI state (e.g., text controller focus, animation ticks) where a local `StatefulWidget` or `ValueNotifier` is sufficient.

## 5. Required Project Context
- `pubspec.yaml` (identify existing state management library)
- Feature requirements and state transition diagrams

## 6. Step-by-Step Workflow
1. **Audit Existing Library**: Check `pubspec.yaml` to follow the project's existing state library (do NOT introduce a new state management package if one is already present).
2. **Define State Model**: Create immutable state classes using `sealed class` or `@freezed`.
3. **Implement Controller / Notifier**:
   - BLoC / Cubit: Implement event handlers or cubit methods.
   - Riverpod: Implement `AsyncNotifier` or `Notifier`.
   - Provider: Implement `ChangeNotifier`.
4. **Wire Dependency Injection**: Register the state provider in `get_it` or as a scoped widget provider.
5. **Optimize UI Subscriptions**: Use `BlocSelector`, `ref.watch(provider.select(...))`, or `context.select(...)` to rebuild only the widgets that depend on changing fields.

## 7. Engineering Rules
- **Immutability Invariant**: State objects must be completely immutable. Never mutate lists or object properties in place.
- **Pure Build Functions**: Never trigger side-effects (navigation, dialogs, network calls) inside widget `build()` methods. Use listeners (`BlocListener`, `ref.listen`).
- **No BuildContext in Controllers**: Never pass `BuildContext` into BLoCs, Notifiers, or Cubits.

## 8. Code Examples
```dart
// BLoC Selector to prevent rebuilds
BlocSelector<CartBloc, CartState, int>(
  selector: (state) => state.items.length,
  builder: (context, itemCount) {
    return Text('Items in cart: $itemCount');
  },
);

// Riverpod Select Optimization
final userName = ref.watch(userProfileProvider.select((state) => state.name));
```

## 9. Common Mistakes
- Calling `ref.read` in widget `build()` methods, causing UI to miss state updates.
- Rebuilding the entire screen when only a single text counter changed.
- Forgetting to call `notifyListeners()` or mutating a list in place in `ChangeNotifier`.

## 10. Testing and Verification
- Write unit tests verifying state transitions for each event or method call using `bloc_test` or native test runners.
- Verify 100% branch coverage on state transitions.

## 11. Completion Criteria
- State logic is decoupled from widget classes.
- UI rebuilds only on relevant property changes.
- All state transitions are unit tested.

## 12. Related Skills
- `flutter-architecture`
- `ui-implementation`
- `performance`
- `testing`
