# Flutter Animation Engineering & Performance Rules

This guide establishes production rules for designing, implementing, and optimizing 60/120fps animations in Flutter applications.

---

## 1. Animation Classification: Implicit vs. Explicit

### Implicit Animations (Preferred for Simplicity)
Use implicit animations when animating property changes between values based on state:
- `AnimatedContainer`, `AnimatedOpacity`, `AnimatedPositioned`, `AnimatedAlign`
- `TweenAnimationBuilder` for custom value transitions without manual controller management.
- **Rule**: If an animation only triggers when a widget state/prop changes and does not repeat or loop, always prefer implicit animation widgets.

### Explicit Animations (Required for Complex Control)
Use explicit animations when you need:
- Repeating, looping, or reversing transitions.
- Multi-property coordinated / staggered sequences.
- Manual play, pause, stop, or scrub control.
- Physics-based spring simulations (`SpringSimulation`).

---

## 2. Production Explicit Animation Pattern

Always use `SingleTickerProviderStateMixin` with an `AnimationController` and clean up in `dispose()`:
```dart
class PulseButton extends StatefulWidget {
  const PulseButton({super.key});

  @override
  State<PulseButton> createState() => _PulseButtonState();
}

class _PulseButtonState extends State<PulseButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Live Action'),
      ),
    );
  }
}
```

---

## 3. High-Performance Animation Invariants (60/120 FPS)

1. **Animate Transform and Opacity, Not Layout**:
   - **WRONG**: Animating `width`, `height`, `margin`, or `padding` forces the Flutter engine to recompute the entire layout tree on every frame (relayout boundary invalidation).
   - **CORRECT**: Animate `Transform.scale`, `Transform.translate`, or `Opacity`. These bypass layout passes and operate directly in the compositing phase.
2. **Isolate with `RepaintBoundary`**:
   - Wrap the animating subtree in a `RepaintBoundary` so that pixel repaints do not dirty the parent scaffold or sibling elements.
3. **Use Pre-Built Transition Widgets**:
   - Prefer built-in transitions (`FadeTransition`, `ScaleTransition`, `SlideTransition`, `RotationTransition`) over generic `AnimatedBuilder` calling `setState()`.
4. **Never call `setState()` in Animation Listeners**:
   - **WRONG**: Calling `_controller.addListener(() => setState(() {}))` causes the entire widget and its children to rebuild on every frame.
   - **CORRECT**: Use `AnimatedBuilder` scoped tightly to the animated property, or use `Transition` widgets.
5. **Hero Animations**:
   - Ensure `tag` strings are unique per item in lists.
   - For complex widgets undergoing hero flights, provide a `flightShuttleBuilder` to prevent visual jumps during route navigation.
