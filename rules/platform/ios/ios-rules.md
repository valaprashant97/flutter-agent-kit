# iOS Platform Rules & Invariants

These rules govern Flutter development on iOS and iPadOS devices.

---

## 1. Privacy Manifests & Info.plist Keys
1. **Privacy Manifest (`PrivacyInfo.xcprivacy`)**:
   - Required by Apple for App Store submission.
   - Declare all accessed API categories (File timestamp, system boot time, disk space, user defaults).
2. **Usage Descriptions**:
   - Every hardware capability requested must have a clear, user-facing explanation in `ios/Runner/Info.plist`:
     - `NSCameraUsageDescription`
     - `NSPhotoLibraryUsageDescription`
     - `NSLocationWhenInUseUsageDescription`
     - `NSFaceIDUsageDescription`
   - Vague descriptions (e.g., "We need camera for app functionality") will be rejected during App Store review.

---

## 2. Safe Areas & Gestures
1. **Always Wrap Root Views in `SafeArea`**:
   - Accommodate the dynamic island, sensor notch, and home indicator bar at the bottom.
2. **Back Swipe Gesture**:
   - Ensure declarative routes (`go_router`) support the native iOS interactive pop gesture (swipe from left edge) out of the box.
