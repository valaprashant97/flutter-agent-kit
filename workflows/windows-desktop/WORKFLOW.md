# Workflow: Windows Desktop Engineering & Release Lifecycle

This workflow guides an AI coding agent through developing, hardening, packaging, signing, and certifying a production-grade Flutter application for **Windows Desktop**.

---

## 1. Entry Conditions
- Target application is configured for Windows (`flutter create --platforms windows .` or existing `windows/` runner).
- Windows development prerequisites (Visual Studio C++ Desktop Development tools, Windows 10/11 SDK) are present on the host.

---

## 2. Step-by-Step Procedure

### Phase 1: Tooling & Environment Verification
1. Run `flutter doctor` and verify the Windows Desktop toolchain:
   ```powershell
   flutter doctor -v
   ```
2. Verify C++ CMake and MSBuild build readiness.

### Phase 2: Native C++ Runner Hardening (`windows/runner/main.cpp`)
1. **Configure Per-Monitor V2 DPI Awareness**:
   - Ensure `SetProcessDpiAwarenessContext(DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2);` is called before window creation to prevent blurry text on mixed-DPI multi-monitor environments.
2. **Implement Win32 Single-Instance Mutex**:
   - Create a named mutex (`Global\\<AppID>_SingleInstanceMutex`).
   - If an instance already exists, restore the running window with `ShowWindow(existingHwnd, SW_RESTORE)` and bring it to foreground with `SetForegroundWindow(existingHwnd)`, then terminate the duplicate process.

### Phase 3: Desktop UI Ergonomics & Navigation
1. **Window Size Constraints**: Configure `window_manager` with minimum (`800x600`) and default dimensions (`1280x720`).
2. **Keyboard Shortcuts**: Map standard desktop shortcuts (`Ctrl+S`, `Ctrl+F`, `Ctrl+N`, `Escape`) using `Shortcuts` and `Actions`.
3. **Hover & Cursor States**: Ensure all interactive widgets show `SystemMouseCursors.click` and responsive hover highlights.
4. **Context Menus**: Add right-click desktop menus to data lists and cards using `showMenu()`.

### Phase 4: System Tray & Process Lifecycle
1. Configure `tray_manager` with `.ico` icon and context menu ('Open', 'Exit').
2. Set `windowManager.setPreventClose(true)`.
3. In `onWindowClose()`, hide the window to the tray and set `windowManager.setSkipTaskbar(true)`.
4. In tray menu 'Exit Application', call `windowManager.destroy()` to terminate the process cleanly.

### Phase 5: Native Windows Integration
1. **Native Toast Notifications**: Configure `local_notifier` for actionable desktop toasts.
2. **Autostart on Login**: Manage registry key `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`.
3. **Persistent App Data**: Store databases and user settings in `%APPDATA%` via `path_provider` (`getApplicationSupportDirectory()`).

### Phase 6: MSIX Packaging, Signing & Release Certification
1. Add `msix` to `dev_dependencies` in `pubspec.yaml` with app name, publisher, version, and capabilities.
2. Configure code signing certificate (self-signed for testing or commercial EV PFX cert).
3. Build release executable and MSIX installer:
   ```powershell
   flutter build windows --release
   dart run msix:create
   ```
4. Verify MSIX installer on a test machine: clean installation, shortcut creation, data persistence, and clean uninstallation.

---

## 3. Exit Criteria & Quality Gates
- [ ] Release binary compiles without errors: `flutter build windows --release`.
- [ ] Single-instance Mutex prevents launching duplicate instances.
- [ ] Window restores crisply across different monitor DPI settings.
- [ ] Minimize to tray keeps background process alive without taskbar clutter.
- [ ] MSIX package is generated, signed, and installable.

---

## 4. Related Skills & Rules
- `skills/windows-development/`
- `skills/desktop-development/`
- `skills/msix-release/`
- `rules/platform/windows/windows-rules.md`
- `docs/WINDOWS_DEVELOPMENT.md`
