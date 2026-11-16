# Hive & Isar NoSQL Storage Index

> [!NOTE]
> This guide has been split into dedicated, in-depth architectural guides:
> - **Hive Key-Value & Document Storage**: See [rules/database/hive.md](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/rules/database/hive.md)
> - **Isar Embedded Object Database**: See [rules/database/isar.md](file:///D:/Flutter/Flutter%20Agent-Kit/flutter-agent-kit/rules/database/isar.md)

---

## Quick Comparison & Selection Matrix

| Capability | Hive | Isar | Drift (SQLite) |
| :--- | :--- | :--- | :--- |
| **Primary Model** | Key-Value / Binary Boxes | Embedded Object Collections | Relational SQL Tables |
| **Querying** | Key lookup, in-memory filtering | Native rich filters, sorting, FTS | Full SQL query syntax |
| **Indexes** | No native indexes | Fast composite, hash, value indexes | B-Tree & composite SQL indexes |
| **Transactions** | Simple box writes | ACID multi-isolate transactions | Full ACID SQL transactions |
| **Best For** | Preferences, theme, small caches | Complex offline objects, search | Relational data, foreign keys |
