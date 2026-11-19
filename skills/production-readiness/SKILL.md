---
name: production-readiness
description: Comprehensive 50-point pre-flight launch audit covering correctness, security, performance, crash analytics, and compliance.
---

# production-readiness

## 1. Skill Name
`production-readiness`

## 2. Purpose
Provides an exhaustive, 50-point pre-launch verification checklist for certifying that a Flutter application is resilient, secure, performant, and compliant before releasing it to public App Stores or enterprise users.

## 3. When to Use
- Immediately prior to publishing a release candidate.
- When conducting a formal go/no-go production launch review.
- When an engineering lead requires a final quality sign-off.

## 4. When Not to Use
- During active early feature development or spike prototyping.

## 5. Required Project Context
- Release candidate build, test suite, and configuration documentation (`docs/PRD.md`, `docs/ARCHITECTURE.md`, `docs/SECURITY.md`).

## 6. Step-by-Step Workflow
1. **Execute Static Analysis Gate**: Run `flutter analyze`. Must produce 0 errors, 0 warnings, 0 lints.
2. **Execute Automated Test Gate**: Run `flutter test`. Full test suite must pass with 100% green status.
3. **Audit Crash Reporting**: Verify error telemetry (e.g., Sentry, Firebase Crashlytics) captures release exceptions and debug symbols are uploaded.
4. **Audit Offline & Error States**: Test app behavior in airplane mode, slow network, and on database error. Confirm all screens show friendly error banners with retry buttons.
5. **Audit Security & Secrets**: Verify no API keys, private tokens, or test credentials exist in compiled binaries or git history.
6. **Compile Release Binary**: Execute release compilation on target platforms (e.g., `flutter build windows --release`, `flutter build appbundle --release`).
7. **Issue Launch Verdict**: Issue formal verdict: **READY FOR LAUNCH**, **READY WITH WARNINGS**, or **NOT READY (BLOCKERS)**.

## 7. Engineering Rules
- **Zero Dummy Data Audit**: Verify zero hardcoded sample records, fake users, static arrays, or fake metrics exist in `lib/`. Confirm all mocks are isolated strictly to `test/` (`docs/REAL_DATA_INTEGRITY.md`).
- **Zero Blockers Permitted**: If any Critical issue (crash, data loss risk, secret leak) is detected, the launch verdict must be **NOT READY**.
- **No Theoretical Passes**: Do not assume something works because code exists; verify it through automated tests or manual smoke testing.

## 8. Code Examples
```bash
# Comprehensive Production Pre-Flight Command Sequence
flutter clean
flutter pub get
flutter analyze --fatal-infos
flutter test --coverage
flutter build windows --release
```

## 9. Common Mistakes
- Testing only on high-end developer machines and discovering catastrophic jank or memory crashes on low-end devices.
- Forgetting to replace development API URLs (`https://api.dev...`) with production endpoints.
- Leaving test accounts or bypass flags enabled in production builds.

## 10. Testing and Verification
- Run the full verification suite across all release targets.
- Verify crash analytics receive test events in release mode.

## 11. Completion Criteria
- 50-point production checklist completed and signed off in `docs/MEMORY.md`.
- Formal launch verdict issued.
- Release candidate compiles with zero errors.

## 12. Related Skills
- `coding-standards` — Production Readiness (Section 12) of `docs/FLUTTER_CODING_STANDARDS.md`
- `real-data-integrity`
- `packaging`
- `security-audit`
- `performance`
- `code-review`
