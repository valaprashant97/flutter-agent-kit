---
name: platform-channels
description: Implement type-safe platform communication between Dart and native host platforms (Android, iOS, Windows C++, macOS, Linux) using Pigeon, MethodChannel, and EventChannel.
---

# platform-channels

## 1. Skill Name
`platform-channels`

## 2. Purpose
Guides agents in establishing robust, bidirectional communication between Dart and native platform code. Prioritizes Pigeon type-safe code generation, enforces strict exception handling for `PlatformException` and `MissingPluginException`, manages `EventChannel` stream lifecycles, and ensures proper threading in native host runners (including Windows C++).

## 3. When to Use
- When invoking native platform APIs not covered by community pub.dev plugins (e.g. specialized hardware, custom Win32 APIs, biometric sensors).
- When streaming sensor data, power events, or peripheral states continuously from native code into Flutter.
- When replacing fragile, untyped `MethodChannel` code with compile-time verified Pigeon interfaces.

## 4. When Not to Use
- When an actively maintained, official plugin exists (e.g. `path_provider`, `camera`, `url_launcher`, `shared_preferences`).
- When simple C/C++ libraries can be called synchronously and directly using Dart FFI (`dart:ffi`).

## 5. Required Project Context
- Target platforms (Windows C++, Android Kotlin, iOS Swift, macOS, Linux).
- Data models and method contracts to exchange across the host boundary.

## 6. Step-by-Step Workflow
1. **Choose Implementation Approach**:
   - For structured contracts: Use **Pigeon** (`dev_dependencies: pigeon`).
   - For simple legacy bridges: Use `MethodChannel` / `EventChannel`.
2. **Define Interface Contract**:
   - In Pigeon: Define abstract `@HostApi()` and `@FlutterApi()` classes in `pigeons/`.
   - Run `dart run pigeon --input pigeons/messages.dart`.
3. **Implement Native Handlers**:
   - Windows: Implement C++ handler in `windows/runner/flutter_window.cpp`.
   - Android: Implement Kotlin handler implementing the generated API interface in `MainActivity.kt`.
   - iOS: Implement Swift handler conforming to the generated protocol in `AppDelegate.swift`.
4. **Wrap Dart Client**: Encapsulate channel calls inside a clean repository or service interface handling `PlatformException`.
5. **Add Mocking for Unit Tests**: Register test mock handlers via `TestDefaultBinaryMessengerBinding` in Dart tests.

## 7. Engineering Rules
- **Type Safety Priority**: Always prefer Pigeon over raw string-based `MethodChannel` calls for new integrations.
- **Exception Boundary Invariant**: Every `invokeMethod` call must catch `PlatformException` and `MissingPluginException`, mapping them to a domain `Failure`.
- **Native Threading Invariant**: Platform channel results must be returned on the main thread; long-running native computations must be offloaded to worker threads.
- **Stream Cleanup**: Every `EventChannel` broadcast stream listener must be cancelled upon controller or widget disposal.

## 8. Code Examples
```dart
// Unit Testing a MethodChannel Client
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('com.example.app/device');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'getBatteryLevel') {
        return 85;
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('fetches battery level correctly', () async {
    final service = DeviceService();
    final level = await service.getBatteryLevel();
    expect(level, 85);
  });
}
```

## 9. Common Mistakes
- Typos in channel names or method strings causing runtime crashes.
- Blocking the native UI thread with synchronous file I/O or network requests.
- Forgetting to register test mock handlers, causing unit tests to fail with `MissingPluginException`.

## 10. Testing and Verification
- Unit test Dart wrappers with `setMockMethodCallHandler`.
- Run integration tests on real devices or emulators using `integration_test` to verify end-to-end native platform response.

## 11. Completion Criteria
- Communication operates with zero unhandled `PlatformException` crashes.
- Method contracts are strictly typed.
- Streams clean up without native memory or listener leaks.

## 12. Related Skills
- `windows-development`
- `desktop-development`
- `error-handling`
- `testing`
