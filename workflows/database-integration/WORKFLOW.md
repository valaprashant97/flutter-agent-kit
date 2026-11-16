# Workflow: Database Integration & Offline Persistence

This workflow guides an AI coding agent through designing, implementing, migrating, and testing local persistence in Flutter using Drift (SQLite), Isar, or Hive.

---

## 1. Entry Conditions
- Data models, entity relationships, and offline caching requirements are defined.
- Project requires structured relational tables, embedded object storage, or key-value preferences.

---

## 2. Step-by-Step Procedure

### Phase 1: Storage Engine Selection & Schema Design
1. **Choose Engine**:
   - **Drift (SQLite)**: Relational schema, foreign keys, SQL joins, complex migrations.
   - **Isar**: High-volume embedded object graphs, composite indexing, full-text search.
   - **Hive / Hive CE**: Lightweight key-value boxes, preferences, raw document cache.
   - **FlutterSecureStorage**: Encrypted sensitive tokens (OAuth refresh tokens, biometric keys).
2. **Author Schema Spec**:
   - Create `docs/DATABASE.md` using `templates/DATABASE.md`.
   - Document tables/collections, column types, primary keys, foreign keys, and indexes.

### Phase 2: Dependency Configuration & Code Generation
1. Configure `pubspec.yaml`:
   - For Drift: `drift`, `sqlite3_flutter_libs`, `path_provider`, `path`; dev: `drift_dev`, `build_runner`.
   - For Isar: `isar`, `isar_flutter_libs`, `path_provider`; dev: `isar_generator`, `build_runner`.
   - For Hive: `hive`, `hive_flutter`; dev: `hive_generator`, `build_runner`.
2. Run build runner:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

### Phase 3: Repository Pattern & Data Access Layer
1. Define abstract repository interface in `domain/repositories/`.
2. Implement local data source in `data/datasources/local/`.
3. Wrap all write operations in explicit transactions (`writeTxn` for Isar, `transaction()` for Drift).
4. Never expose raw database entities directly to the UI; map database models to clean domain entities (`toDomain()`).

### Phase 4: Migration Strategy & Version Bumping
1. Define schema versioning:
   - Drift: Override `schemaVersion` and implement `MigrationStrategy(onUpgrade: ...)`.
   - Hive: Increment `typeId` or add optional nullable fields; never alter existing field indexes.
   - Isar: Update model properties; handle renamed columns via migration routines.
2. Test database migration from version `N-1` to `N` with populated dummy data.

### Phase 5: Testing Local Persistence
1. Author unit tests using in-memory databases (`NativeDatabase.memory()` for Drift) to verify CRUD operations, queries, and constraints.
2. Verify that deleting or updating records correctly preserves relational integrity.

---

## 3. Exit Criteria & Quality Gates
- [ ] `docs/DATABASE.md` accurately documents schema, indexes, and versioning.
- [ ] Database write operations are encapsulated within transactions.
- [ ] Code generation (`build_runner`) finishes with 0 errors.
- [ ] In-memory repository tests pass with 100% assertions satisfied.

---

## 4. Related Skills & Rules
- `skills/database-integration/`
- `rules/database/drift.md`
- `rules/database/isar.md`
- `rules/database/hive.md`
- `rules/database/secure-storage.md`
