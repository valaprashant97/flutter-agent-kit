# Advanced Dart & Flutter Performance Engineering Standards

This document establishes the authoritative standard for algorithmic efficiency, memory management, widget build and frame rendering optimization, concurrency, and production profiling within the **Flutter Agent Kit**.

All AI coding agents (**Cursor**, **Claude Code**, **OpenAI Codex**, **Gemini CLI**, **GitHub Copilot**, **Antigravity**) must adhere to these standards when writing, refactoring, or reviewing Dart and Flutter code.

---

## 1. Core Performance Principles & Hierarchy

### The Engineering Priority Hierarchy

Whenever trade-offs arise between optimization, readability, and correctness, the agent must strictly apply:

$$\mathbf{Correctness} > \mathbf{Reliability} > \mathbf{Maintainability} > \mathbf{Measured\ Performance} > \mathbf{Premature\ Optimization}$$

1. **Never Optimize Prematurely**: Do not replace a readable, simple implementation with an intricate, fragile algorithm when the input size is small ($n \le 100$) and there is no measured bottleneck.
2. **Never Guess Bottlenecks**: Performance decisions must be grounded in algorithmic complexity analysis and empirical profiling (Flutter DevTools Timeline, CPU Profiler, and Memory views).
3. **No Blanket Claims**: Never promise $O(1)$ complexity when it is unachievable. Never claim an app achieves 60 FPS or 120 FPS without executing measurements on real target hardware in profile or release mode.
4. **Simplest Compliant Implementation**: Choose the simplest algorithmic and architectural solution that satisfies performance budgets.

---

## 2. Algorithmic Efficiency & Data Structure Selection

### Computational Complexity Invariants

When designing algorithms or data transformations:
- **Identify Input Size ($n$)**: Determine whether $n$ is bounded ($n < 50$), medium ($n \sim 10^3$), or unbounded ($n \ge 10^5$).
- **Analyze Time Complexity**: Strive for $O(1)$, $O(\log n)$, or $O(n)$. Avoid $O(n^2)$ or $O(2^n)$ on unbounded inputs.
- **Analyze Auxiliary Space Complexity**: Differentiate auxiliary space (temporary buffers, intermediate collections created by the algorithm) from total memory allocated by inputs and outputs.
- **Avoid Repeated Passes**: Combine operations (`filter`, `map`, `reduce`) where appropriate instead of creating multiple intermediate collections.

### Data Structure Selection Matrix

| Use Case | Recommended Structure | Time Complexity | Anti-Pattern |
| :--- | :--- | :--- | :--- |
| **Frequent Key Lookups** | `Map<K, V>` | $O(1)$ average | Scanning `List<T>` with `firstWhere()` ($O(n)$) |
| **Membership Testing / Deduplication** | `Set<T>` | $O(1)$ average | `list.contains(item)` in a loop ($O(n^2)$ total) |
| **Ordered Indexed Access** | `List<T>` | $O(1)$ by index | Linked structures for random access |
| **FIFO Queue / Sliding Window** | `Queue<T>` / `DoubleLinkedQueue` | $O(1)$ add/remove | `List.removeAt(0)` ($O(n)$ shift per removal) |
| **String Concatenation in Loops** | `StringBuffer` | $O(n)$ total | String `+` or interpolation in loops ($O(n^2)$) |
| **Lazy Stream / Iterable Filtering** | `Iterable<T>` | $O(1)$ per step | Multiple eager `.toList()` invocations |

### Dart Code Patterns: Algorithmic Best Practices

#### 1. Lookup Optimization: Map/Set vs. Nested List Scanning
```dart
// ANTI-PATTERN: O(n * m) nested list lookup
List<OrderDetails> matchOrders(List<Order> orders, List<User> users) {
  return orders.map((order) {
    // firstWhere scans the entire users list for every order!
    final user = users.firstWhere((u) => u.id == order.userId);
    return OrderDetails(order: order, user: user);
  }).toList();
}

// CORRECT: O(n + m) using Map index
List<OrderDetails> matchOrdersOptimized(List<Order> orders, List<User> users) {
  // Pre-index users in O(m) time and O(m) auxiliary space
  final userMap = {for (final u in users) u.id: u};
  
  // Single pass lookup in O(1) per order -> O(n) total
  return orders.map((order) {
    final user = userMap[order.userId];
    return OrderDetails(order: order, user: user);
  }).toList();
}
```

