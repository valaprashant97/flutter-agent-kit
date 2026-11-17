# Workflow: Performance Profiling & Optimization (Quick Fix)

This workflow provides a rapid, targeted procedure for isolating and resolving localized UI jank, dropped frames, and memory spikes in specific Flutter screens or interactions.

> [!NOTE]
> This workflow is designed for **quick, targeted profiling and immediate bottleneck remediation**. For comprehensive algorithmic complexity analysis ($O(n)$ auditing, collection indexing, and isolate concurrency architecture), use [`workflows/performance-audit/WORKFLOW.md`](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/workflows/performance-audit/WORKFLOW.md).

---

## 1. Entry Conditions

- The user reports a specific UI performance defect (laggy scrolling, frame stutter during animations, slow screen transition).
- A specific widget, list, or interaction has been identified as a suspected bottleneck.
- Pre-launch sanity check on a newly implemented feature to verify 60 FPS / 120 FPS compliance.

---

## 2. Step-by-Step Procedure

### Phase 1: Frame Rendering Benchmark
1. Launch the application in profile mode on the target platform (never debug mode):
   ```bash
   flutter run --profile -d windows
   ```
2. Open Flutter DevTools in your browser and navigate to the **Performance** view.
3. Start a recording session and perform the target interaction (e.g., rapid scrolling, navigating between tabs, triggering dialog animations).
4. Stop recording and inspect the frame rendering chart for red/amber spikes exceeding the 16.6ms (60 FPS) or 8.3ms (120 FPS) threshold.

### Phase 2: Bottleneck Thread Diagnosis
- **UI Thread Bottleneck (Dart Execution > 16ms)**:
  - Complex computations, sorting, filtering, or JSON decoding executed inside widget `build()` methods.
  - Large widget subtree rebuilds caused by non-granular state listening (`watch` instead of `select`).
  - Missing `const` constructors on static subtrees forcing element tree re-allocation.
- **Raster Thread Bottleneck (GPU Drawing > 16ms)**:
  - High-resolution camera or network images loaded without `cacheWidth` / `cacheHeight` constraints.
  - Excessive offscreen rendering caused by multiple overlapping `Opacity`, `BackdropFilter`, or `ShaderMask` widgets.
  - Rapidly animating widgets lacking a `RepaintBoundary`.

### Phase 3: Targeted Remediation
1. **Narrow Rebuild Scope**:
   - Replace broad watchers with targeted selectors: `context.select()`, `BlocSelector`, or `ValueListenableBuilder`.
   - Wrap dynamic list items in localized state consumers so changes rebuild only the affected row.
2. **Isolate Repainting**:
   - Wrap animated widgets (e.g., spinners, charts, progress bars) in `RepaintBoundary` to prevent canvas repainting of static ancestors.
3. **Constrain Image Decodes**:
   - Add explicit bitmap downscaling:
     ```dart
     Image.network(
       imageUrl,
       cacheWidth: (displayWidth * MediaQuery.devicePixelRatioOf(context)).round(),
     );
     ```
4. **Move Heavy Compute Off Main Thread**:
   - For CPU-bound tasks taking $> 8\,\text{ms}$, wrap in `Isolate.run()` to keep the UI isolate unblocked.

### Phase 4: Verification & Regression Profiling
1. Re-run DevTools Performance profiler on the updated code in profile mode.
2. Confirm frame times consistently remain below the 16.6ms / 8.3ms budget during the previously laggy interaction.
3. Verify static analysis passes cleanly:
   ```bash
   flutter analyze
   ```

---

## 3. Exit Criteria

- [ ] Target screen or interaction maintains smooth 60 FPS (or 120 FPS) without visible dropped frames.
- [ ] DevTools frame rendering times consistently stay within the 16.6ms / 8.3ms budget.
- [ ] Excessive widget rebuilds are eliminated through granular selectors or `const` constructors.
- [ ] No unconstrained image decodes or memory leaks occur during screen lifecycle cycles.
- [ ] Code passes `flutter analyze` with 0 errors and 0 warnings.
