---
name: desktop-development
description: Desktop application ergonomics, keyboard navigation, shortcuts, window boundaries, and menus across Windows, macOS, and Linux.
---

# desktop-development

## 1. Skill Name
`desktop-development`

## 2. Purpose
Provides production standards for desktop Flutter applications on Windows, macOS, and Linux: window sizing/positioning, minimum window dimensions, keyboard shortcuts (`Shortcuts` & `Actions`), desktop menu bars, mouse hover interactions, and context menus.

## 3. When to Use
- When developing or adapting a Flutter application for desktop platforms (Windows, macOS, Linux).
- When implementing desktop-standard keyboard shortcuts (Ctrl+S, Ctrl+F, Escape, Tab navigation).
- When customizing desktop window geometry (resizing, titlebars, minimum boundaries).

## 4. When Not to Use
- For mobile-only Flutter projects with no desktop targets.

## 5. Required Project Context
- `pubspec.yaml` (`window_manager`)
- Platform-specific runner directories (`windows/`, `macos/`, `linux/`)

## 6. Step-by-Step Workflow
1. **Initialize Window Manager**: Set window dimensions, minimum width/height, title, and centering in `main.dart`.
2. **Implement Keyboard Shortcuts**: Wrap views in `Shortcuts` and `Actions` with logical keyboard keys.
3. **Handle Mouse Hover Feedback**: Ensure all interactive cards and list items react to cursor hover with `MouseRegion` and `SystemMouseCursors.click`.
4. **Implement Context Menus**: Provide right-click context menus (`showMenu` or `ContextMenuRegion`) on data tables, list items, and cards.
5. **Configure Menu Bar**: Add `PlatformMenuBar` for native macOS menu bars and desktop accelerators.

## 7. Engineering Rules
- **Minimum Window Constraints**: Always enforce a minimum window size (e.g., 800x600) via `window_manager` to prevent the UI from collapsing into an unreadable state.
- **Platform-Aware Keys**: Use `LogicalKeyboardKey.control` on Windows/Linux, and `LogicalKeyboardKey.meta` on macOS.
- **Titlebar Drag Areas**: If using a custom borderless titlebar (`TitleBarStyle.hidden`), provide a dedicated draggable area using `DragToMoveArea` and standard minimize/maximize/close buttons.

## 8. Code Examples
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Keyboard Shortcut Intents
class SaveIntent extends Intent {
  const SaveIntent();
}

class DesktopFormScaffold extends StatelessWidget {
  final Widget child;
  final VoidCallback onSave;

  const DesktopFormScaffold({
    required this.child,
    required this.onSave,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS): const SaveIntent(),
        LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyS): const SaveIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          SaveIntent: CallbackAction<SaveIntent>(onInvoke: (_) {
            onSave();
            return null;
          }),
        },
        child: Focus(
          autofocus: true,
          child: child,
        ),
      ),
    );
  }
}
```

## 9. Common Mistakes
- Leaving the window unbounded, allowing the user to resize it to 50x50 pixels and crash layout rendering.
- Forgetting that desktop users expect keyboard navigation (`Tab` between input fields, `Enter` to submit forms, `Esc` to dismiss dialogs).
- Displaying mobile-style pull-to-refresh spinners on desktop where mouse users expect an explicit refresh button.

## 10. Testing and Verification
- Verify that pressing `Ctrl+S` (or `Cmd+S`) triggers the save action.
- Verify mouse hover states on desktop platforms.
- Verify minimum window boundaries prevent excessive shrinking.

## 11. Completion Criteria
- Window manager initialized with sane bounds.
- Standard desktop keyboard shortcuts functional.
- Hover states and mouse cursors operational.

## 12. Related Skills
- `windows-development`
- `responsive-design`
- `ui-implementation`
