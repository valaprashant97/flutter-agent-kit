# Performance Optimization & Profiling Prompt

You are acting as a Principal Performance Engineer specializing in Flutter frame rendering, memory hygiene, and 60/120 FPS optimization guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application / Screen**: [APP NAME & TARGET SCREEN PATH]
- **Target Frame Rate**: 60 FPS (standard) / 120 FPS (ProMotion / high-refresh displays)
- **Guidelines Reference**: `skills/performance/`, `rules/performance/`

---

## 2. OBJECTIVE
Profile and eliminate UI and Raster thread bottlenecks, resolve frame drops (jank), eliminate memory leaks, minimize unnecessary widget rebuilds, optimize image GPU memory, and offload heavy computation to worker isolates.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE OBSERVED PERFORMANCE ISSUES: DROPPED FRAMES, LAGGY SCROLLING, HIGH RAM CONSUMPTION, OOM CRASHES]

---

## 4. REQUIRED INVESTIGATION
1. Profile DevTools timeline to identify whether bottlenecks reside on the UI Thread (Dart build/layout) or Raster Thread (GPU compositing/shaders).
2. Trace widget rebuild count using `debugProfileBuildsEnabled = true`.
3. Audit `Image` assets for unbounded in-memory bitmap decoding.
4. Check stateful controllers for missing `dispose()` cleanup.

---

## 5. CONSTRAINTS
- Zero premature micro-optimizations: Target only proven frame rendering bottlenecks.
- Never perform heavy data transformations, sorting, or file I/O inside widget `build()` methods.
- Animate `Transform` and `Opacity` rather than layout dimensions (`width`, `height`, `padding`).
- All background isolates must use `Isolate.run()` for short-to-medium tasks.

---

## 6. ACCEPTANCE CRITERIA
- [ ] Widget rebuilds restricted to only elements displaying changed data using scoped selectors.
- [ ] Animated subtrees isolated using `RepaintBoundary`.
- [ ] Image assets constrained with `cacheWidth` and `cacheHeight`.
- [ ] Heavy CPU tasks offloaded to `Isolate.run()`.
- [ ] All disposable resources verified for clean disposal.
- [ ] Passes `flutter analyze` with 0 warnings.

---

## 7. EDGE CASES
- Rapid high-frequency stream events flooding the UI (throttling/debouncing required).
- Large 10,000+ item collections rendered in virtualized builders without memory bloat.
- Memory consumption during low-memory OS pressure events.
- Impeller shader compilation vs legacy Skia warmup.

---

## 8. TESTING REQUIREMENTS
- Performance profiling trace verifying frame render times $\le 16.6$ms (60Hz) or $\le 8.3$ms (120Hz).
- Memory leak test verifying that popping the screen deallocates the controller and listeners.

---

## 9. EXPECTED OUTPUT
1. Diagnostic breakdown of identified performance bottlenecks.
2. Surgical optimization code modifications.
3. Verification results and before/after frame timing metrics.
