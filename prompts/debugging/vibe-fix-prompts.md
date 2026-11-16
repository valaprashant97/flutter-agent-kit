# 5 Tactical Production Prompts for Vibe-Coded Flutter Apps

These 5 tactical prompts address the most common failure modes in AI-generated Flutter applications. Each prompt is structured using the canonical 9-section context specification.

---

## 1. Confusing Navigation & Hidden Actions Fix

### 1. PROJECT CONTEXT
- **Target Application**: [APP NAME]
- **Scope**: All top-level navigation, AppBars, and screen action buttons.
- **Reference**: `rules/ui-ux/accessibility.md`, `rules/ui-ux/material-3.md`

### 2. OBJECTIVE
Audit and refactor UI navigation, icon buttons, and action destinations to ensure clear visual discoverability, explicit text labeling, proper tap targets, and screen reader accessibility.

### 3. EXISTING BEHAVIOR
- Icon-only buttons with ambiguous meanings, cluttered AppBars, missing accessibility labels, and inconsistent tap target dimensions.

### 4. REQUIRED INVESTIGATION
1. Identify all `IconButton`, `FloatingActionButton`, and navigation items lacking text labels or tooltips.
2. Check bottom navigation destination count (flagging instances with $>5$ items).
3. Measure touch targets against 48x48dp (mobile) and 32x32dp (desktop) standards.

### 5. CONSTRAINTS
- Bottom navigation must contain between 3 and 5 primary destinations with explicit text labels.
- Secondary/infrequent actions must reside in an overflow menu (`PopupMenuButton`) or drawer.
- Do not alter the underlying business logic or route controllers.

### 6. ACCEPTANCE CRITERIA
- [ ] Every icon-only button carries a `Tooltip` and `Semantics(label: ...)`.
- [ ] Primary navigation is limited to 3-5 labeled items.
- [ ] Minimum tap target boundaries are enforced.
- [ ] Passes `flutter analyze` with 0 warnings.

### 7. EDGE CASES
- Long localized strings overflowing navigation labels.
- Desktop keyboard focus navigation through AppBar action items.

### 8. TESTING REQUIREMENTS
- Widget test verifying that accessibility labels are attached to every action button.

### 9. EXPECTED OUTPUT
1. List of audited navigation defects.
2. Surgical widget updates implementing explicit labels and overflow menus.
3. Verification results from `flutter test`.

---

## 2. Screen Freezes After Tap (Optimistic UI Fix)

### 1. PROJECT CONTEXT
- **Target Application**: [APP NAME]
- **Scope**: User mutation actions (favoriting, bookmarking, archiving, toggling likes, status updates).
- **Reference**: `rules/networking/caching-offline.md`, `core/engineering-standards.md`

### 2. OBJECTIVE
Eliminate UI freezing and latency after button taps by implementing optimistic UI updates with automatic failure rollback and user notification.

### 3. EXISTING BEHAVIOR
- User taps a button; UI freezes or displays a blocking modal indicator while awaiting remote network round-trip.

### 4. REQUIRED INVESTIGATION
1. Identify all interactive toggle buttons awaiting remote API completion before updating UI state.
2. Verify existing state management pattern to implement optimistic state mutation and rollback caches.

### 5. CONSTRAINTS
- **Never use optimistic UI for irreversible or financial actions** (payments, account deletion, irreversible transfers).
- Always retain previous state in memory to allow clean rollback.
- Inform the user if the background operation fails via a non-blocking SnackBar with a Retry action.

### 6. ACCEPTANCE CRITERIA
- [ ] UI reflects state change immediately (0ms visual latency).
- [ ] Network request executes asynchronously in the background.
- [ ] On failure, state automatically reverts to previous value and an error SnackBar appears.
- [ ] Passes `flutter analyze` with 0 warnings.

### 7. EDGE CASES
- User taps toggle multiple times rapidly while offline.
- App backgrounded before the network request resolves.

### 8. TESTING REQUIREMENTS
- Unit test verifying immediate state update, successful server sync, and failure rollback.

### 9. EXPECTED OUTPUT
1. Optimistic UI transition plan.
2. Surgical state controller and widget edits.
3. Automated test verification execution output.

---

## 3. High Memory & Slow Loading (Pagination Fix)

### 1. PROJECT CONTEXT
- **Target Application**: [APP NAME]
- **Scope**: Unbounded list screens, feed queries, and search result views.
- **Reference**: `rules/performance/jank-elimination.md`, `rules/database/drift.md`

### 2. OBJECTIVE
Replace unbounded data fetching with efficient cursor-based or limit/offset pagination to minimize memory usage and eliminate list rendering latency.

### 3. EXISTING BEHAVIOR
- Entire collection of records is fetched in a single query and rendered via `ListView(children: ...)`, causing high RAM consumption and frame drops.

