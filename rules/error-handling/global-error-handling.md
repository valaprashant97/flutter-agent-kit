# Global Error Handling & Crash Interception Rules

This guide outlines production rules for configuring application-wide error handling, crash reporting, and graceful UI degradation in Flutter applications.

---

## 1. Modern Flutter 3.x Dual-Hook Architecture

In modern Flutter (3.3+), crash interception requires registering two complementary hooks in `main()`:
1. **`FlutterError.onError`**: Captures synchronous framework exceptions thrown during widget building, layout constraint resolution, and painting.
2. **`PlatformDispatcher.instance.onError`**: Captures unhandled asynchronous exceptions originating from `Future`, `Stream`, timer callbacks, and isolates.

### Canonical `main.dart` Setup
```dart
import 'dart:ui';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Framework errors (build, layout, paint)
  FlutterError.onError = (FlutterErrorDetails details) {
    // Print to console in debug mode
    FlutterError.presentError(details);

    // Forward to crash telemetry service (Sentry, Firebase Crashlytics)
    CrashReporter.logFlutterError(details);
  };

  // 2. Asynchronous isolate & Future errors
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    CrashReporter.logUnhandledError(error, stack);
    return true; // Returns true to prevent app crash / process termination
  };

  // 3. Graceful UI Fallback (Replacing the red screen of death)
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return FallbackErrorScreen(details: details);
  };

  runApp(const MyApp());
}
```

---

## 2. Replacing the Red Screen of Death (`ErrorWidget.builder`)

In release builds, unhandled widget build errors traditionally display a blank gray screen (or red screen in debug mode). Production applications must provide a user-friendly error fallback:

```dart
class FallbackErrorScreen extends StatelessWidget {
  final FlutterErrorDetails details;

  const FallbackErrorScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Something went wrong',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'We have logged this issue and are working on a fix.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to safe root or restart flow
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
                child: const Text('Return to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 3. Crash Reporting Hygiene & PII Sanitization

1. **Never Leak Sensitive Data in Reports**:
   - Scrub authorization headers (`Bearer eyJ...`), passwords, card numbers, and emails before sending to Crashlytics or Sentry.
2. **Context Enrichment**:
   - Attach environment details: app version, build number, OS version, device model, and current user ID (hashed/pseudonymous, never email/phone).
3. **Breadcrumbs**:
   - Log navigation route changes and major user actions as breadcrumbs to provide diagnostic context without recording sensitive payload inputs.
