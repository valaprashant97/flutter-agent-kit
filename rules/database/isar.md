# Isar Database Architecture & Querying Rules

These rules govern embedded object database persistence in Flutter applications using **Isar**.

---

## 1. When to Use Isar
- **Recommended For**:
  - Offline-first mobile and desktop apps requiring complex querying, filtering, and sorting without SQL boilerplate.
  - Multi-thousand record datasets requiring lightning-fast indexing and low memory footprint.
  - Reactive UI integration via native query watchers (`watchLazy()`, `watchObject()`).
  - Full-text search (FTS) and embedded relations (`IsarLink`, `IsarLinks`).
- **Not Recommended For**:
  - Simple 5-field key-value preferences (use `shared_preferences` or `hive`).
  - Strict legacy relational schemas with complex foreign key cascades and triggers (use `drift`).

---

## 2. Production Isar Schema Design

### Collection Definition & Indexing
Every collection must define an explicit `@collection` annotation with typed auto-incrementing ID and strategic indexing:
```dart
import 'package:isar/isar.dart';

part 'contact.g.dart';

@collection
class Contact {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String email;

  @Index(composite: [CompositeIndex('lastName')])
  late String firstName;

  late String lastName;

  late DateTime createdAt;

  final organization = IsarLink<Organization>();
}
```

### Indexing Invariants
1. **Index Query Fields**: Any field frequently queried in `.filter().fieldNameEqualTo(...)` or used in sorting must have an `@Index()`.
2. **Composite Indexes for Compound Searches**: When filtering by both `firstName` and `lastName`, declare a composite index to prevent full-table scans.
3. **Case Sensitivity**: By default, string indexes are case-sensitive. Use `caseSensitive: false` on search fields when case-insensitive lookups are needed.

---

## 3. Asynchronous Operations & Transactions

### Safe Transactions (`writeTxn`)
All mutations (insert, update, delete) must occur within an explicit asynchronous transaction:
```dart
Future<void> saveContact(Isar isar, Contact contact) async {
  await isar.writeTxn(() async {
    await isar.contacts.put(contact);
    await contact.organization.save();
  });
}
```

### Batching High-Volume Writes
Never execute single `put()` calls inside loops. Always use batch operations:
```dart
// WRONG: High disk I/O overhead
for (final item in batch) {
  await isar.writeTxn(() => isar.contacts.put(item));
}

// CORRECT: Single transaction batch
await isar.writeTxn(() async {
  await isar.contacts.putAll(batch);
});
```

---

## 4. Reactive Query Watchers & UI Binding

Use Isar query watchers to automatically update UI on database changes:
```dart
Stream<List<Contact>> watchRecentContacts(Isar isar) {
  return isar.contacts
      .filter()
      .createdAtGreaterThan(DateTime.now().subtract(const Duration(days: 30)))
      .sortByLastName()
      .watch(fireImmediately: true);
}
```

---

## 5. Isar Anti-Patterns

| Anti-Pattern | Root Cause | Production Remediation |
| :--- | :--- | :--- |
| **Opening multiple Isar instances** | Opening the same database name multiple times crashes or locks the file | Use a singleton database service or dependency injection (`GetIt`/`Riverpod`) |
| **Running heavy queries on the main isolate** | Long filter operations drop UI frames | Use `isar.contacts.where().findAllAsync()` or compute in an isolate |
| **Ignoring link updates** | Calling `isar.contacts.put(contact)` does NOT persist changes to `contact.organization` | Call `await contact.organization.save()` inside the transaction |
