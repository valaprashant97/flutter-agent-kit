---
name: real-data-integrity
description: Prevent hard-coded dummy data, enforce real dynamic data flow, implement honest empty states, and isolate mock fixtures to testing environments.
---

# real-data-integrity

## 1. Skill Name
`real-data-integrity`

## 2. Purpose
Enforces the **Real Data Only** standard across Flutter applications. Eliminates fabricated, static, or dummy records in production screens, ensures all UI components bind reactively to real databases or verified APIs, mandates honest empty states when no records exist, prevents fake metric calculations, and strictly isolates mock data to automated test suites.

## 3. When to Use
- When developing new features, screens, dashboards, or UI components.
- When auditing an existing Flutter codebase to eliminate hardcoded sample data or fake API responses.
- When implementing empty states, error states, and metrics calculations.
- When refactoring prototype code into production-ready data pipelines.

## 4. When Not to Use
- When configuring isolated unit, widget, or integration test fixtures in `test/fixtures/`.
- When defining legitimate configuration constants, theme tokens, enums, or fixed business rules.

## 5. Required Project Context
- `pubspec.yaml` (database, state management, and networking packages).
- Data models, repository contracts, and database DAOs.
- Target screen and state controllers.

## 6. Step-by-Step Workflow
1. **Data Source Identification**: Determine whether the data originates from local persistence (Drift, Isar, Hive), remote API (Dio), or device sensors.
2. **Audit for Hardcoded Data**: Scan the target widget or controller for static arrays (e.g. `final sampleItems = [...]`), fake entity instances, or hardcoded metrics.
3. **Connect to State Controller**: Subscribe the UI to a real reactive state provider (`BlocBuilder`, `ref.watch`, `ListenableBuilder`).
4. **Implement Real CRUD Operations**:
   - Form submissions must persist to local storage or dispatch API mutations.
   - Verify data persists across app restart.
5. **Handle the 4 Mandatory States Honestly**:
   - **Loading**: Display skeleton shimmer or progress indicator while query executes.
   - **Success**: Display actual records.
   - **Empty**: If query returns 0 records, display an honest empty state with a call-to-action button (e.g. "Create your first item"). Never insert dummy items to populate the UI.
   - **Error**: If query fails, display an honest error banner with a Retry button. Never substitute fake success data.
6. **Calculate Real Metrics**: Derive all dashboard cards, progress percentages, and charts from actual records. If data is insufficient, show an "Insufficient data" state.
7. **Isolate Mocks**: Ensure mock classes and fixture JSON are confined to `test/`.

## 7. Engineering Rules
- **Zero Dummy Data Invariant**: Never add hardcoded domain records, fake users, or static item lists to production screens in `lib/`.
- **Honest Empty State Invariant**: When no data exists, display an empty UI state with a call-to-action. Never populate fake records to make the screen look full.
- **Real Metrics Invariant**: All statistics, charts, and progress bars must be calculated from real data. Never hardcode numbers or use `Random()` in production metrics.
- **No Mock Leakage**: Test fixtures and mock repositories must never be imported into production code or registered in production dependency injection.
- **Honest Failure Invariant**: When a database or API query fails, show an honest error with retry capability. Never return mock successful data on failure.

## 8. Code Examples

### Prohibited vs Production Pattern: List Presentation
```dart
// PROHIBITED: Hardcoded dummy records pretending to be real user data
class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    // VIOLATION: Static array substituted for real database integration
    final dummyTasks = [
      Task(id: '1', title: 'Buy groceries', isCompleted: false),
      Task(id: '2', title: 'Finish Flutter Agent Kit', isCompleted: true),
    ];

    return ListView.builder(
      itemCount: dummyTasks.length,
      itemBuilder: (context, i) => TaskTile(task: dummyTasks[i]),
    );
  }
}

// PRODUCTION: Real reactive database stream with honest empty state
class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskRepository = context.watch<TaskRepository>();

    return StreamBuilder<List<Task>>(
      stream: taskRepository.watchAllTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return ErrorView(
            message: 'Unable to load tasks.',
            onRetry: () => taskRepository.refresh(),
          );
        }

        final tasks = snapshot.data ?? [];
        if (tasks.isEmpty) {
          return EmptyStateView(
            icon: Icons.checklist_outlined,
            title: 'No tasks yet',
            subtitle: 'Stay organized by adding your first task.',
            actionLabel: 'Add Task',
            onAction: () => Navigator.of(context).pushNamed('/tasks/create'),
          );
        }

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, i) => TaskTile(task: tasks[i]),
        );
      },
    );
  }
}
```

## 9. Common Mistakes
- Leaving `final dummyUsers = [...]` in the file after building the UI prototype.
- Generating random numbers (`Random().nextInt(100)`) to animate dashboard counters.
- Hardcoding `isLoggedIn = true` to skip authentication during development and forgetting to remove it.
- Inserting default sample records into SQLite upon every launch, duplicating data on every run.
- Displaying a fake success toast when an API call failed silently.

## 10. Testing and Verification
- Verify that a fresh installation with an empty database renders the honest empty state.
- Verify that adding a record via the UI persists it to disk and survives app restart.
- Verify that network failure displays an honest error state and does not fall back to fake records.
- Run `flutter test` to ensure mock fixtures in `test/` remain completely decoupled from `lib/`.

## 11. Completion Criteria
- Zero hardcoded domain records or static sample lists exist in production code.
- All UI components are wired to actual application state streams or repositories.
- Empty, loading, and error states operate honestly without fabricated data.
- All dashboard metrics and charts are calculated from real stored records.

## 12. Related Skills
- `database-integration`
- `api-integration`
- `ui-implementation`
- `error-handling`
- `testing`
- `production-readiness`
