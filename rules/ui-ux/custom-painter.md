# CustomPainter Engineering & Performance Rules

This guide outlines production rules for implementing high-performance 2D drawing, charting, and custom visual effects using Flutter's `CustomPaint` and `CustomPainter`.

---

## 1. When to Use CustomPainter
- **Recommended For**:
  - Custom charting, sparklines, progress rings, dials, and gauges.
  - Non-standard geometric borders, curved tabs, and ticket cutouts.
  - High-performance 2D particle simulations and audio visualizers.
- **Not Recommended For**:
  - Standard layouts achievable using standard Flutter widgets (`Row`, `Column`, `Stack`, `Container`).
  - Complex vector icons better served by SVG files via `flutter_svg`.

---

## 2. Production CustomPainter Implementation Pattern

```dart
import 'package:flutter/material.dart';

class ProgressRingPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  ProgressRingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    this.strokeWidth = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track Paint
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    // Progress Arc Paint
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2, // Start at 12 o'clock
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
```

---

## 3. High-Performance Canvas Invariants

1. **Precise `shouldRepaint` Logic**:
   - **NEVER return `true` unconditionally**: Returning `true` causes the canvas to redraw on every parent rebuild even when data is static.
   - Compare all drawing parameters field-by-field.
2. **Isolate with `RepaintBoundary`**:
   - Always wrap `CustomPaint` in `RepaintBoundary` when its drawing changes frequently (e.g. animated graphs or audio waves), preventing sibling/parent widgets from repainting.
3. **Avoid `canvas.saveLayer()`**:
   - `canvas.saveLayer()` forces an offscreen render pass on the GPU and can drop frame rates significantly. Use `save()` and `restore()` for canvas matrix transforms, and only use `saveLayer()` when alpha compositing or complex clipping is mandatory.
4. **Avoid Heavy Allocations in `paint()`**:
   - Avoid creating new complex `Path` objects inside `paint()` on every frame. If drawing static geometries, precompute paths and cache them in the painter instance.
5. **Implement Semantics for Accessibility**:
   - Canvas graphics are invisible to screen readers by default. Always provide accessibility labels by wrapping in a `Semantics` widget or overriding `semanticsBuilder`.
