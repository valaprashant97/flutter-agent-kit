# macOS Platform Rules & Invariants

These rules govern Flutter development on macOS Desktop.

---

## 1. App Sandbox & Entitlements
macOS applications are sandboxed by default. Hardware, networking, and filesystem access require explicit entitlements in `macos/Runner/DebugProfile.entitlements` and `Release.entitlements`:
- **Network Client**: Required for outgoing HTTP calls:
  ```xml
  <key>com.apple.security.network.client</key>
  <true/>
  ```
- **File Access (User Selected)**: Required for file pickers:
  ```xml
  <key>com.apple.security.files.user-selected.read-write</key>
  <true/>
  ```

---

## 2. macOS UI Conventions
1. **Menu Bar Integration**: Provide native macOS top menu bar actions (`PlatformMenuBar` / `PlatformMenuItem`) for File, Edit, View, and Window operations.
2. **Key Equivalents**: Map shortcuts to `Cmd` (`LogicalKeyboardKey.meta`) instead of `Ctrl`.
3. **Window Controls**: Position custom window drag areas and titlebars respecting macOS's left-aligned traffic light buttons (Close, Minimize, Zoom).
