# Linux Platform Rules & Invariants

These rules govern Flutter development on Linux Desktop (GTK+).

---

## 1. Native Build Dependencies
Linux desktop Flutter applications compile to native C/C++ binaries using CMake and GTK 3:
- Build tools required on the host: `clang`, `cmake`, `ninja-build`, `pkg-config`, `libgtk-3-dev`, `liblzma-dev`.
- Verify compilation with: `flutter build linux --release`.

---

## 2. Desktop Integration
1. **Desktop Entry (`.desktop`)**: Ship a properly formatted `.desktop` file in `data/` specifying Categories, Icon, Exec name, and StartupNotify.
2. **Path Standards (XDG)**:
   - Config directory: `~/.config/<app_name>`
   - Data directory: `~/.local/share/<app_name>`
   - Cache directory: `~/.cache/<app_name>`
   - Use `path_provider` to ensure strict compliance with FreeDesktop XDG Base Directory specifications.
