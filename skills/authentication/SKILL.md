---
name: authentication
description: Secure user authentication, token storage, biometric unlock, and OAuth session management.
---

# authentication

## 1. Skill Name
`authentication`

## 2. Purpose
Provides production standards for implementing secure authentication in Flutter applications: token-based auth (JWT access and refresh tokens), biometric authentication (`local_auth`), secure credential storage (`flutter_secure_storage`), and session expiry guards.

## 3. When to Use
- When implementing login, signup, biometric unlock, or OAuth flows.
- When managing user tokens, automatic token refreshing, or logout cleanups.
- When protecting navigation routes based on authenticated session state.

## 4. When Not to Use
- For simple client-side feature toggles or local preferences that do not involve authentication.

## 5. Required Project Context
- `pubspec.yaml` (`flutter_secure_storage`, `local_auth`)
- Backend authentication API specs

## 6. Step-by-Step Workflow
1. **Configure Secure Storage**: Initialize `FlutterSecureStorage` with hardware-backed encryption options (Android Keystore / iOS Keychain).
2. **Implement Token Storage Interface**: Create methods to write, read, and delete `accessToken` and `refreshToken`.
3. **Configure Queued Interceptor**: Wire Dio interceptor to attach bearer token to requests and handle 401 token refresh automatically.
4. **Implement Biometric Unlock**: Check biometric availability with `LocalAuthentication` and prompt user for fingerprint/Face ID.
5. **Manage Session State**: Emit auth state changes (`Unauthenticated`, `Authenticating`, `Authenticated`) to the router to control route redirection.
6. **Wipe on Logout**: Clear all secure storage tokens, cached databases, and user session stores on logout.

## 7. Engineering Rules
- **No Plaintext Passwords**: Never store raw user passwords in memory or on disk. Store only tokens or hashes.
- **Hardware-Backed Keystore**: Always enable `encryptedSharedPreferences: true` on Android and `KeychainAccessibility.first_unlock` on iOS.
- **Thread-Safe Refreshes**: Use a queued interceptor (`QueuedInterceptor`) so parallel requests wait for a single refresh token exchange to complete.

## 8. Code Examples
```dart
import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticateWithBiometrics() async {
    final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final isDeviceSupported = await _auth.isDeviceSupported();

    if (!canAuthenticateWithBiometrics || !isDeviceSupported) {
      return false;
    }

    try {
      return await _auth.authenticate(
        localizedReason: 'Scan fingerprint or Face ID to unlock your account',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
```

## 9. Common Mistakes
- Storing JWT tokens in `SharedPreferences` instead of `FlutterSecureStorage`.
- Forgetting to cancel pending refresh calls on 401 refresh failure, creating infinite refresh loops.
- Failing to clear local cached database rows when a user logs out.

## 10. Testing and Verification
- Unit test token refresh interceptor using mocked Dio adapter.
- Verify that logout wipes tokens from secure storage.

## 11. Completion Criteria
- User session persists securely across application restarts.
- 401 errors trigger automatic, silent token refresh.
- Logout purges all user credentials and session caches.

## 12. Related Skills
- `security-audit`
- `api-integration`
- `navigation`