### 4. REQUIRED INVESTIGATION
1. Inspect API and database queries for missing `LIMIT` and `OFFSET` clauses.
2. Check widget tree for non-virtualized `ListView` or `SingleChildScrollView(Column(...))` rendering large datasets.

### 5. CONSTRAINTS
- Standard page size: 20 records per batch.
- Must use virtualized lazy builders (`ListView.builder` or `SliverList.builder`).
- Loading more data must trigger before reaching the end of the list (prefetch threshold: 200px).

### 6. ACCEPTANCE CRITERIA
- [ ] Initial fetch retrieves only page 1 (20 items).
- [ ] Scrolling near bottom fetches next page with small centered footer indicator.
- [ ] End-of-list indicator displayed when no more records remain.
- [ ] Search filtering resets pagination to page 1.

### 7. EDGE CASES
- Refresh-to-reload (`RefreshIndicator`) resetting pagination without memory leaks.
- Zero results matching search query (must display Empty state).

### 8. TESTING REQUIREMENTS
- Widget test verifying lazy loading triggers on scroll and appends subsequent records.

### 9. EXPECTED OUTPUT
1. Pagination architecture plan.
2. Surgical repository, controller, and widget code diffs.
3. Verification results from `flutter test`.

---

## 4. Database Bottleneck (N+1 Query Elimination)

### 1. PROJECT CONTEXT
- **Target Application**: [APP NAME]
- **Scope**: Local database access layer, Drift/SQLite queries, and repository mappers.
- **Reference**: `rules/database/drift.md`, `rules/database/isar.md`

### 2. OBJECTIVE
Eliminate N+1 database queries by replacing iterative query loops with batch SQL `JOIN` statements or batched `WHERE IN (...)` lookups with foreign key indexes.

### 3. EXISTING BEHAVIOR
- Repository queries a list of parent entities, then iterates in a Dart loop executing a separate query for each child record (e.g. 50 parent records = 51 database queries).

### 4. REQUIRED INVESTIGATION
1. Audit repository and DAO methods for loops containing `await db.select(...)` or `await isar.find(...)`.
2. Check database table definitions for missing indexes on foreign key columns.

### 5. CONSTRAINTS
- All data must be retrieved in a single database round-trip.
- Add indexes to foreign key columns used in the join or lookup.
- Returned domain entities must match previous output signatures exactly.

### 6. ACCEPTANCE CRITERIA
- [ ] Iterative loop queries replaced with a single SQL `JOIN` or batch lookup.
- [ ] Composite or foreign key indexes added to schema.
- [ ] Data layer test passes with identical output records.

### 7. EDGE CASES
- Parent records having 0 associated child records (must handle `LEFT JOIN` nulls).
- Query batches exceeding SQLite variable limit (chunk lookups if $>999$ IDs).

### 8. TESTING REQUIREMENTS
- Unit test verifying repository returns complete entity hierarchy with a single query execution.

### 9. EXPECTED OUTPUT
1. Identified N+1 query points.
2. Refactored DAO and repository implementation.
3. Test output verifying execution time reduction and correctness.

---

## 5. UI Frame Drops (Worker Isolate Offloading)

### 1. PROJECT CONTEXT
- **Target Application**: [APP NAME]
- **Scope**: CPU-intensive operations (JSON parsing of $>1$MB payloads, image resizing, encryption/decryption, data export).
- **Reference**: `rules/performance/jank-elimination.md`, `skills/performance/`

### 2. OBJECTIVE
Offload heavy computational work from the Flutter UI thread to background worker isolates using `Isolate.run()` to guarantee 60/120 FPS UI fluidity.

### 3. EXISTING BEHAVIOR
- Complex JSON parsing or computation runs synchronously on the main Dart isolate, dropping UI frames and causing janky scrolling or freezing spinners.

### 4. REQUIRED INVESTIGATION
1. Profile UI using DevTools Performance trace to identify frames exceeding 16.6ms on the UI thread.
2. Pinpoint CPU-heavy functions called directly from presentation or data layers.

### 5. CONSTRAINTS
- Use `Isolate.run()` for short-to-medium background computational tasks.
- Objects passed into and returned from isolates must be sendable primitives or typed records.
- Display a smooth, non-blocking loading indicator in the UI while the isolate computes.

### 6. ACCEPTANCE CRITERIA
- [ ] Heavy CPU computation runs in `Isolate.run()`.
- [ ] Main UI thread drops 0 frames during execution (verified via DevTools profile).
- [ ] Error thrown in isolate is caught and mapped to domain `Failure`.

### 7. EDGE CASES
- User navigates away from screen while isolate is processing (result discarded safely without unmounted context errors).
- Out-of-memory errors on low-end devices during large array parsing.

### 8. TESTING REQUIREMENTS
- Unit test verifying asynchronous isolate execution and typed return value.

### 9. EXPECTED OUTPUT
1. Performance diagnosis identifying main thread bottlenecks.
2. Surgical isolate refactoring implementation.
3. Test output and frame timing verification.
