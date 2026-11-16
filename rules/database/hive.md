# Hive Key-Value & Document Storage Rules

These rules govern key-value and NoSQL document persistence in Flutter applications using **Hive** / **Hive CE**.

---

## 1. When to Use Hive
- **Recommended For**:
  - Application settings, theme preferences, and feature flags.
  - Non-relational document caching (e.g. offline API response payloads).
  - Fast, synchronous reads from in-memory boxes.
- **Not Recommended For**:
  - Complex relational datasets requiring SQL joins or ACID transactions across tables (use Drift/SQLite).
  - Highly structured querying with composite indexes, range queries, and links (use Isar or Drift).
  - High-security secrets like OAuth refresh tokens, private keys, or biometric tokens (use `flutter_secure_storage`).

---

## 2. Production Hive Standards

### Safe TypeAdapters
Always assign explicit, non-overlapping `typeId` integers to every `@HiveType`:
```dart
import 'package:hive/hive.dart';

part 'user_cache.g.dart';

@HiveType(typeId: 1)
class UserCache extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final DateTime lastSynced;

  UserCache({
    required this.id,
    required this.email,
    required this.lastSynced,
  });
}
```

### Critical Hive Invariants
1. **Immutable Field Indexes**: Once index `0` is assigned to `@HiveField(0)`, never reassign index 0 to another field in future schema versions. If a field is deprecated, mark it or omit it, but keep the index reserved.
2. **Register Adapters Before Opening Boxes**: Register all adapters in `main()` before calling `Hive.openBox()`.
   ```dart
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Hive.initFlutter();
     Hive.registerAdapter(UserCacheAdapter());
     await Hive.openBox<UserCache>('users');
     runApp(const MyApp());
   }
   ```
3. **Encrypted Boxes for PII**: When storing personally identifiable information (PII) in Hive, encrypt the box using `HiveAesCipher` with a 256-bit key stored securely in `flutter_secure_storage`:
   ```dart
   final key = await secureStorage.getOrCreateHiveKey();
   final box = await Hive.openBox<UserCache>('secure_users', encryptionCipher: HiveAesCipher(key));
   ```
4. **Box Resource Management**: Keep frequently accessed boxes open in memory as singletons. Close boxes gracefully during app shutdown or logout.

---

## 3. Common Hive Anti-Patterns

| Anti-Pattern | Risk | Correct Pattern |
| :--- | :--- | :--- |
| Storing unencrypted auth tokens in Hive | Plaintext credentials exposed in sandbox files | Store tokens in `flutter_secure_storage` |
| Opening boxes inside widget `build()` | File I/O delays cause UI frame drops | Pre-open boxes during startup or repository init |
| Modifying `@HiveField` types without migration | Box read exceptions and corrupted state | Add new fields with incremented IDs; never alter types |
