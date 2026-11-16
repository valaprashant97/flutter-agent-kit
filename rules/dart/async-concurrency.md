# Dart Async & Concurrency Rules

These rules govern asynchronous programming, Futures, Streams, and Isolates in Dart.

---

## 1. Asynchronous Execution Principles
1. **Never Block the Event Loop**: Heavy CPU-bound computation (large JSON parsing, image manipulation, encryption) will freeze the UI thread and cause jank. Offload to an `Isolate` using `Isolate.run()`.
2. **Proper Error Handling with `try-catch`**: Never leave a `Future` unhandled or fire-and-forget without a catch block.
   ```dart
   // BAD - Unhandled future exception crashes app
   void loadData() {
     repository.fetchItems();
   }

   // GOOD
   Future<void> loadData() async {
     try {
       final items = await repository.fetchItems();
       _handleSuccess(items);
     } catch (e, st) {
       _handleError(e, st);
     }
   }
   ```
3. **Avoid `async` on Functions That Do Not `await`**: If a function returns a cached or immediate value, return `Future.value()` or use a synchronous return type. Adding `async` unnecessarily wraps execution in microtask queues.

---

## 2. Stream Management Rules
1. **Always Cancel Subscriptions**: Keep references to `StreamSubscription` instances and cancel them in `dispose()`:
   ```dart
   StreamSubscription<User>? _authSub;

   @override
   void initState() {
     super.initState();
     _authSub = authService.userStream.listen(_onUserChanged);
   }

   @override
   void dispose() {
     _authSub?.cancel();
     super.dispose();
   }
   ```
2. **Close StreamControllers**: Every `StreamController` owned by a class must be closed when the class is disposed. Verify `isClosed` before adding events.
3. **Use `StreamBuilder` with `initialData`**: When rendering streams in Flutter UI, always provide `initialData` or handle the `ConnectionState.waiting` state explicitly.

---

## 3. Worker Isolates with `Isolate.run()`
For CPU-intensive processing, use `Isolate.run()` (Dart 2.19+ / Dart 3):
```dart
Future<List<Item>> parseHugeJson(String rawJson) async {
  return await Isolate.run(() {
    final decoded = jsonDecode(rawJson) as List<dynamic>;
    return decoded.map((e) => Item.fromJson(e as Map<String, dynamic>)).toList();
  });
}
```
*Note*: Objects passed into `Isolate.run()` must be sendable (no open file descriptors or complex closures referencing outer state).