#### 2. String Construction: StringBuffer
```dart
// ANTI-PATTERN: O(n^2) string allocations
String buildCsv(List<Record> records) {
  var csv = '';
  for (final record in records) {
    csv += '${record.id},${record.name}\n'; // Allocates new string every iteration
  }
  return csv;
}

// CORRECT: O(n) using StringBuffer
String buildCsvOptimized(List<Record> records) {
  final buffer = StringBuffer();
  for (final record in records) {
    buffer
      ..write(record.id)
      ..write(',')
      ..writeln(record.name);
  }
  return buffer.toString();
}
```

#### 3. Lazy Iterable Pipelines vs. Eager Allocations
```dart
// ANTI-PATTERN: 3 intermediate Lists created in memory
final activeVipUsers = users
    .where((u) => u.isActive)
    .toList() // Allocates intermediate List
    .where((u) => u.isVip)
    .toList() // Allocates second intermediate List
    .map((u) => u.displayName)
    .toList(); // Final List

// CORRECT: Single allocation, lazy evaluation pipeline
final activeVipUsersOptimized = users
    .where((u) => u.isActive && u.isVip)
    .map((u) => u.displayName)
    .toList(); // Single allocation at terminal step
```

#### 4. Avoiding Deep Recursion
```dart
// Prefer iterative traversal over deep recursion to avoid call stack exhaustion
int calculateDeepTreeDepth(TreeNode root) {
  var maxDepth = 0;
  final queue = Queue<(TreeNode node, int depth)>()..add((root, 1));

  while (queue.isNotEmpty) {
    final (currentNode, currentDepth) = queue.removeFirst();
    if (currentDepth > maxDepth) maxDepth = currentDepth;
    for (final child in currentNode.children) {
      queue.add((child, currentDepth + 1));
    }
  }
  return maxDepth;
}
```

---

## 3. Flutter Build & Rendering Performance

Flutter targets a smooth frame budget:
- **60 Hz Displays**: $16.6\,\text{ms}$ total per frame ($8.3\,\text{ms}$ UI thread budget + $8.3\,\text{ms}$ Raster thread budget).
- **120 Hz Displays**: $8.3\,\text{ms}$ total per frame ($4.1\,\text{ms}$ UI thread budget + $4.1\,\text{ms}$ Raster thread budget).

### Invariants for Widget Build Methods

1. **Pure Build Methods**: Widget `build()` methods must be pure functions of state and context. Never perform sorting, parsing, formatting, database I/O, or HTTP requests inside `build()`.
2. **Maximize `const` Constructors**: `const` widgets are instantiated once at compile time and short-circuit element tree reconciliation when parent widgets rebuild.
3. **Small Rebuild Scopes**: Do not rebuild an entire screen when a single badge or counter updates. Extract child widgets or wrap the dynamic node in granular builders.
4. **Lazy vs. Eager List Rendering**:
   - For lists with $> 20$ items or dynamic unbounded collections: **Always** use `ListView.builder`, `GridView.builder`, or `SliverList.builder`.
   - For small, static collections ($n \le 10$, e.g., action sheet items, setting rows): A simple `Column` inside `SingleChildScrollView` is acceptable and avoids builder overhead.
5. **Avoid Unnecessary Intrinsic Passes**: `IntrinsicHeight` and `IntrinsicWidth` force recursive layout passes ($O(n^2)$ layout cost). Use flex layouts (`Expanded`, `Flexible`) or `CustomMultiChildLayout` instead.
6. **RepaintBoundary Justification**: Wrap widgets in `RepaintBoundary` only when profiling shows high repaint rates on isolated, frequently changing widgets (e.g., custom animations, progress bars, camera previews). Do not spam `RepaintBoundary` blindly, as each boundary creates an off-screen compositing layer with associated GPU memory overhead.

```dart
// CORRECT: Minimizing Rebuild Scope and Enforcing Const
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')), // const short-circuits rebuild
      body: const Column(
        children: [
          StaticHeader(), // Never rebuilds when body data changes
          Expanded(child: DynamicTransactionList()), // Only this rebuilds on data update
        ],
      ),
    );
  }
}
```

---

## 4. State Management & Rebuild Optimization

### Architecture-Aware Granular Subscriptions

Inspect the project's existing state management architecture before modifying state code. Use the granular subscription mechanism native to that architecture:

