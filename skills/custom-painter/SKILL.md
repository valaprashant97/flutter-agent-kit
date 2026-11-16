---
name: custom-painter
description: Implement high-performance 2D drawing, charting, geometric shapes, and canvas effects using CustomPainter and CustomPaint.
---

# custom-painter

## 1. Skill Name
`custom-painter`

## 2. Purpose
Guides agents in building performant, responsive, and accessible 2D custom canvas graphics using `CustomPainter`. Enforces strict repaint boundary isolation, accurate `shouldRepaint` comparisons, zero offscreen GPU passes, and screen reader semantic labeling.

## 3. When to Use
- When drawing data visualizations, sparklines, line/bar charts, gauges, and circular progress indicators.
- When creating custom shapes, clipped card borders, dashed borders, or decorative wave dividers.
- When building interactive signature pads, canvas touch drawing, or radar sweep indicators.

## 4. When Not to Use
- When standard widget composition (`Container`, `Row`, `Column`, `Stack`) suffices.
- For complex static iconography (use vector SVG or IconData instead).

## 5. Required Project Context
- Design specifications (dimensions, colors, stroke widths, corner radii, coordinate math).
- Performance targets and repaint frequency (static vs 60/120 FPS continuous animation).

## 6. Step-by-Step Workflow
1. **Define Painter Class**: Create a class extending `CustomPainter`.
2. **Implement `paint(Canvas canvas, Size size)`**:
   - Translate coordinates relative to `size.width` and `size.height`.
   - Configure `Paint` style (`PaintingStyle.stroke` vs `PaintingStyle.fill`).
   - Draw primitive paths, arcs, lines, or rects.
3. **Implement `shouldRepaint`**:
   - Compare all configurable fields against `oldDelegate`. Never return hardcoded `true`.
4. **Wrap in RepaintBoundary**: Embed inside `RepaintBoundary(child: CustomPaint(painter: ..., size: ...))`.
5. **Add Accessibility Semantics**: Wrap with `Semantics(label: ..., value: ...)` so assistive tech can read canvas data.

## 7. Engineering Rules
- **Precise Invalidation Rule**: `shouldRepaint` must compare every visual property. Returning `true` unconditionally is prohibited.
- **SaveLayer Restriction**: Do not call `canvas.saveLayer()` unless strictly needed for alpha compositing; use `canvas.save()` and `canvas.restore()` for transforms.
- **Allocation Rule**: Do not allocate large memory buffers or re-parse data inside `paint()`. Pre-process data before passing it to the painter.

## 8. Code Examples
```dart
// Accessible Interactive Custom Gauge
Widget buildGauge(BuildContext context, double percentage) {
  return Semantics(
    label: 'Completion Gauge',
    value: '${(percentage * 100).toInt()}%',
    child: RepaintBoundary(
      child: CustomPaint(
        size: const Size(200, 200),
        painter: ProgressRingPainter(
          progress: percentage,
          trackColor: Colors.grey.shade300,
          progressColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    ),
  );
}
```

## 9. Common Mistakes
- Hardcoding absolute pixel dimensions instead of using the provided `size` parameter.
- Returning `true` in `shouldRepaint` causing continuous CPU/GPU redraws on static screens.
- Forgetting to multiply radii by `size.width` or `size.height`, resulting in clipped drawing on different screen densities.

## 10. Testing and Verification
- Write golden widget tests to verify pixel-accurate canvas rendering across standard resolutions:
  ```dart
  testWidgets('Gauge paints correctly at 50%', (tester) async {
    await tester.pumpWidget(MaterialApp(home: buildGauge(context, 0.5)));
    await expectLater(find.byType(CustomPaint), matchesGoldenFile('gauge_50.png'));
  });
  ```

## 11. Completion Criteria
- Canvas draws correctly across varying widget sizes.
- `shouldRepaint` returns false when parameters are unchanged.
- Graphic is wrapped in `RepaintBoundary` and labeled with `Semantics`.

## 12. Related Skills
- `animations`
- `ui-implementation`
- `design-system`
- `performance`
