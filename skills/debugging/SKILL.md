---
name: debugging
description: Systematic root cause debugging, stacktrace analysis, layout overflow diagnosis, and regression prevention.
---

# debugging

## 1. Skill Name
`debugging`

## 2. Purpose
Provides a disciplined, 6-step root-cause debugging procedure for Flutter applications. Eliminates guesswork, treats the cause rather than symptoms, deciphers complex stacktraces, diagnoses layout overflows (`RenderFlex`), and verifies fixes without breaking adjacent functionality.

## 3. When to Use
- When investigating unhandled exceptions, app crashes, or red error screens.
- When fixing layout overflow warnings (`A RenderFlex overflowed by ... pixels`).
- When diagnosing asynchronous race conditions or failed assertions.

## 4. When Not to Use
- When planning or architecting a new feature from scratch.

## 5. Required Project Context
- Error message and stacktrace
- Steps to reproduce
- File where the exception originated

## 6. Step-by-Step Workflow
1. **Isolate the Failure**: Extract the exact exception type (e.g., `LateInitializationError`, `RangeError`, `FlutterError`) and originating line number.
2. **Reproduce or Trace**: Understand the sequence of user interactions or asynchronous events that triggered the failure.
3. **Identify Root Cause**: Determine *why* the invalid state or constraint occurred (e.g., unmounted BuildContext, missing null check, unbounded flex parent).
4. **Author Reproduction Test**: When possible, write a minimal unit or widget test that reproduces the failure.
5. **Apply Minimal Fix**: Implement the smallest safe modification that fixes the root cause.
6. **Verify & Check Regressions**: Run the reproduction test to verify it passes, then run `flutter analyze` and the full test suite.

## 7. Engineering Rules
- **Zero Fake Data Masking**: Never patch bugs by returning hardcoded sample objects or static dummy responses. Fix the actual invalid state transition or missing null check in the real data pipeline (`docs/REAL_DATA_INTEGRITY.md`).
- **No Symptom Masking**: Never wrap failing code in a generic empty `catch (e) {}` block just to silence an error.
- **No Unrelated Refactoring**: Do NOT refactor adjacent code or reorganize unrelated methods while fixing a bug.
- **Explain the Mechanism**: In the final report, state clearly: What failed, Why it failed, and What minimal change fixed it.

## 8. Code Examples
### Diagnosing and Fixing RenderFlex Overflow
```dart
// FAILING CODE - Causes RenderFlex overflow when text is long
Row(
  children: [
    const Icon(Icons.info),
    Text(errorMessage), // Unbounded width
  ],
);

// ROOT CAUSE FIX - Constrain text with Expanded & Ellipsis
Row(
  children: [
    const Icon(Icons.info),
    const SizedBox(width: 8),
    Expanded(
      child: Text(
        errorMessage,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    ),
  ],
);
```

## 9. Common Mistakes
- Randomly patching code until the error disappears without understanding why it occurred.
- Silently removing a test assertion because the bug fix made the test fail.
- Adding speculative null checks everywhere instead of fixing the single invalid state transition.

## 10. Testing and Verification
- Run the targeted test: `flutter test <path_to_reproduction_test>`.
- Run `flutter analyze` to ensure no syntax or type regressions were introduced.

## 11. Completion Criteria
- Root cause identified, documented, and fixed.
- Reproduction test passes.
- Zero collateral regressions in existing tests.

## 12. Related Skills
- `real-data-integrity`
- `error-handling`
- `testing`
- `ui-implementation`
- `performance`
