# Production Build & Deployment Setup Prompt

You are acting as a Senior DevOps Engineer and Release Specialist specializing in Flutter cross-platform deployment guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application**: [APP NAME & VERSION]
- **Target Platforms**: [Windows Desktop, Android, iOS, Web, macOS, Linux]
- **Release Guidelines**: `docs/WINDOWS_DEVELOPMENT.md`, `skills/msix-release/`, `skills/packaging/`

---

## 2. OBJECTIVE
Prepare, harden, compile, code-sign, and package production-ready release artifacts (MSIX for Windows, AAB for Android, IPA for iOS) with code obfuscation and debug symbol archiving.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE CURRENT BUILD STATUS: DEBUG-ONLY BUILDS, MISSING SIGNING CONFIGS, OR UNPACKAGED BINARIES]

---

## 4. REQUIRED INVESTIGATION
1. Verify semantic versioning (`version: major.minor.patch+build`) in `pubspec.yaml`.
2. Check signing credentials, keystores, provisioning profiles, or Windows PFX certificates.
3. Verify target platform configurations (`windows/runner/`, `android/app/build.gradle`, `ios/Runner.xcodeproj`).

---

## 5. CONSTRAINTS
- All release builds must enable code obfuscation (`--obfuscate`) and debug symbol splitting (`--split-debug-info`).
- Never commit private keystore passwords or PFX certificates to version control.
- Windows binaries must be bundled via signed MSIX installer with verified capability manifests.

---

## 6. ACCEPTANCE CRITERIA
- [ ] Version and build numbers bumped in `pubspec.yaml`.
- [ ] Windows MSIX created and signed: `dart run msix:create`.
- [ ] Android App Bundle generated: `flutter build appbundle --release`.
- [ ] Debug symbols archived in `build/symbols/` for crash reporting upload.
- [ ] `CHANGELOG.md` updated with release highlights.

---

## 7. EDGE CASES
- App upgrade overwriting previous version without corrupting existing AppData or SQLite files.
- Windows SmartScreen warning handling via valid code-signing certificate.
- Android 14+ target SDK requirements and dynamic permission behavior.

---

## 8. TESTING REQUIREMENTS
- Perform clean install, launch, and uninstall verification on target devices.
- Verify binary signature validity using `signtool.exe` (Windows) or `jarsigner` (Android).

---

## 9. EXPECTED OUTPUT
1. Deployment configuration summary.
2. Build commands and executed console logs.
3. Package artifact paths and hash verifications.
