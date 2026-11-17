# Flutter Widget Lifecycle Rules

These rules govern the lifecycle of Flutter widgets, element trees, and state objects.

---

## 1. The StatefulWidget Lifecycle Order

A `StatefulWidget`'s `State` progresses through the following sequential lifecycle:

```mermaid
graph TD
    Create[createState()] --> Init[initState()]
    Init --> Inherited[didChangeDependencies()]
    Inherited --> Build[build()]
    
    Update[Parent Rebuild / Widget Changed] --> UpdateWidget[didUpdateWidget()]
    UpdateWidget --> Build
    
    InheritedChange[InheritedWidget Changed] --> Inherited
    
    Deact[deactivate()] --> Disp[dispose()]
```

---

## 2. Invariants for Each Lifecycle Method

### `initState()`
- Called exactly **once** when the state object is inserted into the element tree.
- **Rule**: Never access `BuildContext.dependOnInheritedWidgetOfExactType()` (e.g., `Theme.of(context)` or `MediaQuery.of(context)`) directly in `initState()`, as the widget is not fully wired into the inherited tree yet.
- **Use for**: Initializing controllers, listeners, and non-context-dependent state.
- **Always call**: `super.initState()` at the start of the method.

### `didChangeDependencies()`
- Called immediately after `initState()` and whenever an `InheritedWidget` that this state depends on changes.
- **Use for**: Context-dependent initialization (e.g., extracting inherited theme or locale data).

### `build(BuildContext context)`
- Called frequently during rendering and state changes.
- **Rule**: Must be a **pure function** of state and configuration. Never perform asynchronous operations, start HTTP requests, write to databases, sort collections, or register persistent listeners inside `build()`.
- Keep `build()` fast and lightweight to maintain 60/120 FPS. See `docs/PERFORMANCE_ENGINEERING_STANDARDS.md`.

### `didUpdateWidget(covariant T oldWidget)`
- Called when the parent widget rebuilds and passes a new widget instance with identical `runtimeType` and `key`.
- **Use for**: Comparing old properties (`oldWidget.id != widget.id`) and resetting or updating internal controllers accordingly.

### `dispose()`
- Called when the state object is permanently removed from the element tree.
- **Rule**: Must clean up every controller (`TextEditingController`, `AnimationController`, `ScrollController`, `FocusNode`), stream subscription, timer, and animation.
- **Always call**: `super.dispose()` at the end of the method.
