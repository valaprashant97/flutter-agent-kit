---
name: security-audit
description: Comprehensive security auditing, secret scanning, reverse engineering defense, and platform permission verification.
---

# security-audit

## 1. Skill Name
`security-audit`

## 2. Purpose
Audits Flutter applications against security vulnerabilities: hardcoded API keys and secrets, insecure local storage, unencrypted HTTP traffic, missing SSL pinning, injection attacks, insecure WebViews, and over-privileged platform manifests.

## 3. When to Use
- Prior to releasing an app to the public, App Stores, or enterprise deployment.
- After integrating third-party SDKs, payment gateways, or authentication providers.
- Periodically as part of regular software security audits.

## 4. When Not to Use
- During early local prototyping when testing fake mock data.

## 5. Required Project Context
- Full codebase, including `pubspec.yaml`, manifests (`AndroidManifest.xml`, `Info.plist`, Windows runner configs), and network configurations.

## 6. Step-by-Step Workflow
1. **Secret Scanning**: Grep codebase for private keys, AWS secrets, Stripe secret keys, and database passwords.
2. **Storage Audit**: Verify that JWTs, tokens, and encryption keys are stored in `FlutterSecureStorage` (not plain `SharedPreferences`).
3. **Transport Security Audit**: Confirm that all remote endpoints use HTTPS. Check for certificate validation bypasses (`badCertificateCallback: (cert, host, port) => true`).
4. **Platform Manifest Audit**: Inspect `AndroidManifest.xml` and `Info.plist` to ensure only strictly necessary permissions are requested.
5. **Code Obfuscation Check**: Ensure release build scripts enable `--obfuscate` and `--split-debug-info`.
6. **Generate Security Report**: Document findings with CVSS severity ratings and remediation steps.

## 7. Engineering Rules
- **Zero Secrets in Code**: Any detected hardcoded private secret is an automatic Critical release blocker.
- **No Insecure Bypasses**: Never leave TLS validation disabled or wildcarded in release configurations.
- **Least Privilege**: Remove unused permissions (e.g., location, camera, contacts) from platform manifests.

## 8. Code Examples
```bash
# Automated secret scanning check
git grep -iE "(api_key|secret|password|bearer|private_key)\s*[:=]\s*['\"][0-9a-zA-Z_\-]{16,}['\"]" lib/
```

```dart
// Auditing Secure Storage Configuration
// SECURE: Uses hardware-backed Android KeyStore & iOS Keychain
const secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
  iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
);
```

## 9. Common Mistakes
- Confusing public client keys (like Google Maps API keys) with private backend secrets (like Stripe Secret Keys).
- Committing `.env` files containing production secrets to git repositories.
- Disabling certificate verification during debugging and accidentally shipping it to production.

## 10. Testing and Verification
- Run secret scanning script across all git commits and branches.
- Verify that compiled release binaries use code obfuscation.

## 11. Completion Criteria
- Formal security audit report generated.
- Zero Critical or High vulnerabilities remaining unmitigated.
- Release configuration verified for obfuscation and transport security.

## 12. Related Skills
- `code-review`
- `authentication`
- `packaging`
