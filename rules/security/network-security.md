# Network Security & Transport Security Rules

These rules enforce secure network communication, TLS standards, and certificate pinning in Flutter.

---

## 1. Transport Layer Security (TLS) Standards
- **Enforce HTTPS Everywhere**: Cleartext HTTP (`http://`) traffic is strictly prohibited in production builds.
- **Android Network Security Config**: Ensure `android:usesCleartextTraffic="false"` is set in `AndroidManifest.xml`.
- **iOS App Transport Security (ATS)**: Do not add `NSAllowsArbitraryLoads: true` in `Info.plist`.

---

## 2. SSL / TLS Certificate Pinning

For high-security financial, healthcare, or enterprise applications, implement certificate pinning to prevent Man-in-the-Middle (MitM) attacks:

```dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

void enableCertificatePinning(Dio dio, String expectedFingerprint) {
  dio.httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        // Compare SHA-256 fingerprint of the remote certificate
        final certFingerprint = cert.sha256.map((b) => b.toRadixString(16).padLeft(2, '0')).join(':');
        return certFingerprint.toUpperCase() == expectedFingerprint.toUpperCase();
      };
      return client;
    },
  );
}
```

---

## 3. Disabling Insecure Debug Proxies in Release Mode
Never leave `badCertificateCallback = (cert, host, port) => true;` enabled in release mode. Always guard proxy or test certificates behind compile-time debug flags:
```dart
if (kDebugMode) {
  // Only permit self-signed local mock servers in debug builds
  client.badCertificateCallback = (cert, host, port) => host == 'localhost';
}
```
