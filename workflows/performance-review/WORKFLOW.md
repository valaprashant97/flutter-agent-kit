# Workflow: Performance Profiling & Optimization

This workflow guides profiling and resolving UI jank, memory leaks, and frame drops.

---

## 1. Entry Conditions
- User reports sluggish UI, frame drops during scrolling, or high RAM consumption.
- Pre-launch performance benchmark.

---

## 2. Step-by-Step Procedure

### Phase 1: Frame Rendering Benchmark
1. Run application in profile mode on target platform:
   ```bash
   flutter run --profile -d windows
   ```
2. Open Flutter DevTools Performance view.
3. Record a trace while performing critical user flows (e.g., fast scrolling a 1,000-item list).

### Phase 2: Bottleneck Diagnosis
- **UI Thread Bottleneck (>16ms)**:
  - Heavy parsing or sorting occurring in widget `build()`.
  - Unnecessary parent widget rebuilds.
- **Raster Thread Bottleneck (>16ms)**:
  - Un-cached high-resolution images.
  - Excessive `BackdropFilter` or `saveLayer` calls from `Opacity`.

### Phase 3: Targeted Remediation
1. **Rebuilds**: Add `BlocSelector`, `select()`, or wrap widgets in `ValueListenableBuilder`.
2. **Repaints**: Wrap animations in `RepaintBoundary`.
3. **Images**: Add `cacheWidth: 200` to downscale bitmaps in memory.
4. **Heavy Work**: Move CPU-bound JSON parsing to `Isolate.run()`.

### Phase 4: Verification Trace
1. Re-run the DevTools performance profile on the optimized code.
2. Confirm frame times consistently remain within the 16.6ms budget.

---

## 3. Exit Criteria
- App maintains smooth 60 FPS (or 120 FPS) without visible jank.
- Zero memory leaks detected across screen push/pop cycles.
