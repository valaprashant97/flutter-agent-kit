# Algorithmic Efficiency & Performance Review Prompt

Use this standardized prompt when requesting an AI coding agent to analyze, audit, and optimize algorithmic complexity, memory management, and rendering performance in Dart and Flutter code.

---

## PROJECT CONTEXT
- **Target Application**: [e.g., Flutter Mobile / Windows Desktop Application]
- **Flutter & Dart SDK**: Flutter 3.x / Dart 3.x
- **Target Scope**: [Specify target file(s), classes, or data-processing routines]
- **Hardware & Platform Focus**: [Mobile / Windows Desktop / Web / High-Refresh-Rate Displays]
- **State Management & Persistence**: [e.g., BLoC / Riverpod / Provider / Drift / Isar]

---

## OBJECTIVE
Perform a comprehensive performance engineering and algorithmic efficiency review on the target code. Identify computational bottlenecks, analyze Time and Auxiliary Space complexity, eliminate memory leaks, optimize widget rebuild scopes, and recommend prioritized, measurable optimizations.

---

## EXISTING BEHAVIOR
- Current algorithmic complexity or performance symptoms (e.g., UI frame drops during list scrolling, slow search filtering, high RAM consumption).
- Relevant profiling traces or execution timings if available.
- Current resource allocation and lifecycle management.

---

## REQUIRED INVESTIGATION
1. **Algorithmic Complexity**:
   - Identify input size $n$ and analyze worst-case and average-case Time Complexity.
   - Analyze Auxiliary Space Complexity, strictly distinguishing temporary working memory from total data storage.
   - Scan for nested loops performing linear searches or repeated calculations that can be pre-indexed into a `Map` or `Set`.
   - Inspect string operations inside loops for missing `StringBuffer` usage.
   - Check for multi-stage eager collections (`.where().toList().map().toList()`) that can be replaced with single-pass lazy `Iterable` evaluations.
2. **Memory & Resource Lifecycles**:
   - Inspect all controllers (`TextEditingController`, `AnimationController`, `ScrollController`, `FocusNode`), timers, and stream subscriptions for missing `dispose()` calls.
   - Audit image decoding dimensions for missing `cacheWidth`/`cacheHeight` constraints.
3. **Flutter Build & Rebuild Scopes**:
   - Verify that widget `build()` methods are pure functions free of I/O, sorting, or heavy math.
   - Check for broad state subscriptions that can be narrowed using granular selectors.
   - Verify that long or dynamic collections use lazy viewport rendering (`ListView.builder`, `SliverList`).
4. **Concurrency**:
   - Check whether CPU-intensive calculations (>8ms) block the main UI isolate and evaluate `Isolate.run()` offloading feasibility.

---

## CONSTRAINTS
- **Correctness First**: Never sacrifice correctness, safety, or readability for micro-optimizations that yield negligible real-world benefits.
- **No Blanket O(1) Promises**: Do not promise $O(1)$ complexity when it is unachievable.
- **Input Scale Realism**: Do not replace simple, readable algorithms with complex structures if the input size is guaranteed to be small ($n \le 50$).
- **No State Migration**: Do not propose migrating state management libraries solely for performance without empirical profiling evidence.
- **Non-Destructive Proposals**: Present audit findings and proposed diffs before applying modifications.

---

## ACCEPTANCE CRITERIA
- [ ] Every reviewed algorithmic routine includes a standardized **Performance Analysis** block (Time Complexity, Auxiliary Space Complexity, considerations, potential bottlenecks).
- [ ] High-frequency repeated lookups use $O(1)$ average time data structures (`Map`/`Set`) where input scale justifies it.
- [ ] Widget `build()` methods are verified to be pure and free of synchronous heavy work.
- [ ] All allocated resources (controllers, nodes, subscriptions, timers) have verified disposal paths.
- [ ] Viewport lists use appropriate lazy rendering for dynamic datasets.
- [ ] Proposed changes compile cleanly without errors or warnings (`flutter analyze`).

---

## EDGE CASES
- **Empty & Single-Item Collections**: Ensure optimized algorithms handle $n = 0$ and $n = 1$ without index out-of-bounds or null pointer errors.
- **Large & Unbounded Datasets**: Verify behavior when $n \ge 10^5$ (avoiding call stack overflow from deep recursion).
- **High-DPI Displays**: Factor in `devicePixelRatio` when calculating image `cacheWidth` and `cacheHeight`.
- **Rapid Navigation / Screen Disposals**: Ensure async tasks and isolates do not attempt state mutations after widget disposal (`mounted` checks).

---

## TESTING REQUIREMENTS
- Execute `flutter analyze` and confirm 0 errors and 0 warnings.
- Execute `flutter test` on all modified modules to guarantee zero behavioral regressions.
- When profiling is requested, run in profile mode (`flutter run --profile`) and record DevTools frame and memory evidence.

---

## EXPECTED OUTPUT
A structured Performance Engineering Report containing:
1. Executive summary of identified bottlenecks and algorithmic inefficiencies.
2. Formatted **Performance Analysis** blocks for each reviewed routine.
3. Minimal, surgical code modifications demonstrating the optimized implementations.
4. Concrete test verification output (`flutter analyze`, `flutter test`).
5. Trade-off documentation explaining when and why optimizations were applied.
