---
name: database-integration
description: Type-safe local database persistence, schema migrations, and relational integrity using Drift and SQLite.
---

# database-integration

## 1. Skill Name
`database-integration`

## 2. Purpose
Provides production standards for implementing local data persistence in Flutter using Drift (SQLite). Manages type-safe table definitions, complex relational queries, DAOs, schema migrations, and offline caching.

## 3. When to Use
- When persisting structured or relational data on-device.
- When building offline-first applications that sync local SQLite records with remote APIs.
- When performing database schema migrations between app versions.

## 4. When Not to Use
- For simple key-value preference storage (use `shared_preferences` instead).
- For storing cryptographic secrets or raw user tokens (use `flutter_secure_storage` instead).

## 5. Required Project Context
- `pubspec.yaml` (`drift`, `sqlite3_flutter_libs`, `drift_dev`)
- Entity definitions and relational schemas

## 6. Step-by-Step Workflow
1. **Define Tables**: Author table schemas extending `Table` with typed columns and constraints.
2. **Create Database Class**: Annotate with `@DriftDatabase` and define `schemaVersion`.
3. **Configure Platform Connection**: Set up SQLite native database connection using `NativeDatabase` or `LazyDatabase` wrapped with `path_provider`.
4. **Implement DAOs**: Create Data Access Objects (DAOs) encapsulating queries, inserts, updates, and reactive stream watchers (`watch()`).
5. **Implement Safe Migrations**: Handle schema upgrades in `MigrationStrategy.onUpgrade` with non-destructive alterations (`addColumn`).

## 7. Engineering Rules
- **Zero Default Mock Population**: Never insert fake records or placeholder items into the database on startup to make the app appear populated. Let the UI show an honest empty state with a call-to-action (`docs/REAL_DATA_INTEGRITY.md`).
- **Real CRUD Persistence**: Ensure CRUD operations genuinely commit to disk and verify that records persist across complete application process restart.
- **Non-Destructive Invariant**: Never execute `DROP TABLE` in an upgrade migration without explicit user approval.
- **Foreign Keys Enabled**: Always execute `PRAGMA foreign_keys = ON;` in `beforeOpen`.
- **Query Optimization**: Add explicit indexes to columns queried frequently or filtered in `WHERE` clauses.

## 8. Code Examples
```dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'app_database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Note>> watchAllNotes() => select(notes).watch();
  Future<int> insertNote(NotesCompanion entry) => into(notes).insert(entry);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_notes.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
```

## 9. Common Mistakes
- Writing raw string SQL with concatenated variables, introducing SQL injection vulnerabilities.
- Forgetting to run `dart run build_runner build` after modifying Drift tables.
- Running heavy database queries on the main UI isolate instead of using `NativeDatabase.createInBackground`.

## 10. Testing and Verification
- Write unit tests using in-memory databases (`NativeDatabase.memory()`).
- Verify migrations with `drift_dev make-migrations`.

## 11. Completion Criteria
- Type-safe tables compiled without error.
- Reactive streams emit database updates.
- Migrations pass validation tests.

## 12. Related Skills
- `coding-standards` — Database & API Standards (Section 5) of `docs/FLUTTER_CODING_STANDARDS.md`
- `real-data-integrity`
- `flutter-architecture`
- `api-integration`
- `file-system`
