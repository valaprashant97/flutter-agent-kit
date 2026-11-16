# Workflow: Release Preparation & Packaging

This workflow defines the compilation, code signing, and packaging protocol for releasing Flutter applications across target platforms.

---

## 1. Entry Conditions
- Feature freeze reached and all milestone tasks in `docs/TASKS.md` marked complete.
- Static analysis and automated test suite are 100% green.

---

## 2. Step-by-Step Procedure

### Phase 1: Version Management
1. Update `version: x.y.z+b` in `pubspec.yaml` following Semantic Versioning (`major.minor.patch+buildNumber`).
2. Update `CHANGELOG.md` with release notes and bug fix summaries.

### Phase 2: Compilation & Packaging
Execute release builds for target platforms:

#### Windows Desktop
```bash
# Compile release binary
flutter build windows --release

# Package into signed MSIX installer
dart run msix:create
```

#### Android
```bash
flutter build appbundle --release \
  --obfuscate \
  --split-debug-info=build/symbols/android
```

#### iOS
```bash
flutter build ipa --release \
  --obfuscate \
  --split-debug-info=build/symbols/ios
```

#### Web
```bash
flutter build web --wasm --release
```

### Phase 3: Archive Debug Symbols
Store the generated symbol files (`build/symbols/`) in secure artifact storage to enable deobfuscation of crash stacktraces.

### Phase 4: Installer & Binary Smoke Testing
1. Install generated release binary/MSIX on a clean test device.
2. Verify startup, assets, offline error states, and uninstallation.

---

## 3. Exit Criteria
- Production release binaries compiled and signed.
- MSIX package generated for Windows.
- Debug symbols archived.
- `CHANGELOG.md` updated.
