# Flutter Platform Channels & Native Interop Rules

This guide outlines production rules for communicating between Dart and native host platforms (Android, iOS, Windows C++, macOS, Linux) via **Platform Channels** and **Pigeon**.

---

## 1. Interop Selection: Pigeon vs. Raw Channels

### Strongly Recommended: Pigeon (Type-Safe Code Generation)
For any non-trivial platform integration, **Pigeon** is the official Flutter standard:
- Generates type-safe Dart, Kotlin/Java, Swift/Objective-C, and C++ bindings from a single Dart interface.
- Eliminates string-based method names and untyped map deserialization bugs.
- Provides compile-time error detection when native method signatures change.

```dart
// pigeons/messages.dart
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/platform/messages.g.dart',
  cppHeaderOut: 'windows/runner/messages.g.h',
  cppSourceOut: 'windows/runner/messages.g.cpp',
  kotlinOut: 'android/app/src/main/kotlin/com/example/Messages.g.kt',
  swiftOut: 'ios/Runner/Messages.g.swift',
))
@HostApi()
abstract class NativeDeviceApi {
  String getDeviceModel();
  bool isHardwareAccelerated();
}
```

---

## 2. Production Raw Channel Standards (When Pigeon is Not Used)

When maintaining raw channels:
- **`MethodChannel`**: One-shot asynchronous method calls (Dart $\leftrightarrow$ Native).
- **`EventChannel`**: Continuous asynchronous data streams (Native $\rightarrow$ Dart).
- **`BasicMessageChannel`**: String or binary buffer exchanges.

### Dart Call Site Invariants
Always wrap platform calls in `try-catch` handling `PlatformException`:
```dart
class DeviceInfoClient {
  static const _channel = MethodChannel('com.example.app/device_info');

  Future<String> getDeviceModel() async {
    try {
      final model = await _channel.invokeMethod<String>('getDeviceModel');
      return model ?? 'Unknown';
    } on PlatformException catch (e, stack) {
      log('Native call failed: ${e.message}', stackTrace: stack);
      throw NativePlatformFailure(e.message ?? 'Unknown platform failure', e.code);
    } on MissingPluginException catch (_) {
      throw const NativePlatformFailure('Plugin not implemented on this platform', 'UNAVAILABLE');
    }
  }
}
```

### EventChannel Stream Invariants
Stream subscriptions from `EventChannel` must be properly cancelled to prevent native resource leaks:
```dart
class BatteryStateMonitor {
  static const _eventChannel = EventChannel('com.example.app/battery_stream');
  StreamSubscription? _subscription;

  Stream<int> startListening() {
    return _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => event as int)
        .handleError((error) {
          log('Battery stream error: $error');
        });
  }

  void dispose() {
    _subscription?.cancel();
  }
}
```

---

## 3. Native Platform Threading & C++ Runner (Windows)

1. **Main Thread Invariant**: Platform channels must be invoked on the platform's main thread (UI thread in Android/iOS, main message loop in Windows).
2. **Offload Heavy Work**: If the native task performs disk I/O, heavy computation, or network calls:
   - Perform the work on a background worker thread / thread pool.
   - Dispatch the final result back to the main thread before invoking the Flutter result callback.
3. **Windows C++ Implementation**:
   - Register channels in `windows/runner/flutter_window.cpp`.
   - Never block `flutter::MethodResult::Success()` with synchronous blocking Win32 API calls.
