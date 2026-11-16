# Windows Platform Rules & Invariants

These rules govern Flutter development on Windows Desktop.

---

## 1. Process Lifecycle & Window Boundaries
1. **Closing $\ne$ Termination**: Closing the main window (`onWindowClose`) must not assume the process terminates if minimize-to-tray or background services are configured.
2. **Background Tasks After Exit**: To run tasks when the process is terminated, register an OS-level task with Windows Task Scheduler (`schtasks.exe`). Dart isolates inside the app cannot run after the process terminates.
3. **Single-Instance Mutex**: Production enterprise apps must enforce single-instance application execution using a Win32 Mutex to prevent multiple processes from corrupting SQLite/Isar database locks or opening duplicate windows.
4. **Per-Monitor V2 DPI Awareness**: Always ensure `SetProcessDpiAwarenessContext(DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2)` is configured in the C++ runner to prevent blurry text when users move windows across displays with different scaling factors (e.g. 100% and 150%).

---

## 2. Windows UI Ergonomics
1. **Keyboard Shortcuts**: Every primary action must support standard Windows shortcuts (e.g., `Ctrl+S` Save, `Ctrl+F` Find, `Ctrl+Z` Undo, `Escape` Close modal) using `Shortcuts` and `Actions`.
2. **Mouse Hover States**: Buttons and list items must provide hover feedback using `MouseRegion` or `InkWell(onHover: ...)`.
3. **Cursor Changes**: Change cursor to `SystemMouseCursors.click` on interactive elements and `SystemMouseCursors.resizeUpDown` on resizable panes.
4. **Context Menus**: Right-clicking table rows or cards must display native or custom desktop context menus using `showMenu()`.

---

## 3. Windows File System & Persistence
1. **Never Hardcode Drive Letters**: Never assume `C:\`. Always resolve paths through `path_provider` (`getApplicationSupportDirectory()`).
2. **Path Separators**: Use `package:path`'s `p.join()` or `p.windows` to handle Windows backslashes (`\`) safely.
3. **Registry Access**: Use `package:win32` for Windows Registry operations (e.g., `HKCU\Software\...`). Always catch COM/Win32 errors and close open registry handles.
4. **Local Database Locking**: SQLite and Isar lock their database files on disk. Do not spawn child processes or external tools that attempt to open the same database file while the Flutter app holds an active exclusive write lock.
