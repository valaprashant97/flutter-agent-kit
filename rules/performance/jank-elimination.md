# UI Jank Reduction & Frame Budget Rules

These rules establish performance standards to maintain smooth 60 FPS (16.6ms/frame) and 120 FPS (8.3ms/frame) rendering in Flutter applications.

---

## 1. The 16ms / 8ms Frame Budget

Every frame in Flutter is produced in two distinct phases:
1. **UI Thread**: Executes Dart code, builds widgets, lays out render objects, and generates draw commands.
2. **Raster (GPU) Thread**: Executes OpenGL/Vulkan/DirectX/Metal rendering commands and pushes pixels to the display.

If either thread takes longer than 16.6ms (on a 60Hz display) or 8.3ms (on a 120Hz display), a **frame drop (jank)** occurs.

---

## 2. Invariants for Eliminating UI Thread Jank

### Rule 1: Never Execute Expensive Work in `build()`
- Avoid sorting lists, parsing JSON, formatting heavy dates, or computing mathematical stats inside `build()`.
- Compute values upfront in controllers/BLoCs, or memoize expensive results.

### Rule 2: Isolate Repaints with `RepaintBoundary`
When an animated or frequently updating widget (e.g., custom clock, waveform visualizer, progress bar) is nested inside a complex screen, wrapping it in `RepaintBoundary` prevents the entire parent and sibling widgets from being repainted on every tick:
```dart
RepaintBoundary(
  child: AnimatedWaveformVisualizer(progress: progress),
)
```

### Rule 3: Use ListView.builder for Long or Infinite Lists
- **NEVER** use `SingleChildScrollView(child: Column(children: ...))` for large dynamic collections. This instantiates every child widget immediately, consuming immense RAM and freezing the UI thread.
- **ALWAYS** use `ListView.builder` or `SliverList.builder`. This builds and paints only the widgets currently visible within the viewport (plus a small cache extent).

---

## 3. Invariants for Eliminating Raster (GPU) Jank

### Rule 4: Minimize Expensive Visual Effects
- **Avoid `BackdropFilter` (Blur)**: Full-screen glassmorphism/acrylic blurs are computationally expensive on mobile and low-end desktop GPUs.
- **Avoid `SaveLayer` Calls**:
  - `Opacity` with animated children creates off-screen buffers (`saveLayer`). Use `AnimatedOpacity` or apply opacity directly to colors: `Color.fromRGBO(r, g, b, 0.5)`.
  - `ClipRRect`: Clipping path boundaries can be costly. If a card or container can achieve rounded borders with `BoxDecoration.borderRadius`, use that instead of wrapping in `ClipRRect`.
