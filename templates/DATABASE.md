# Database Schema & Model Specification (DATABASE.md)

## 1. Persistence Engine
- **Technology**: Drift (Type-Safe SQLite)
- **Current Schema Version**: 1
- **File Location**: `getApplicationSupportDirectory() / database / app.sqlite`

---

## 2. Relational Schema & Tables

### Table: `users`
| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | `TEXT` | PRIMARY KEY | Unique user UUID |
| `email` | `TEXT` | NOT NULL, UNIQUE | User login email |
| `display_name` | `TEXT` | NOT NULL | User profile name |
| `created_at` | `DATETIME` | DEFAULT CURRENT_TIMESTAMP | Record creation time |

### Table: `items`
| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | PRIMARY KEY AUTOINCREMENT | Item ID |
| `user_id` | `TEXT` | NOT NULL, REFERENCES users(id) | Foreign key owner |
| `title` | `TEXT` | NOT NULL, LENGTH(1, 255) | Item title |
| `is_completed` | `BOOLEAN` | DEFAULT FALSE | Completion status |
| `created_at` | `DATETIME` | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |

---

## 3. Indexes & Constraints
```sql
CREATE INDEX items_user_id_idx ON items(user_id);
CREATE INDEX items_created_at_idx ON items(created_at);
PRAGMA foreign_keys = ON;
```

---

## 4. Migration Strategy
All future schema updates must increment `schemaVersion` and register non-destructive alterations in `MigrationStrategy.onUpgrade`. Dropping tables in production upgrades is strictly forbidden.
