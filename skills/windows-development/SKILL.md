---
name: windows-development
description: Deep native Windows desktop engineering: single-instance mutex, Per-Monitor V2 DPI awareness, system tray, minimize-to-tray, toast notifications, startup registry, and Win32 interop.
---

# windows-development

## 1. Skill Name
`windows-development`

## 2. Purpose
Provides production-grade Windows desktop engineering guidance for Flutter applications: Win32 single-instance mutex enforcement, Per-Monitor V2 DPI awareness, system tray management (`tray_manager`), window state lifecycles (window closed vs minimized vs tray vs background vs process terminated), Windows Toast notifications (`local_notifier`), autostart on Windows login via registry keys, and native Win32 API integration.

## 3. When to Use
- When developing, hardening, or debugging Flutter applications targeting Windows Desktop.
- When preventing duplicate application instances from launching simultaneously.
- When configuring high-DPI scaling across multi-monitor setups with mixed scaling factors.
- When implementing system tray minimization, notification toasts, or autostart registry behavior.
- When interacting with native Win32 APIs or the Windows C++ runner (`windows/runner/`).

## 4. When Not to Use
- For mobile or web projects that do not target Windows.

## 5. Required Project Context
- `pubspec.yaml` (`tray_manager`, `window_manager`, `local_notifier`, `win32`, `windows_single_instance`)
- `windows/runner/main.cpp` & `windows/runner/flutter_window.cpp` (C++ Win32 runner)

## 6. Step-by-Step Workflow
1. **Configure Single-Instance Mutex**:
   - In `windows/runner/main.cpp` or via `windows_single_instance`, create a named Win32 Mutex to detect if an instance is already running. If active, bring the existing window to the foreground and terminate the second process.
2. **Ensure Per-Monitor V2 DPI Awareness**:
   - Verify `SetProcessDpiAwarenessContext(DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2)` is invoked in `windows/runner/main.cpp` before window creation.
3. **Initialize Windows Packages**:
   - Initialize `windowManager`, `trayManager`, and `localNotifier` in Dart `main()` before `runApp()`.
4. **Implement Window Close Interception**:
   - Configure `windowManager.setPreventClose(true)` to intercept `WM_CLOSE` messages and hide the window to the system tray instead of terminating the process immediately.
5. **Configure System Tray**:
   - Set icon (`.ico`), tooltip, and context menu with 'Open' and 'Exit' actions.
6. **Implement Toast Notifications**:
   - Initialize `localNotifier` with application shortcut policy and display native Windows toasts.
7. **Configure Autostart on Login**:
   - Manage Windows registry key: `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`.
8. **Handle Safe Process Termination**:
   - When the user explicitly selects 'Exit' from the tray menu, call `windowManager.destroy()` to terminate the process cleanly.

## 7. Engineering Rules
- **Single-Instance Invariant**: Enterprise applications must enforce single-instance execution to protect SQLite/Isar database locks and prevent duplicate background sync tasks.
- **DPI Scaling Invariant**: Never disable DPI awareness. Use Per-Monitor V2 awareness to avoid blurred text on multi-monitor setups.
- **State Machine Invariant**: Never confuse window closure with process termination:
  $$\text{Window Closed} \ne \text{Window Minimized} \ne \text{System Tray} \ne \text{Background Service} \ne \text{Process Terminated}$$
- **Post-Termination Background Invariant**: Do NOT claim that Dart code or scheduled notifications execute after process termination unless a native Windows Task Scheduler job (`schtasks.exe`) or Windows Service is registered.
- **Path Delimiters**: Always use `p.windows` or `p.join()` for Windows file paths. Never hardcode `C:\`.

## 8. Code Examples

### Single-Instance Mutex & DPI Setup in C++ Runner (`windows/runner/main.cpp`)
```cpp
#include <windows.h>
#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include "flutter_window.h"
#include "utils.h"

