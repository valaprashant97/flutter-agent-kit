---
name: performance-engineering
description: Algorithmic efficiency, Big-O computational complexity analysis, data structure optimization, memory lifecycle management, and isolate concurrency.
---

# performance-engineering

## 1. Skill Name
`performance-engineering`

## 2. Purpose
Provides end-to-end algorithmic performance engineering, Big-O computational complexity optimization ($O(1)$ lookups, `StringBuffer`, lazy evaluations), memory leak prevention, granular state rebuild scoping, and concurrency management for Flutter and Dart applications. (For runtime DevTools frame profiling and raster jank elimination, use `performance`).

## 3. When to Use
- When writing algorithmic routines, search algorithms, data transformations, or collection lookups.
- When investigating frame drops (jank), high CPU utilization, or slow scrolling in Flutter lists/grids.
- When diagnosing excessive memory usage, heap fragmentation, or Out-Of-Memory (OOM) crashes.
- When auditing widget rebuild trees, state subscription scopes, or image caching behavior.
- When performing heavy computations (JSON parsing, cryptography, sorting) that risk blocking the main UI isolate.
- When conducting code reviews to provide Big-O time and auxiliary space complexity analysis.

## 4. When Not to Use
- Prematurely micro-optimizing small, bounded collections ($n \le 50$) or static screens where readable, simple code already renders in under $1\,\text{ms}$.
- Refactoring state management architectures solely for performance without empirical profiling proof.
- Moving trivial tasks ($< 1\,\text{ms}$) into worker isolates where isolate spawning and message copying overhead exceed computation cost.
- When diagnosing active UI frame jank or GPU shader compilation bottlenecks via DevTools (use `performance` instead).

## 5. Required Project Context
- Target Dart functions or Flutter widget source files.
- Input size characteristics ($n$ scale, boundedness, frequency of execution).
- Relevant profiling traces from Flutter DevTools (Timeline, CPU Profiler, Memory View) if diagnosing an active bottleneck.
- Existing state management and dependency injection architecture.

## 6. Step-by-Step Workflow
1. **Understand Before Optimizing**:
   - Verify correctness and test coverage before altering any implementation.
   - Characterize the input size $n$ and execution context (UI thread vs. background service).
2. **Algorithmic & Data Structure Analysis**:
   - Calculate Time Complexity $O(f(n))$ and Auxiliary Space Complexity $O(g(n))$.
   - Replace linear scans ($O(n)$) in loops with Map or Set lookups ($O(1)$) where lookups are repeated.
   - Replace string concatenation in loops with `StringBuffer` ($O(n)$ instead of $O(n^2)$).
   - Convert intermediate eager `.toList()` chains into single-pass lazy `Iterable` evaluations.
3. **Flutter Widget Tree & Rebuild Scoping**:
   - Ensure widget `build()` methods are pure functions with zero I/O, sorting, or heavy math.
   - Apply `const` constructors to all static subtrees.
   - Wrap unbounded or dynamic collections in `ListView.builder`, `GridView.builder`, or `SliverList`.
   - Isolate volatile state subscriptions using granular selectors (`select()`, `BlocSelector`, `ValueListenableBuilder`).
4. **Memory Management & Resource Lifecycles**:
   - Ensure all owned controllers (`TextEditingController`, `AnimationController`, `ScrollController`), focus nodes, stream subscriptions, and timers are disposed in `State.dispose()`.
   - Constrain decoded image memory using `cacheWidth = (displayWidth * devicePixelRatio).round()`.
5. **Concurrency & Isolate Offloading**:
   - Measure if CPU-bound tasks block the UI isolate for $> 8\,\text{ms}$.
   - If payload and computation justify it, offload to `Isolate.run()` or worker isolates.
6. **Profiling & Verification**:
   - Run verification in profile mode: `flutter run --profile`.
   - Confirm frame times remain within the $16.6\,\text{ms}$ (60 FPS) or $8.3\,\text{ms}$ (120 FPS) budget.
   - Run unit and regression tests to guarantee zero behavioral regressions.

## 7. Engineering Rules
- **Priority Rule**: $\text{Correctness} > \text{Reliability} > \text{Maintainability} > \text{Measured Performance} > \text{Premature Optimization}$.
- **Pure Build Rule**: Never perform sorting, filtering, JSON parsing, disk I/O, or network requests inside Flutter `build()` methods.
- **Explicit Big-O Annotation**: Every meaningful algorithmic routine must state its Time and Auxiliary Space complexity in documentation or review output.
- **Resource Disposal Invariant**: Every instantiated controller, timer, or subscription must have an explicit disposal path.
- **Profile-Driven Proof**: Never claim performance improvements or 60/120 FPS rates without empirical profiling evidence.

## 8. Code Examples

### Algorithmic Optimization: Pre-Indexing Lookup
```dart
// Pre-indexing an O(n * m) nested search into O(n + m) with a Map
class OrderAggregator {
  static List<OrderSummary> aggregate(
    List<Order> orders,
    List<Customer> customers,
  ) {
    // Auxiliary Space: O(m) to index customers by ID
    final customerLookup = {for (final c in customers) c.id: c};

    // Time Complexity: O(n) pass over orders with O(1) lookups
    return orders.map((order) {
      final customer = customerLookup[order.customerId];
      return OrderSummary(
        orderId: order.id,
        customerName: customer?.name ?? 'Unknown',
        total: order.amount,
      );
    }).toList();
  }
}
```

### Flutter Rebuild Scoping: Granular Selector
```dart
// Restricting rebuild scope to a single field using context.select
class UserHeaderView extends StatelessWidget {
  const UserHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    // Only rebuilds when userName changes, ignoring other user state updates
    final userName = context.select<UserCubit, String>(
      (cubit) => cubit.state.userName,
    );

    return Row(
      children: [
        const CircleAvatar(child: Icon(Icons.person)), // Const subtree
        const SizedBox(width: 12),
        Text(userName, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
```

## 9. Common Mistakes
- **Premature Micro-Optimization**: Replacing readable straightforward code with complex bit-shifting or manual pooling when $n < 50$.
- **Confusing Total Memory with Auxiliary Space**: Reporting input storage as algorithmic space complexity rather than measuring temporary auxiliary allocations.
- **Unconstrained Image Bitmaps**: Displaying camera photos without `cacheWidth`/`cacheHeight`, consuming 50MB+ per image in uncompressed GPU memory.
- **Blind Builder Usage**: Replacing a 3-item static `Column` with `ListView.builder`, adding unnecessary builder overhead.
- **Unmeasured Isolate Spawning**: Spawning an isolate to parse a 2KB JSON response, where serialization overhead takes 5x longer than synchronous parsing.

## 10. Testing and Verification
- **Static Analysis**: Run `flutter analyze` to ensure 0 errors and 0 warnings.
- **Unit & Regression Testing**: Run `flutter test` to verify algorithmic correctness across edge cases (empty collections, large inputs, boundary conditions).
- **Profile Mode Tracing**: Execute `flutter run --profile` with Flutter DevTools to inspect frame budgets, rebuild counts, and memory allocations.

## 11. Completion Criteria
- Implementation satisfies all algorithmic correctness tests.
- Rebuild scopes are localized and build methods remain pure.
- All allocated controllers and subscriptions are disposed.
- Complexity analysis block is provided for generated code.
- Verification executed with clean test output.

## 12. Related Skills
- `performance` (Runtime DevTools profiling, 60/120 FPS frame budget enforcement, and raster jank elimination)
- `dart-best-practices`
- `flutter-architecture`
- `ui-implementation`
- `debugging`
- `testing`
