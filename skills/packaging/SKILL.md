---
name: packaging
description: Production release compilation, Dart code obfuscation, symbol splitting, and asset size shrinking.
---

# packaging

## 1. Skill Name
`packaging`

## 2. Purpose
Provides production build and packaging standards for Flutter applications across Android, iOS, Windows, macOS, Linux, and Web: enabling Dart AOT code obfuscation (`--obfuscate`), splitting debug symbol tables (`--split-debug-info`), optimizing asset sizes, and preparing distributable binaries.

## 3. When to Use
- When generating production release builds for public stores or direct client distribution.
- When minimizing application download size (APK, AAB, IPA, Windows installer).
- When hardening client binaries against reverse-engineering decompilation.

## 4. When Not to Use
- During local day-to-day development in debug mode.

## 5. Required Project Context
- `pubspec.yaml`
- Target platform release configuration and signing keys

## 6. Step-by-Step Workflow
1. **Clean Workspace**: Run `flutter clean && flutter pub get` to remove stale compilation caches.
2. **Configure Code Obfuscation**: Specify debug symbol directory to protect stacktraces while scrambling identifiers:
   ```bash
   flutter build <platform> --release --obfuscate --split-debug-info=build/symbols/<platform>
   ```
3. **Archive Debug Symbols**: Securely archive the generated symbol files (`app.android-arm64.symbols`) to your crash reporting service (e.g., Sentry / Firebase Crashlytics) to enable future stacktrace deobfuscation.
4. **Optimize Assets**: Ensure uncompressed PNGs are converted to WebP or vector SVGs, and remove unused font weights from `pubspec.yaml`.
5. **Verify Binary Integrity**: Launch and smoke-test the compiled release binary on a physical target device.

## 7. Engineering Rules
- **Never Ship Unobfuscated Enterprise Binaries**: Always include `--obfuscate` on public production builds to protect proprietary business logic.
- **Never Lose Symbol Files**: If you lose the symbol files generated during an obfuscated build, crash stacktraces from production will be permanently undecipherable.
- **Check File Size**: Track release artifact size; investigate sudden unexpected size spikes before publishing.

## 8. Code Examples
```bash
# Windows Desktop Release Build
flutter build windows --release

# Android App Bundle with Obfuscation & Symbol Splitting
flutter build appbundle --release \
  --obfuscate \
  --split-debug-info=build/symbols/android

# iOS IPA Build with Obfuscation
flutter build ipa --release \
  --obfuscate \
  --split-debug-info=build/symbols/ios

# Web Production WASM Build
flutter build web --wasm --release
```

## 9. Common Mistakes
- Enabling obfuscation without archiving debug symbols, rendering all subsequent crash reports unreadable strings of memory addresses.
- Bundling raw 10MB test video or audio files in the `assets/` folder, bloating the app download size.
- Testing only debug mode and shipping a release build with broken tree-shaken reflection or missing ProGuard keep rules.

## 10. Testing and Verification
- Run the release compilation command for the target platform.
- Confirm compilation succeeds with exit code 0.
- Verify symbols are output to the designated directory.

## 11. Completion Criteria
- Production release artifact generated.
- Code obfuscation and symbol splitting enabled.
- Binary verified on target platform.

## 12. Related Skills
- `msix-release`
- `security-audit`
- `production-readiness`
