---
name: file-system
description: Cross-platform file I/O, path_provider directories, cache management, and secure file handling.
---

# file-system

## 1. Skill Name
`file-system`

## 2. Purpose
Provides production standards for file system operations in Flutter: resolving platform-specific directories (`path_provider`), reading and writing files safely, managing cache eviction, handling user exports, and respecting platform sandbox boundaries.

## 3. When to Use
- When reading or writing local files, documents, images, logs, or exports.
- When configuring database file paths (SQLite, Hive).
- When caching downloaded media or cleaning up temporary directories.

## 4. When Not to Use
- In Flutter Web applications where `dart:io` and native file paths are unsupported (use browser blobs or indexedDB on web).

## 5. Required Project Context
- `pubspec.yaml` (`path_provider`, `path`)
- Target directory requirements (temporary vs application support vs documents)

## 6. Step-by-Step Workflow
1. **Select Directory Type**:
   - `getApplicationSupportDirectory()`: App internal persistent data (databases, configuration). Not exposed directly to the user.
   - `getApplicationDocumentsDirectory()`: User-generated content (notes, saved projects). Backed up on iOS/iCloud.
   - `getTemporaryDirectory()`: Volatile caches that can be purged by the OS at any time.
   - `getDownloadsDirectory()`: Desktop user downloads folder.
2. **Resolve Cross-Platform Paths**: Use `p.join()` from `package:path` to safely join path segments across POSIX and Windows delimiters.
3. **Ensure Directory Exists**: Verify `await directory.create(recursive: true)` before creating files.
4. **Perform Atomic Writes**: When writing critical data, write to a `.tmp` file first and rename to the target file to avoid corruption during crashes or power loss.
5. **Implement Cache Eviction**: Periodically delete temporary files older than a specified duration (e.g., 7 days) to prevent disk exhaustion.

## 7. Engineering Rules
- **No Hardcoded Delimiters**: Never use raw `/` or `\` in path strings; always use `p.join()`.
- **Atomic File Writing**: Do not perform partial direct stream writes to active database or critical preference files.
- **Web Safety**: Guard all `dart:io` imports with `kIsWeb` or conditional imports.

## 8. Code Examples
```dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileStorageService {
  Future<File> saveExportSafely({required String fileName, required List<int> bytes}) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final exportDir = Directory(p.join(docsDir.path, 'exports'));

    if (!await exportDir.exists()) {
      await exportDir.create(recursive: true);
    }

    final targetFile = File(p.join(exportDir.path, fileName));
    final tempFile = File(p.join(exportDir.path, '$fileName.tmp'));

    // Atomic write pattern: write to tmp first, then rename
    await tempFile.writeAsBytes(bytes, flush: true);
    return await tempFile.rename(targetFile.path);
  }

  Future<void> clearOldCache() async {
    final tempDir = await getTemporaryDirectory();
    final now = DateTime.now();
    await for (final entity in tempDir.list(recursive: false)) {
      if (entity is File) {
        final stat = await entity.stat();
        if (now.difference(stat.modified) > const Duration(days: 7)) {
          await entity.delete();
        }
      }
    }
  }
}
```

## 9. Common Mistakes
- Writing persistent database files to `getTemporaryDirectory()`, where the OS can purge them under storage pressure.
- Forgetting to call `flush: true` on `writeAsBytes`, leaving data in volatile OS write buffers during sudden app termination.

## 10. Testing and Verification
- Unit test file operations using temporary directories in `Directory.systemTemp.createTempSync()`.
- Verify cleanup logic deletes only targeted expired files.

## 11. Completion Criteria
- Files written atomically with error handling.
- Directory paths resolve accurately on Android, iOS, Windows, macOS, and Linux.

## 12. Related Skills
- `database-integration`
- `windows-development`
- `security-audit`
