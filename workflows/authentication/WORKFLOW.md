# Workflow: Authentication & Secure Session Management

This workflow guides an AI coding agent through architecting, implementing, securing, and testing user authentication, biometric unlock, token refresh, and session expiration in Flutter.

---

## 1. Entry Conditions
- Application requires user identity verification (Email/Password, OAuth2, Social Login, Biometric unlock, or SSO).
- Tokens, sessions, and protected routes must be secured.

---

## 2. Step-by-Step Procedure

### Phase 1: Authentication Architecture & State Machine
1. Model the complete authentication state machine:
   - `AuthInitial` (checking existing saved session)
   - `AuthAuthenticated(User user, Tokens tokens)`
   - `AuthUnauthenticated`
   - `AuthRequiresTwoFactor`
   - `AuthLoading`
   - `AuthFailureState(AuthFailure failure)`
2. Document session expiration policies and refresh token flows in `docs/SECURITY.md`.

### Phase 2: Secure Token Storage
1. Store access and refresh tokens exclusively in `flutter_secure_storage` (`rules/database/secure-storage.md`):
   - Windows: Win32 DPAPI / Windows Credential Manager.
   - Android: EncryptedSharedPreferences with Android KeyStore.
   - iOS: Keychain Services (`kSecAttrAccessibleAfterFirstUnlock`).
2. **Never store raw tokens in `SharedPreferences`, `Hive`, or plaintext SQLite tables**.

### Phase 3: Token Refresh Interceptor
1. Implement a queued lock inside the Dio networking interceptor to prevent race conditions when multiple parallel requests hit a 401:
```dart
class QueuedAuthInterceptor extends QueuedInterceptor {
  final TokenStorage tokenStorage;
  final Dio authDio;

  QueuedAuthInterceptor({required this.tokenStorage, required this.authDio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final newToken = await _refreshToken();
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $newToken';
        final cloneReq = await authDio.fetch(opts);
        return handler.resolve(cloneReq);
      } catch (e) {
        await tokenStorage.clearAll();
        return handler.next(err);
      }
    }
    handler.next(err);
  }
}
```

### Phase 4: Route Guards & Deep Link Protection
1. Configure `GoRouter` redirect callback:
   - If user is `AuthUnauthenticated` and attempting to access a protected route (e.g. `/dashboard`), redirect to `/login`.
   - If user is `AuthAuthenticated` and navigates to `/login`, redirect to `/dashboard`.
2. Handle deep links containing one-time auth tokens safely.

### Phase 5: Logout & Session Cleanup
1. On user logout or refresh token failure:
   - Clear secure storage tokens.
   - Clear cached database records (if multi-user security is required).
   - Reset navigation stack to `/login`.

---

## 3. Exit Criteria & Quality Gates
- [ ] Raw credentials and tokens are stored exclusively in secure platform storage.
- [ ] Concurrent 401 interceptor handles single token refresh without multiple parallel refresh calls.
- [ ] Route guards protect all private screens.
- [ ] Logout completely purges sensitive session data.
- [ ] Automated tests verify auth state machine transitions.

---

## 4. Related Skills & Rules
- `skills/authentication/`
- `skills/security-audit/`
- `rules/security/secrets-protection.md`
- `rules/networking/dio.md`
