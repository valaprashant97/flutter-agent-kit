---
name: animations
description: Design, implement, and optimize 60/120fps implicit, explicit, staggered, and physics-based animations in Flutter.
---

# animations

## 1. Skill Name
`animations`

## 2. Purpose
Guides agents in building performant, visually fluid animations in Flutter. Enforces separation between implicit and explicit controllers, minimizes paint/layout invalidation passes, prevents memory leaks, and leverages Impeller compositing optimizations.

## 3. When to Use
- When implementing UI transitions, micro-interactions, page route transitions, or hero flights.
- When creating loading skeleton shimmers, pulsers, accordion expand/collapses, or bottom sheet gestures.
- When optimizing janky animations or fixing frames dropping below 60/120 FPS.

## 4. When Not to Use
- For simple static state switches where standard theme animations or basic widget swaps are sufficient.
- For high-frequency game engine graphics (use Flame or raw shaders instead).

## 5. Required Project Context
- Target platform (mobile, web, desktop) and frame rate targets (60Hz / 120Hz ProMotion).
- UI/UX specs or design mockups specifying duration, curve, and trigger conditions.

## 6. Step-by-Step Workflow
1. **Determine Animation Type**:
   - If one-shot transition based on state change: Select implicit animation (`AnimatedContainer`, `TweenAnimationBuilder`).
   - If looping, scrubbing, reversing, or multi-property coordinated: Select explicit animation (`AnimationController` + `CurvedAnimation`).
2. **Setup Controller & Ticker**: In a `StatefulWidget`, mix in `SingleTickerProviderStateMixin` and initialize `AnimationController` with explicit duration.
3. **Define Curves & Tweens**: Use appropriate easing curves (`Curves.easeInOutCubic`, `Curves.fastOutSlowIn`).
4. **Wrap in RepaintBoundary**: Isolate the animating subtree to prevent parent re-renders.
5. **Enforce Disposal**: Clean up `_controller.dispose()` in `dispose()`.
6. **Verify Performance**: Profile with Flutter DevTools Performance overlay to verify 0 dropped frames.

## 7. Engineering Rules
- **Layout Invalidation Rule**: Never animate `width`, `height`, `margin`, or `padding` when `Transform.scale` or `Transform.translate` can achieve the effect.
- **Disposal Invariant**: Every `AnimationController` must be disposed. Never let a controller run indefinitely in an unmounted widget.
- **No Global setState**: Never add a listener to an `AnimationController` that calls unconditional `setState()` on the parent widget. Use scoped `AnimatedBuilder` or `Transition` widgets.

## 8. Code Examples
```dart
// Staggered Animation with Intervals
class StaggeredCard extends StatelessWidget {
  final Animation<double> controller;
  late final Animation<double> opacity;
  late final Animation<Offset> slide;

  StaggeredCard({super.key, required this.controller}) {
    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    slide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slide,
      child: FadeTransition(
        opacity: opacity,
        child: const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('Staggered'))),
      ),
    );
  }
}
```

## 9. Common Mistakes
- Omitting `super.dispose()` or forgetting `_controller.dispose()`.
- Animating layout dimensions causing constant layout reflows across sibling widgets.
- Using `Curves.bounceOut` on large containers causing motion sickness or visual artifacts.

## 10. Testing and Verification
- Write widget tests using `WidgetTester`:
  - Call `await tester.pump()` to advance animation frames incrementally.
  - Call `await tester.pumpAndSettle()` to verify final animation landing state.
- Test that controllers are properly disposed and do not leak tickers.

## 11. Completion Criteria
- Animation runs at consistent 60/120 FPS without frame drops.
- Animating widgets are isolated using `RepaintBoundary`.
- All `AnimationController` instances are strictly disposed in `dispose()`.

## 12. Related Skills
- `ui-implementation`
- `custom-painter`
- `design-system`
- `performance`
