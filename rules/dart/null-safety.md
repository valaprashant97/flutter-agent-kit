# Dart Null Safety Rules

These rules govern sound null safety practices in modern Dart 3.x applications.

---

## 1. Principles of Sound Null Safety
1. **Types Are Non-Nullable by Default**: Only append `?` when a variable, parameter, or return value genuinely represents the absence of data.
2. **Eliminate Unnecessary Nullability**: Do not declare variables as nullable simply because they are initialized asynchronously or lazily. Use `late` with extreme caution, or prefer immutable constructor injection.
3. **Ban Force-Unwrap (`!`) Operator in Application Code**:
   - `!` is a runtime assertion that throws an unrecoverable `TypeError` if null.
   - Use null-aware operators:
     ```dart
     // BAD
     final name = user!.profile!.name!;

     // GOOD
     final name = user?.profile?.name ?? 'Anonymous';
     ```
   - Use pattern matching with null checks:
     ```dart
     if (user case User(:final profile?)) {
       // profile is guaranteed non-null here
     }
     ```

---

## 2. Safe Null Coalescing Patterns
- **Default Fallbacks**: Use `??` to provide safe defaults:
  ```dart
  final timeout = configuredTimeout ?? const Duration(seconds: 30);
  ```
- **Null-Aware Assignment**: Use `??=` to initialize lazily without re-assigning:
  ```dart
  _cachedData ??= await fetchRemoteData();
  ```
- **Null-Aware Cascades**: Use `?..` when operating on potentially null targets:
  ```dart
  dialogBuilder?..setTitle('Warning')..show();
  ```

---

## 3. When `late` is Permitted
- Permitted **only** in `StatefulWidget` `initState()` for initialization that requires `BuildContext` or `this` (e.g., `late final AnimationController _controller;`).
- Always mark `late` fields as `final` whenever they are assigned once and never mutated:
  ```dart
  late final FocusNode _focusNode;
  ```
- If a `late` field might be accessed before initialization, wrap access with a guard or use a nullable field instead.
