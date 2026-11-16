# Security Policy & Requirements (SECURITY.md)

This document establishes the security standards and vulnerability reporting policy for this application.

---

## 1. Security Architecture Principles

### Zero Hardcoded Secrets
- Private API keys, database credentials, and signing secrets must never be committed to git.
- Environment variables injected via `--dart-define` or `--dart-define-from-file`.

### Encrypted Local Storage
- All authentication tokens (JWTs, refresh tokens, biometric credentials) are stored using `FlutterSecureStorage` with hardware keystore backing (Android Keystore, Apple Keychain, Windows DPAPI).

### Transport Layer Security
- Enforce HTTPS across all network requests.
- No dummy certificate validation bypasses in release builds.

---

## 2. Platform Permission Minimums
- Declare only strictly required permissions in `AndroidManifest.xml`, `Info.plist`, and MSIX capabilities.
- Request sensitive permissions (camera, storage, notifications) at runtime only when the user triggers the feature.

---

## 3. Reporting Vulnerabilities
If you discover a security vulnerability in this application, please report it privately to `security@example.com`. Do not disclose security issues publicly until a patch has been published.
