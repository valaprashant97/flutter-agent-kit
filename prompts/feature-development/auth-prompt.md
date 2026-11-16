# Authentication & Secure Session Management Prompt

You are acting as a Senior Security & Mobile Software Engineer guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application**: [APP NAME & DOMAIN]
- **Authentication Method**: [Email/Password, OAuth2/OIDC, Social Auth, Biometrics, SSO]
- **Security & Architecture Guidelines**: `docs/SECURITY.md`, `docs/ARCHITECTURE.md`, `rules/security/`

---

## 2. OBJECTIVE
Implement a robust, secure authentication system covering token storage, automatic thread-safe token refresh, route protection, biometric unlock, and clean session termination.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE EXISTING AUTH MECHANISM, UNPROTECTED ROUTES, OR INSECURE STORAGE DEFECTS]

---

## 4. REQUIRED INVESTIGATION
1. Inspect `pubspec.yaml` for `flutter_secure_storage`, `dio`, `local_auth`, and `go_router`.
2. Check backend API contracts for login, token refresh, and logout payloads.
3. Verify platform keychain/keystore configurations in Android, iOS, and Windows runner manifests.

---

## 5. CONSTRAINTS
- Tokens must be stored exclusively in `flutter_secure_storage` with hardware-backed encryption.
- Never store raw tokens or passwords in `SharedPreferences`, `Hive`, or plaintext databases.
- Token refresh in Dio must use `QueuedInterceptor` to prevent race conditions during concurrent 401s.
- Zero plaintext credential leakage in logs or telemetry.

---

## 6. ACCEPTANCE CRITERIA
- [ ] Hardware-encrypted token storage implemented across Android, iOS, and Windows.
- [ ] Queued interceptor refreshes tokens transparently on 401 and replays original requests.
- [ ] Declarative route guards prevent unauthenticated access to private screens.
- [ ] Biometric authentication supports fallback to PIN/password.
- [ ] Full logout purges tokens, clears local user cache, and redirects to `/login`.
- [ ] Passes `flutter analyze` with 0 warnings.

---

## 7. EDGE CASES
- Refresh token expired or revoked on server (must force clean re-login).
- App closed while in background with sensitive screen visible (privacy blur overlay).
- Device biometric enrollment changes or biometrics disabled in OS settings.
- Concurrent network requests all failing with 401 simultaneously.

---

## 8. TESTING REQUIREMENTS
- Unit tests for the authentication state machine transitions (`AuthInitial`, `Authenticated`, `Unauthenticated`).
- Unit tests for `QueuedAuthInterceptor` mocking 401 recovery and token refresh failure.
- Widget tests for login form validation and error banner presentation.

---

## 9. EXPECTED OUTPUT
1. Authentication architecture and state transition map.
2. Complete, surgical code implementation across secure storage, networking, and UI.
3. Actual test verification execution output (`flutter test`).
