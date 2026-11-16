# Workflow: Security Review & Hardening

This workflow defines the security verification procedure for detecting vulnerabilities, secret leaks, and platform permission flaws.

---

## 1. Entry Conditions
- Pre-release preparation or post-implementation security gate.
- Full codebase access.

---

## 2. Step-by-Step Procedure

### Phase 1: Secret & Credential Scanning
1. Search codebase for committed API keys, private tokens, and passwords:
   ```bash
   git grep -iE "(api_key|secret|password|bearer|private_key)\s*[:=]\s*['\"][0-9a-zA-Z_\-]{16,}['\"]" lib/
   ```
2. Confirm that public identifiers use `--dart-define` and private keys are strictly server-side.

### Phase 2: Local Storage Security Audit
1. Verify that sensitive authentication tokens (JWTs, refresh tokens) use `FlutterSecureStorage`.
2. Confirm that Android `encryptedSharedPreferences: true` and iOS `KeychainAccessibility.first_unlock` are enabled.

### Phase 3: Network Transport Security Audit
1. Verify that all network requests use HTTPS.
2. Confirm that release configurations do NOT bypass SSL certificate verification (`badCertificateCallback`).

### Phase 4: Platform Manifests & Permissions
1. Inspect `android/app/src/main/AndroidManifest.xml`: remove unnecessary permissions.
2. Inspect `ios/Runner/Info.plist`: verify usage descriptions for camera, location, and storage.
3. Inspect `windows/runner/`: verify capabilities declared in MSIX config.

### Phase 5: Code Obfuscation Verification
1. Verify that production build commands include `--obfuscate` and `--split-debug-info`.

---

## 3. Exit Criteria
- Zero Critical or High vulnerabilities identified.
- Formal security audit report generated in `docs/SECURITY.md`.
