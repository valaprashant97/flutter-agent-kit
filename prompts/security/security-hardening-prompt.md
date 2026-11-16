# Security Audit & Hardening Prompt

You are acting as a Senior Application Security Engineer specializing in Flutter and mobile/desktop client security guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application**: [APP NAME & REPOSITORY ROOT]
- **Target Platforms**: [Windows Desktop, Android, iOS, Web, macOS, Linux]
- **Security Benchmark**: OWASP Mobile Application Security (MASVS), `docs/SECURITY.md`, `rules/security/`

---

## 2. OBJECTIVE
Conduct a comprehensive client-side security audit, identify security vulnerabilities and compliance gaps, and apply automated hardening fixes across storage, networking, permissions, secrets, and binary protection.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE CURRENT SECURITY POSTURE, SUSPECTED VULNERABILITIES, OR KNOWN RISKS]

---

## 4. REQUIRED INVESTIGATION
1. Scan all source files for hardcoded secrets, API tokens, passwords, and private keys (`rules/security/secrets-protection.md`).
2. Audit local persistence: verify whether tokens are stored in unencrypted SharedPreferences/Hive or encrypted storage (`rules/database/secure-storage.md`).
3. Audit HTTP networking: scan for plaintext HTTP URLs, disabled SSL verification (`badCertificateCallback`), and missing certificate pinning.
4. Inspect platform manifests (`AndroidManifest.xml`, `Info.plist`, Windows appxmanifest) for excessive or unused permissions.

---

## 5. CONSTRAINTS
- Zero credentials or API keys committed to source files.
- Never disable certificate validation in production builds.
- Use `--dart-define` or secure `.env` loaders injected at build time.
- All database write queries must be parameterized to prevent SQL injection.

---

## 6. ACCEPTANCE CRITERIA
- [ ] No hardcoded private keys or tokens remain in source files or git history.
- [ ] Authentication tokens stored exclusively in hardware-backed `FlutterSecureStorage`.
- [ ] Network traffic strictly enforces HTTPS; all insecure certificate bypasses removed.
- [ ] Release build scripts configured with `--obfuscate` and `--split-debug-info`.
- [ ] Manifest permissions reduced to the least-privilege set required.

---

## 7. EDGE CASES
- Jailbroken / rooted device detection and handling.
- Screen recording or screenshot capture of sensitive authentication screens (privacy overlay flags).
- Clipboard auto-clearing for copied sensitive passwords or two-factor codes.
- Windows credential manager DPAPI migration across OS user accounts.

---

## 8. TESTING REQUIREMENTS
- Automated secret detection scan across all source files.
- Unit tests verifying that insecure storage fallback throws an expected exception.

---

## 9. EXPECTED OUTPUT
1. Vulnerability Assessment Report (Findings categorized by CVSS severity).
2. Remediation code modifications and `.env.example` configurations.
3. Verification results confirming vulnerability resolution.
