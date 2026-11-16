# Drift (SQLite) Persistence Rules

These rules govern the implementation of `drift` (formerly Moor), Flutter's type-safe, reactive relational database engine.

---

## 1. Why Drift for Production?
- **Compile-time SQL Validation**: Verifies queries, schema migrations, and column types at build time.
- **Reactive Streams**: Auto-emits updated records when rows change using `select().watch()`.
- **Native Platform Support**: Runs on Android, iOS, Windows, macOS, Linux, and Web using `sqlite3`.

---

## 2. Table Definition & Schema Standards

```dart
import 'package:drift/drift.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get description => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

### Table Rules:
- Always define explicit length constraints on `TextColumn`.
- Use nullable columns (`.nullable()`) explicitly; default columns to non-null.
- Create indexes on columns frequently used in `WHERE`, `ORDER BY`, or `JOIN` operations:
  ```dart
  @override
  List<Set<Column>> get customConstraints => [
    {'CREATE INDEX tasks_created_at_idx ON tasks(created_at)'},
  ];
  ```

---

## 3. Safe Schema Migrations

> [!CAUTION]
> **Never Drop Tables in Production Migrations.**
> Never write destructive schema changes that delete user data unless explicitly authorized by the user.

Implement step-by-step migration strategies:
```dart
@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // Migration from v1 to v2: Add description column
        await m.addColumn(tasks, tasks.description);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
```
Always verify migrations using `drift_dev make-migrations` before shipping updates.
