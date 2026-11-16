# Riverpod State Management Rules

These rules govern the implementation of `flutter_riverpod` (v2.0+) using modern code-generation or `Notifier` syntax.

---

## 1. Modern Riverpod Notifier Syntax
In Riverpod 2.x+, prefer `AsyncNotifier` (for asynchronous state) and `Notifier` (for synchronous state) over legacy `StateProvider` and `StateNotifierProvider`.

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListNotifier extends AsyncNotifier<List<Task>> {
  @override
  Future<List<Task>> build() async {
    // Initial fetch happens in build()
    return ref.watch(taskRepositoryProvider).getTasks();
  }

  Future<void> addTask(String title) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(taskRepositoryProvider);
      await repository.createTask(title);
      return repository.getTasks();
    });
  }
}

final taskListProvider = AsyncNotifierProvider<TaskListNotifier, List<Task>>(
  TaskListNotifier.new,
);
```

---

## 2. Invariants for Riverpod Consumption

### `ref.watch` vs `ref.read`
- **In Widget `build()`**: Use `ref.watch(provider)` to subscribe to changes and rebuild when state changes.
- **In Event Callbacks (`onPressed`)**: Use `ref.read(provider.notifier)` to call methods without creating an unnecessary build subscription.
- **Never call `ref.read` inside `build()`**: Calling `ref.read` in build causes silent stale-state bugs because the widget will not update when the provider emits new values.

### Using `.select` to Prevent Rebuilds
When a widget depends only on a specific property:
```dart
final unreadCount = ref.watch(
  notificationsProvider.select((state) => state.unreadCount),
);
```

### AutoDispose
Always append `.autoDispose` to providers that hold screen-specific state or temporary search queries, ensuring memory is reclaimed when the screen unmounts:
```dart
final userProfileProvider = FutureProvider.autoDispose.family<User, String>((ref, userId) async {
  return ref.watch(userRepositoryProvider).getUser(userId);
});
```
