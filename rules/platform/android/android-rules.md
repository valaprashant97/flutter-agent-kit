# Android Platform Rules & Invariants

These rules govern Flutter development on Android devices.

---

## 1. Gradle & SDK Constraints
1. **Target SDK**: Ensure `compileSdk` and `targetSdk` comply with the current Google Play minimum API level requirements (API 34+).
2. **ProGuard / R8 Obfuscation**:
   - When enabling code shrinking in `android/app/build.gradle`, add keep rules for any third-party Java/Kotlin SDKs accessed via platform channels in `proguard-rules.pro`.
   - Never suppress ProGuard warnings blindly.

---

## 2. Runtime Permissions & Scoped Storage
1. **Runtime Permission Checks**: Never assume permissions granted in `AndroidManifest.xml` are active. Always check and request permissions at runtime using `permission_handler`:
   ```dart
   final status = await Permission.camera.request();
   if (status.isPermanentlyDenied) {
     openAppSettings();
   }
   ```
2. **Scoped Storage (Android 10+)**: Do not request legacy `WRITE_EXTERNAL_STORAGE`. Save user-facing media files through MediaStore or SAF (Storage Access Framework), and internal data in `getApplicationDocumentsDirectory()`.