int APIENTRY wWinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance,
                      _In_ PWSTR pCmdLine, _In_ int nCmdShow) {
  // 1. Enforce Per-Monitor V2 DPI Awareness
  SetProcessDpiAwarenessContext(DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2);

  // 2. Win32 Named Mutex Single-Instance Check
  HANDLE hMutex = CreateMutexW(NULL, TRUE, L"Global\\MyEnterpriseFlutterApp_SingleInstanceMutex");
  if (GetLastError() == ERROR_ALREADY_EXISTS) {
    // An instance is already running; bring it to foreground
    HWND existingHwnd = FindWindowW(L"FLUTTER_RUNNER_WIN32_WINDOW", L"Enterprise Windows App");
    if (existingHwnd) {
      if (IsIconic(existingHwnd)) ShowWindow(existingHwnd, SW_RESTORE);
      SetForegroundWindow(existingHwnd);
    }
    CloseHandle(hMutex);
    return 0; // Terminate this duplicate instance
  }

  // 3. Normal Flutter Window Startup
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);
  flutter::DartProject project(L"data");
  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.Create(L"Enterprise Windows App", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  ReleaseMutex(hMutex);
  CloseHandle(hMutex);
  return EXIT_SUCCESS;
}
```

### Minimize-to-Tray Lifecycle in Dart
```dart
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:local_notifier/local_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await localNotifier.setup(appName: 'Enterprise Windows App');

  const windowOptions = WindowOptions(
    size: Size(1100, 750),
    minimumSize: Size(800, 600),
    center: true,
    titleBarStyle: TitleBarStyle.normal,
    title: 'Enterprise Windows App',
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const WindowsAppRoot());
}

class WindowsAppRoot extends StatefulWidget {
  const WindowsAppRoot({super.key});
  @override
  State<WindowsAppRoot> createState() => _WindowsAppRootState();
}

class _WindowsAppRootState extends State<WindowsAppRoot> with WindowListener, TrayListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    trayManager.addListener(this);
    _setupSystemTray();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    trayManager.removeListener(this);
    super.dispose();
  }

  Future<void> _setupSystemTray() async {
    await trayManager.setIcon('assets/icons/app_icon.ico');
    await trayManager.setToolTip('Enterprise Windows App');
    final menu = Menu(items: [
      MenuItem(key: 'show_app', label: 'Open Window'),
      MenuItem.separator(),
      MenuItem(key: 'exit_app', label: 'Exit Application'),
    ]);
    await trayManager.setContextMenu(menu);
    await windowManager.setPreventClose(true);
  }

  @override
  void onWindowClose() async {
    // Minimize to tray instead of quitting
    await windowManager.hide();
    await windowManager.setSkipTaskbar(true);
  }

  @override
  void onMenuItemSelected(MenuItem item) async {
    if (item.key == 'show_app') {
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
      await windowManager.focus();
    } else if (item.key == 'exit_app') {
      await windowManager.destroy(); // Full process termination
    }
  }

  @override
  void onTrayIconMouseDown() async {
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
    await windowManager.focus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Enterprise Windows App')),
        body: const Center(child: Text('Running on Windows Desktop')),
      ),
    );
  }
}
```

## 9. Common Mistakes
- Calling `exit(0)` directly instead of `windowManager.destroy()`, bypassing C++ cleanup hooks in `windows/runner/flutter_window.cpp`.
- Spawning duplicate instances that corrupt local SQLite/Isar database file locks.
- Forgetting to provide a high-resolution `.ico` file for the system tray, resulting in a blank or corrupted tray icon.
- Believing that closing the app window keeps background Dart timers firing after the process terminates.

## 10. Testing and Verification
- Compile and run debug build: `flutter run -d windows`.
- Attempt to launch a second instance: verify that focus returns to the first instance and no second window opens.
- Verify that clicking the window 'X' button hides the window to the tray and removes it from the Windows taskbar.
- Verify that clicking the tray icon restores window focus.
- Verify that selecting 'Exit Application' from the tray menu terminates the process completely.

## 11. Completion Criteria
- Single-instance mutex prevents duplicate instances.
- High-DPI Per-Monitor V2 awareness is active.
- System tray icon and context menus are fully functional.
- Minimize-to-tray lifecycle functions without process termination.
- Windows release build compiles successfully with `flutter build windows --release`.

## 12. Related Skills
- `desktop-development`
- `msix-release`
- `notifications`
- `file-system`
