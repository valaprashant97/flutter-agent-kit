# Secrets Protection & Key Management Rules

These rules establish strict security controls to prevent credential leaks, API key exposure, and improper secret storage.

---

## 1. The Zero-Hardcoded-Secrets Rule

> [!CAUTION]
> **Never Commit Private Secrets to Source Control.**
> An AI agent must never embed private API keys, database passwords, OAuth client secrets, or private signing keys directly into `.dart` files, manifests, or git-tracked configuration files.

---

## 2. Compile-Time Environment Injection

Inject public identifiers (e.g., Firebase public keys, Sentry DSNs, or base API URLs) at compile time using `--dart-define` or `--dart-define-from-file`:

### In `lib/core/config/env_config.dart`:
```dart
abstract final class EnvConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.dev.example.com',
  );

  static const String appEnvironment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'development',
  );
}
```

### Build Command:
```bash
flutter run --dart-define=API_BASE_URL=https://api.production.example.com --dart-define=APP_ENV=production
```
Or with an uncommitted `.env.json`:
```bash
flutter run --dart-define-from-file=.env.json
```

---

## 3. Client-Side vs Server-Side Secrets
- **Client-Side Keys**: Google Maps API keys, Firebase web client keys, and public analytics tokens are inherently public because they ship inside compiled client binaries. Restrict them using package name / SHA-1 fingerprint / HTTP referer restrictions in Google Cloud Console.
- **Server-Side Secrets**: Payment gateway private keys (e.g., Stripe Secret Key, AWS Access Keys, private LLM keys) **must never exist on the client**. Any operation requiring private secrets must be proxied through a secure backend server or cloud function.
