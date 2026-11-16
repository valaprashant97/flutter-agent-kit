# Secure Storage & Credentials Persistence Rules

These rules govern the encrypted storage of secrets, tokens, and credentials using `flutter_secure_storage`.

---

## 1. Native Encryption Mechanisms by Platform

`flutter_secure_storage` interfaces with platform-native hardware security keystores:

| Platform | Native Cryptographic Backing | Hardware Security Module |
| :--- | :--- | :--- |
| **Android** | Android Keystore & EncryptedSharedPreferences (AES-256 GCM) | TEE / StrongBox |
| **iOS / macOS** | Apple Keychain Services | Secure Enclave |
| **Windows** | Windows Data Protection API (DPAPI) | Local Windows User Credential Store |
| **Linux** | `libsecret` / FreeDesktop Secret Service | GNOME Keyring / KWallet |

---

## 2. Invariants for Storing Secrets

### Rule 1: Never Store Secrets in Plaintext SharedPreferences
- Plaintext `SharedPreferences` files (`shared_prefs/*.xml` on Android, `.plist` on iOS) can be extracted from unencrypted backups or rooted/jailbroken devices.
- Always store JWT tokens, refresh tokens, encryption keys, and PIN hashes in `FlutterSecureStorage`.

### Rule 2: Configure Android Options with EncryptedSharedPreferences
```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),
  iOptions: IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  ),
);
```

### Rule 3: Error Handling & First-Unlock Latency
On mobile devices, reading from the secure enclave immediately upon device reboot before the user enters their passcode may fail or return null. Always handle null gracefully and catch `PlatformException`:
```dart
Future<String?> readTokenSafely(String key) async {
  try {
    return await secureStorage.read(key: key);
  } catch (e) {
    // Handle corrupted keychain or locked device state
    return null;
  }
}
```
