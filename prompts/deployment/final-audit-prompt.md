# Final Production Launch Audit Prompt

You are acting as a Principal Engineering Lead and Release Gatekeeper responsible for approving an application for production release under the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application & Version**: [APP NAME & RELEASE VERSION]
- **Target Platforms**: [Windows Desktop, Android, iOS, Web, macOS, Linux]
- **Audit Benchmarks**: `docs/PRD.md`, `docs/ARCHITECTURE.md`, `docs/DESIGN.md`, `docs/SECURITY.md`, and `workflows/production-audit/WORKFLOW.md`

---

## 2. OBJECTIVE
Perform an exhaustive 50-point pre-flight launch audit across functional correctness, UI/UX consistency, security, performance, cross-platform stability, and packaging to issue a formal launch certification.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE PROPOSED CANDIDATE RELEASE BUILD, PLATFORM TARGETS, AND RECENT CHANGES]

---

## 4. REQUIRED INVESTIGATION
1. Execute full static analysis: `flutter analyze`.
2. Execute complete automated test suites: `flutter test`.
3. Check release compile validity across target platforms (`flutter build windows --release`, `flutter build appbundle --release`).
4. Inspect source files for hardcoded secrets and unencrypted storage.

---

## 5. CONSTRAINTS
- Strict zero-defect policy for Critical blockers (P0/P1).
- No skipped, ignored, or weakened test assertions permitted.
- Never certify a build without actual CLI command execution output.

---

## 6. ACCEPTANCE CRITERIA
- [ ] Functional completeness: All P0/P1 functional requirements in `docs/PRD.md` verified.
- [ ] Real data integrity: Zero hardcoded dummy data, fake metrics, or mock leaks in `lib/`; empty states render honest empty UI (`docs/REAL_DATA_INTEGRITY.md`).
- [ ] UI/UX quality: Zero `RenderFlex` overflows across all device breakpoints.
- [ ] The 4 mandatory UI states: Loading, Success, Empty, and Error handled on all asynchronous screens.
- [ ] Security: Zero secrets, hardware-encrypted tokens, strict HTTPS.
- [ ] Performance: Zero memory leaks, smooth 60/120 FPS frame rates.
- [ ] Platform readiness: Windows single-instance mutex, DPI awareness, system tray, and signed MSIX verified.
- [ ] Static analysis: `flutter analyze` passes with 0 warnings and 0 errors.

---

## 7. EDGE CASES
- Application update over previous version preserving user data.
- Airplane mode offline state and recovery upon reconnection.
- Window resizing across multi-monitor displays with different scaling factors.
- System low-memory OS kills and cold start state restoration.

---

## 8. TESTING REQUIREMENTS
- 100% test pass rate across all unit, widget, and integration test suites.
- Golden regression baseline match verification (`flutter test --tags=golden`).

---

## 9. EXPECTED OUTPUT
1. 50-Point Pre-Flight Launch Audit Matrix.
2. Verified CLI execution output for analysis, tests, and release compilation.
3. Formal Launch Verdict:
   - **`[READY FOR PRODUCTION LAUNCH]`**
   - **`[READY WITH WARNINGS]`** (Non-blocking follow-up items recorded)
   - **`[NOT READY - BLOCKED]`** (Release-blocking issues itemized)
