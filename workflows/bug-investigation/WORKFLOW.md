# Workflow: Bug Investigation & Defect Triage

This workflow guides an AI coding agent through systematically investigating, reproducing, and triaging software defects, crashes, visual anomalies, and performance regressions in Flutter applications.

---

## 1. Entry Conditions
- A bug report, crash log, user issue, or unexpected behavior is reported.
- Codebase may be greenfield or brownfield.

---

## 2. Step-by-Step Procedure

### Phase 1: Symptom Capture & Environment Triangulation
1. **Gather Symptom Data**:
   - Exact error message and full stacktrace.
   - Operating system and version (Windows 11, Android 14, iOS 17, Web browser).
   - Flutter SDK and Dart version (`flutter --version`).
   - Device characteristics (Screen resolution, DPI scaling, input type: touch vs mouse).
2. **Classify Defect Category**:
   - Crash / Unhandled Exception (`NullCheckError`, `RangeError`, `PlatformException`).
   - Layout / Render Tree Invalidation (`RenderFlex overflowed`, unbounded height).
   - State Drift / Asynchronous Race Condition.
   - Memory Leak / OOM Crash.
   - Native Platform Interop / Missing Plugin.

### Phase 2: Code Inspection & Concentric Ring Tracing
1. Locate the exact file and line number where the failure manifests.
2. Read the surrounding method (Ring 1) to understand immediate variable state.
3. Trace caller methods and state controllers (Ring 2) to see where the invalid input originated.
4. Review recent git commits touching the file (`git log -p -n 5 <path>`) to see what changed recently.

### Phase 3: Minimal Deterministic Reproduction
1. Write a failing unit or widget test that reproduces the bug with 100% reliability:
   ```dart
   testWidgets('reproduces crash when user profile has null avatarUrl', (tester) async { ... });
   ```
2. If reproducing visually, document the exact minimal user interaction steps.

### Phase 4: Root Cause Hypothesis & Verification
1. Formulate a hypothesis explaining *why* the bug occurred:
   - "The repository returns an unhandled 404 response that the presentation layer assumes is always a valid User object."
2. Verify the hypothesis against the codebase before writing any production fix.
3. Document findings in `docs/MEMORY.md` or the issue tracker.

### Phase 5: Handoff to Bug Fixing
1. Once root cause is proven, proceed to `workflows/bug-fixing/` or `workflows/root-cause-analysis/`.

---

## 3. Exit Criteria & Quality Gates
- [ ] Bug is reproduced reliably via an automated test or deterministic steps.
- [ ] Root cause mechanism is proven and documented.
- [ ] No speculation or guesswork remains.

---

## 4. Related Skills & Rules
- `skills/debugging/`
- `skills/error-handling/`
- `core/project-understanding.md`
- `core/token-efficiency.md`