| State Library | Broad Subscription (AVOID in UI nodes) | Granular Subscription (MANDATORY) |
| :--- | :--- | :--- |
| **Provider** | `Provider.of<T>(context)` | `context.select<T, R>((s) => s.specificField)` or `Selector<T, R>` |
| **Riverpod** | `ref.watch(userProvider)` | `ref.watch(userProvider.select((u) => u.name))` |
| **flutter_bloc** | `BlocBuilder<UserBloc, UserState>` | `BlocSelector<UserBloc, UserState, String>(selector: (s) => s.name, ...)` |
| **GetX** | Entire screen wrapped in `Obx(() => ...)` | Atomic `Obx(() => Text(controller.name.value))` |
| **Signals / ValueNotifier** | Rebuilding parent state | `ValueListenableBuilder<T>` or `Watch((context) => ...)` |

### Rules for State Rebuilds
- **Separate Volatile from Stable State**: Isolate high-frequency state updates (e.g., streaming sensor data, scroll offsets, animation tickers) from low-frequency domain state (e.g., user profiles, theme settings).
- **Prevent Duplicate Requests**: Debounce search queries and deduplicate concurrent API calls using state guards or event transformers.
- **Never Migrate Libraries for Performance**: Do not rewrite working state management solutions under the pretext of performance optimization without empirical profiling proof demonstrating that state management is the bottleneck.

---

## 5. Memory Management & Resource Lifecycles

### Mandatory Disposal Invariant

Every controller, node, stream subscription, timer, and native handle created by a widget or service must be closed or disposed in its corresponding teardown lifecycle:

```dart
class _ProfileEditorState extends State<ProfileEditor> {
  late final TextEditingController _nameController;
  late final FocusNode _nameFocusNode;
  late final ScrollController _scrollController;
  StreamSubscription<NetworkStatus>? _networkSubscription;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameFocusNode = FocusNode();
    _scrollController = ScrollController();
    _networkSubscription = networkMonitor.statusStream.listen(_onNetworkChanged);
  }

  @override
  void dispose() {
    // All owned resources MUST be explicitly disposed
    _debounceTimer?.cancel();
    _networkSubscription?.cancel();
    _scrollController.dispose();
    _nameFocusNode.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
```

### High-Resolution Image Memory Management

Unconstrained image decoding is the leading cause of Out-Of-Memory (OOM) crashes in mobile and desktop Flutter apps. A single $4000 \times 3000\,\text{px}$ RGBA image occupies $\approx 48\,\text{MB}$ of uncompressed bitmap memory when decoded at full resolution.

#### Safe Image Decoding Protocol
```dart
// Always constrain memory decoding dimensions using cacheWidth or cacheHeight
Image.network(
  imageUrl,
  // Factor in Device Pixel Ratio (DPR) for high-DPI displays
  cacheWidth: (120 * MediaQuery.devicePixelRatioOf(context)).round(),
  width: 120,
  height: 120,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
);
```
- **Rules**:
  - Never apply arbitrary cache dimensions without factoring in `devicePixelRatio`.
  - Calculate `cacheWidth = (displayWidth * devicePixelRatio).round()`.
  - For thumbnails in grids, constrain dimensions to viewport bounds.

---

## 6. Concurrency & Heavy Computation: Isolates

The Flutter UI isolate must remain unblocked to service touch events, vsync pulses, and animations.

### Isolate Offloading Guidelines

| Workload | Execute on UI Isolate? | Offload to Worker Isolate? | Mechanism |
| :--- | :---: | :---: | :--- |
| **JSON payload $< 50\,\text{KB}$** | Yes | No (Isolate copying overhead exceeds compute time) | Synchronous `jsonDecode()` |
| **JSON payload $> 100\,\text{KB}$** | No | Yes | `Isolate.run(() => jsonDecode(rawString))` |
| **Cryptographic hashing (SHA/AES)** | No | Yes | `Isolate.run()` or native platform channel |
| **Large array sorting ($n > 10^4$)** | No | Yes | `compute()` or `Isolate.run()` |
| **Image manipulation / thumbnailing** | No | Yes | Background worker isolate or native engine |

### The Isolate Overhead Trade-off
Message passing between Dart isolates involves serialization/copying (or transfer of `TransferableTypedData`). If the compute task takes less than $1\,\text{ms}$, creating an isolate or copying data will degrade performance rather than improving it.

```dart
// Efficient Isolate JSON Parsing
Future<List<TransactionDto>> parseLargeTransactions(String jsonPayload) async {
  // Isolate.run creates, executes, and cleans up a worker isolate safely
  return Isolate.run(() {
    final rawList = jsonDecode(jsonPayload) as List<dynamic>;
    return rawList
        .map((e) => TransactionDto.fromJson(e as Map<String, dynamic>))
        .toList();
  });
}
```

---

## 7. Database & Network Performance

