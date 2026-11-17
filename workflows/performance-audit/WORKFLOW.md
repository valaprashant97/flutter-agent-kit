# Workflow: Performance & Algorithmic Efficiency Audit

This workflow guides AI coding agents through a disciplined, evidence-based performance audit of Dart and Flutter applications. It systematically uncovers algorithmic bottlenecks, memory leaks, excessive widget rebuilds, and isolate concurrency issues without breaking existing functionality or prematurely optimizing non-critical paths.

---

## 1. Entry Conditions

- The user requests a performance review, algorithmic efficiency audit, frame jank investigation, or memory leak analysis.
- The application exhibits sluggish scrolling, frame drops, high battery drain, or memory warnings.
- Preparing for a production release where frame budgets ($60\,\text{FPS}$ / $120\,\text{FPS}$) and resource consumption must be certified.

---

## 2. Step-by-Step Procedure

### Phase 1: Architecture & Workload Discovery
1. **Inspect Existing Architecture**:
   - Identify state management approach (BLoC, Riverpod, Provider, GetX, ValueNotifier).
   - Identify data persistence layers (Drift, Isar, Hive, SharedPreferences).
   - Identify networking libraries (Dio, Http) and serialization protocols.
2. **Identify Critical Workload Paths**:
   - List high-frequency loops, heavy data transformations, list rendering views, and real-time streams.
   - Characterize input size scales ($n \le 100$, $n \sim 10^3$, $n \ge 10^5$).
   - Determine target platforms (Mobile, Windows Desktop, Web) and hardware constraints.

### Phase 2: Algorithmic & Memory Profiling
1. **Analyze Algorithmic Complexity**:
   - Search for nested loops ($O(n^2)$) performing linear lookups (`firstWhere`, `contains`) on collections.
   - Identify string concatenation (`+=`) inside loops and verify `StringBuffer` usage.
   - Scan for multi-stage eager collections (`.where().toList().map().toList()`) that can be replaced with single-pass lazy `Iterable` evaluations.
2. **Inspect Memory Allocations & Leaks**:
   - Check all `StatefulWidget` and controller classes for missing `dispose()` calls on:
     - `TextEditingController`, `AnimationController`, `ScrollController`, `FocusNode`.
     - `StreamSubscription` instances and `Timer` objects.
   - Audit network and asset images: verify that high-resolution images use `cacheWidth` and `cacheHeight` scaled to the device pixel ratio.
   - Check in-memory caches for unbounded growth without eviction or TTL policies.

### Phase 3: Widget Rebuild & Rendering Inspection
1. **Audit Widget Build Methods**:
   - Verify that all `build()` methods are pure: no I/O, no sorting, no parsing, and no heavy arithmetic.
   - Verify that `const` constructors are utilized across static subtrees.
2. **Inspect Rebuild Scopes**:
   - Identify broad state subscriptions (e.g., listening to entire models instead of specific properties).
   - Recommend granular selectors (`context.select`, `BlocSelector`, `Selector`, `ValueListenableBuilder`).
3. **Verify Viewport Lazy Rendering**:
   - Confirm that dynamic, unbounded, or long lists ($n > 20$) use `ListView.builder`, `GridView.builder`, or `SliverList`.
   - Confirm that small static lists ($n \le 10$) avoid unnecessary builder overhead.
   - Inspect layout hierarchy to eliminate nested `IntrinsicHeight` or `IntrinsicWidth` passes.

### Phase 4: Concurrency, Network & Database Audit
1. **Heavy Computation Offloading**:
   - Identify synchronous CPU-bound operations exceeding $8\,\text{ms}$ on the main isolate (e.g., parsing $> 100\,\text{KB}$ JSON, image filtering, hashing).
   - Verify whether moving work to `Isolate.run()` or `compute()` is justified by comparing compute time against isolate message-passing overhead.
2. **Database & Network Efficiency**:
   - Audit database queries for missing indexes on foreign keys and filter columns.
   - Check for N+1 query patterns; replace with batch queries or SQL joins.
   - Verify pagination / limit-offset on large datasets.
   - Check for HTTP connection pooling and request deduplication.

### Phase 5: Proposal, Benchmarking & Verification
1. **Generate Performance Audit Report**:
   - Document findings classified by severity (**Critical Bottleneck**, **Optimization Opportunity**, **Informational**).
   - Include the standard **Performance Analysis** block for each affected routine:
     ```markdown
     **Performance Analysis**
     - Time Complexity: O(...)
     - Auxiliary Space Complexity: O(...)
     - Main performance considerations: ...
     - Potential bottlenecks: ...
     ```
2. **Obtain Approval Before Refactoring**:
   - Present the prioritized recommendations to the user before making non-trivial code modifications.
3. **Implement Approved Optimizations Surgically**:
   - Apply minimal, targeted diffs.
   - Never compromise code readability or correctness for negligible micro-optimizations.
4. **Execute Verification & Regression Tests**:
   - Run `flutter analyze` to guarantee 0 errors and 0 warnings.
   - Run `flutter test` to ensure zero regression in business logic.
   - Record before-and-after measurements where DevTools profiling traces are available.

---

## 3. Exit Criteria

- [ ] All algorithmic routines have verified and documented Time and Auxiliary Space complexities.
- [ ] No un-indexed nested loops operate on unbounded inputs.
- [ ] Widget `build()` methods are pure and free of I/O, sorting, and heavy calculations.
- [ ] All owned controllers, subscriptions, and timers have explicit disposal logic.
- [ ] High-resolution images are constrained with appropriate cache dimensions.
- [ ] Heavy CPU-bound tasks are offloaded to isolates when payload size justifies it.
- [ ] All automated tests pass (`flutter test`), and static analysis is clean (`flutter analyze`).
