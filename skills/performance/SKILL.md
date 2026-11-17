---
name: performance
description: Runtime performance profiling, DevTools tracing, 60/120 FPS jank elimination, raster/UI thread diagnosis, and widget rebuild optimization.
---

# performance

## 1. Skill Name
`performance`

## 2. Purpose
Provides runtime profiling and UI rendering optimization workflows for Flutter applications. Eliminates UI thread and GPU raster jank, identifies memory leaks, prevents unnecessary widget rebuilds, optimizes image caching, and profiles rendering pipelines using Flutter DevTools. (For algorithmic Big-O complexity analysis, collection pre-indexing, and data structure efficiency, use `performance-engineering`).

## 3. When to Use
- When users report UI lag, dropped frames, or slow scrolling.
- When an app consumes excessive RAM or experiences out-of-memory (OOM) crashes.
- Prior to production releases to ensure smooth 60 FPS / 120 FPS performance across target devices.
- When needing runtime DevTools timeline or CPU profiling to measure frame rendering times.

## 4. When Not to Use
- Prematurely optimizing simple, static screens that already render in under 2ms.
- When optimizing algorithmic computational complexity or mathematical data transformations (use `performance-engineering` instead).

## 5. Required Project Context
- Target screen code and state controllers
- Performance profiling trace from DevTools or reproduction scenario

## 6. Step-by-Step Workflow
1. **Profile Frame Rendering**: Identify whether frame drops occur on the **UI Thread** (Dart build/layout bottleneck) or **Raster Thread** (GPU drawing bottleneck).
2. **Audit Widget Rebuilds**: Use `debugProfileBuildsEnabled = true` or DevTools Widget Rebuild tracker to find widgets rebuilding unnecessarily.
3. **Apply Selective Subscriptions**: Replace broad state watchers with `BlocSelector`, `ref.watch(provider.select(...))`, or `context.select()`.
4. **Isolate Repaint Boundaries**: Wrap animated or rapidly updating widgets in `RepaintBoundary`.
5. **Optimize Image Assets**: Add `cacheWidth` and `cacheHeight` constraints to downscale image bitmaps in memory.
6. **Move Work to Isolates**: Offload JSON parsing or heavy mathematical calculations to `Isolate.run()`.

## 7. Engineering Rules
- **Pure `build()` Functions**: Never perform sorting, parsing, network requests, or database reads inside `build()`.
- **Use Lazy List Builders**: Always use `ListView.builder` or `SliverList.builder` for unbounded or long lists.
- **Enforce Const Subtrees**: Maximize `const` constructor usage to enable element tree short-circuiting.

## 8. Code Examples
```dart
// Performance Optimization: Restricting Rebuilds with ValueListenableBuilder
class CounterDisplay extends StatelessWidget {
  final ValueNotifier<int> counterNotifier;
  const CounterDisplay({required this.counterNotifier, super.key});

  @override
  Widget build(BuildContext context) {
    // Only the Text widget rebuilds when counterNotifier updates
    return Column(
      children: [
        const Text('Current Score:'), // DOES NOT REBUILD
        ValueListenableBuilder<int>(
          valueListenable: counterNotifier,
          builder: (context, value, _) => Text(
            '$value',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}
```

## 9. Common Mistakes
- Wrapping long lists in `SingleChildScrollView(child: Column(children: ...))`, causing every item to be allocated at once.
- Decoding 4000x3000px camera photos directly into widget trees without `cacheWidth` downscaling, consuming hundreds of megabytes of RAM.
- Adding expensive `BackdropFilter` glassmorphism blurs on low-end devices.

## 10. Testing and Verification
- Profile the optimized flow using Flutter DevTools Performance view.
- Confirm frame build times remain under 16ms (60 FPS) during active list scrolling.

## 11. Completion Criteria
- Frame times consistently meet the 16ms / 8ms budget.
- Zero memory leaks detected on screen push/pop cycles.
- Static analysis clean with 0 warnings.

## 12. Related Skills
- `performance-engineering` (Algorithmic Big-O analysis, collection indexing, and isolate computation)
- `ui-implementation`
- `background-execution`
- `debugging`