### Efficient Database Queries & Persistence
1. **Indexing**: Ensure all foreign keys and columns frequently used in `WHERE`, `ORDER BY`, or `JOIN` clauses have database indexes.
2. **Prevent N+1 Queries**: Fetch related models using SQL joins (`JOIN`) or batched IDs (`WHERE id IN (...)`) rather than querying child records in a loop.
3. **Pagination & Limit/Offset**: Never query `SELECT * FROM table` without `LIMIT` and `OFFSET` or cursor-based pagination.
4. **Transactions for Batch Writes**: Wrap multiple insert or update operations in a single database transaction to prevent disk sync bottlenecks:
   ```dart
   await db.transaction(() async {
     for (final item in items) {
       await db.insertItem(item);
     }
   });
   ```

### Network Performance & Caching
1. **Request Deduplication**: Prevent identical concurrent HTTP requests by sharing the ongoing `Future`.
2. **HTTP Connection Reuse**: Use a persistent `Dio` or `HttpClient` instance with connection pooling rather than instantiating a client per request.
3. **Clear Cache Invalidation**: Every cached response must specify a Time-To-Live (TTL) or explicit invalidation triggers. Never cache data indefinitely.

---

## 8. Frame Rendering, Profiling & Proof of Performance

### Flutter DevTools Profiling Workflow

Before declaring any performance task complete, agents must verify behavior using profiling tools:

1. **Run in Profile Mode**:
   ```bash
   flutter run --profile -d <device-or-windows>
   ```
   *Never profile in Debug mode (JIT compilation and debug assertions introduce artificial jank).*
2. **DevTools Timeline**: Inspect UI and Raster threads during active scrolling. Verify that frame bars remain below the $16.6\,\text{ms}$ (60 FPS) or $8.3\,\text{ms}$ (120 FPS) threshold line.
3. **Performance Overlay**: Enable `showPerformanceOverlay: true` to visualize frame spikes directly on the display.
4. **Memory Profiling**: Capture heap snapshots before and after pushing/popping screens to verify that widget instances and controllers are garbage collected.

---

## 9. Standardized Complexity Assessment for Code Reviews

Whenever generating or reviewing meaningful Dart or Flutter code, AI agents must include a concise **Performance Analysis** block in the following standard format:

```markdown
**Performance Analysis**
- Time Complexity: O(...)
- Auxiliary Space Complexity: O(...)
- Main performance considerations: ...
- Potential bottlenecks: ...
```

### Guidelines for Assessment
- Clearly distinguish total memory from auxiliary space complexity.
- State realistic complexity; do not promise $O(1)$ when operations involve hashing or scanning.
- For declarative Flutter UI snippets, evaluate widget rebuild scope and layout passes without inventing artificial mathematical claims.

---

## 10. The 15-Point Mandatory Performance Checklist

Before completing any Dart or Flutter implementation, verify compliance with this checklist:

- [ ] **1. Data Structures**: Appropriate collections selected (`Map`/`Set` for $O(1)$ lookups, `Queue` for FIFO).
- [ ] **2. Loop Complexity**: Unnecessary nested loops eliminated; lookups pre-indexed.
- [ ] **3. Time Complexity**: Evaluated and documented for input size $n$.
- [ ] **4. Auxiliary Space Complexity**: Evaluated and intermediate allocations minimized.
- [ ] **5. String Building**: `StringBuffer` used for repeated string concatenation in loops.
- [ ] **6. Lazy Iterables**: Chained `Iterable` operations avoid premature `.toList()` calls.
- [ ] **7. Pure Build Methods**: Widget `build()` methods are free from I/O, parsing, and sorting.
- [ ] **8. Const Constructors**: Applied to all immutable widget subtrees.
- [ ] **9. Lazy Viewport Rendering**: `ListView.builder` / `SliverList` used for large or dynamic collections.
- [ ] **10. Scoped Rebuilds**: State subscriptions restricted to the narrowest required widget subtrees.
- [ ] **11. Resource Disposal**: All controllers, nodes, subscriptions, and timers disposed in `dispose()`.
- [ ] **12. Image Memory**: High-resolution images constrained with `cacheWidth`/`cacheHeight` factoring in DPR.
- [ ] **13. Concurrency Offloading**: CPU-heavy tasks ($> 16\,\text{ms}$) offloaded to worker isolates via `Isolate.run()`.
- [ ] **14. Database & Network**: Queries indexed, paginated, and batched; requests deduplicated.
- [ ] **15. Profile Verification**: Verified in profile mode with DevTools when profiling is requested or applicable.
