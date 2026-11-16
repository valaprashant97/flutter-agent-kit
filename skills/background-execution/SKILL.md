---
name: background-execution
description: Dart isolates, heavy computational offloading, background sync, and OS task scheduling.
---

# background-execution

## 1. Skill Name
`background-execution`

## 2. Purpose
Provides production standards for executing background tasks in Flutter: offloading CPU-intensive processing to worker Dart isolates (`Isolate.run()`), managing persistent isolates, configuring mobile background sync (`workmanager`), and scheduling OS background tasks on Windows.

## 3. When to Use
- When parsing massive JSON datasets (>1MB), compressing high-res images, or processing files.
- When calculating heavy mathematical, cryptographic, or machine learning operations without dropping UI frames.
- When running periodic background data synchronization or scheduled tasks while the app is backgrounded.

## 4. When Not to Use
- For simple network I/O or database reads that are already asynchronous (I/O does not block the Dart event loop).

## 5. Required Project Context
- `pubspec.yaml`
- Computational task requirements and data payloads

## 6. Step-by-Step Workflow
1. **Identify Bottleneck**: Measure frame rendering times. If a task takes >10ms on the main isolate, offload it.
2. **Implement Worker Isolate**: Use `Isolate.run<T>()` for one-off calculations.
3. **Verify Data Serialization**: Ensure all data passed to and returned from the worker isolate is sendable (primitives, sendable objects, or serializable maps/lists).
4. **Implement Mobile Background Sync**: If periodic background sync is required on Android/iOS, configure `workmanager` with top-level callback dispatcher.
5. **Implement Windows Task Scheduling**: If background execution is required on Windows after the app exits, register an OS-level task using `schtasks.exe` or a native Win32 service.

## 7. Engineering Rules
- **No Global State in Isolates**: Worker isolates run in their own memory space with separate heaps. They do not share global variables, static fields, or open database handles with the main isolate.
- **Top-Level Entry Points**: Background callback dispatchers (`workmanager` or background isolates) must be declared as `@pragma('vm:entry-point')` top-level or static functions to prevent tree-shaking by the AOT compiler.
- **Process Termination Truth**: Do not claim mobile workmanager or background isolates execute on desktop when the desktop process terminates. Always use native Windows Task Scheduler on Windows.

## 8. Code Examples
```dart
// 1. Offloading Heavy Computation with Isolate.run()
Future<List<TransactionModel>> processRawTransactions(String jsonPayload) async {
  return await Isolate.run(() {
    final rawList = jsonDecode(jsonPayload) as List<dynamic>;
    return rawList
        .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
        .where((t) => t.isValid)
        .toList();
  });
}

// 2. Windows Task Scheduler Registration (Windows Desktop CLI)
// Registers a task to run an executable periodically even when app is closed:
// schtasks /create /tn "EnterpriseAppSync" /tr "C:\Program Files\App\sync_worker.exe" /sc HOURLY /ru SYSTEM
```

## 9. Common Mistakes
- Attempting to pass open `Socket`, `File`, or `BuildContext` references into a worker isolate, causing a runtime `ArgumentError`.
- Forgetting `@pragma('vm:entry-point')`, leading to release-mode crashes where background handlers were stripped by code shrinking.
- Assuming an application isolate stays alive indefinitely in the background on mobile (OS kills background processes under memory pressure).

## 10. Testing and Verification
- Verify that `Isolate.run()` returns correct output and does not drop frames on the main thread during execution.
- Run `flutter analyze` and `flutter test`.

## 11. Completion Criteria
- Heavy processing runs off the main UI isolate without jank.
- Background tasks handle errors gracefully.
- Release-mode entry points are protected from tree-shaking.

## 12. Related Skills
- `performance`
- `windows-development`
- `notifications`
