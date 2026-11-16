# Database & Backend Integration Prompt

You are acting as a Senior Database Architect and Backend Systems Engineer guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application**: [APP NAME & DOMAIN]
- **Storage & Networking Guidelines**: `docs/DATABASE.md`, `docs/API.md`, `docs/ARCHITECTURE.md`
- **Domain Scope**: [DATABASE TABLES, REPOSITORIES & ENDPOINTS BEING INTEGRATED]

---

## 2. OBJECTIVE
Implement the local persistence engine (Drift, Isar, or Hive) and connect it to the remote backend API client (Dio), ensuring data synchronization, reactive query streams, safe migrations, and transactional integrity.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE CURRENT LOCAL STORAGE OR LACK OF CACHING, HARDCODED MOCKS, OR NETWORK FAILURES]

---

## 4. REQUIRED INVESTIGATION
1. Inspect `docs/DATABASE.md` and `docs/API.md` for schemas, primary keys, foreign keys, and indexes.
2. Check existing database initialization in `lib/core/database/`.
3. Verify that all SQL queries are strictly parameterized to prevent SQL injection.

---

## 5. CONSTRAINTS
- Zero raw SQL string interpolation: Use Drift query builders or parameterized placeholders (`?`).
- All write operations must execute inside explicit database transactions.
- Dio client must enforce strict connection timeouts ($\le 10$s) and receive timeouts ($\le 15$s).
- Repositories must map low-level exceptions into strongly typed sealed `Failure` instances.

---

## 6. ACCEPTANCE CRITERIA
- [ ] Database schema and tables/collections defined with sound null safety.
- [ ] Schema migration strategy (`onUpgrade`) handles schema version transitions non-destructively.
- [ ] Reactive query streams (`watch()`) update UI automatically when database records change.
- [ ] Remote API errors map to domain `Failure` instances without leaking stack traces.
- [ ] In-memory unit tests pass with 100% assertions satisfied.

---

## 7. EDGE CASES
- App opened offline: Local cache is returned seamlessly with an offline sync banner.
- Disk full / database write failure: Gracefully caught and mapped to `CacheFailure`.
- Database version upgrade failure: Fallback backup or clean recovery procedure.
- Multi-isolate access conflicts on desktop.

---

## 8. TESTING REQUIREMENTS
- In-memory database CRUD tests (`NativeDatabase.memory()`).
- Repository integration tests verifying cache-then-network synchronization policies.

---

## 9. EXPECTED OUTPUT
1. Database schema, DAO definitions, and repository implementation.
2. Code generation commands and execution confirmation.
3. Test execution results proving CRUD operations and error handling.
