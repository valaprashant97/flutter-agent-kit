# Workflow: Production Launch Audit (50-Point Pre-Flight)

This workflow defines the final go/no-go quality gate before releasing a Flutter application to end users or App Stores.

---

## 1. Entry Conditions
- Release candidate compiled and packaged.
- Staging smoke tests executed.

---

## 2. The 50-Point Verification Checklist

### Category A: Functional Correctness & Real Data Integrity (10 Points)
- [ ] 1. Core user journeys pass end-to-end without manual intervention or mock data.
- [ ] 2. Form validation enforces email format, minimum password length, and required fields.
- [ ] 3. All 4 UI states (Loading, Success, Empty, Error) render properly; empty states show honest empty UI with a call-to-action (zero dummy records inserted).
- [ ] 4. Error banners provide actionable Retry callbacks without displaying fake successful data.
- [ ] 5. Search filtering returns expected matches without case sensitivity bugs.
- [ ] 6. Pagination correctly handles end-of-list conditions without duplicate records.
- [ ] 7. In-app navigation history supports browser/OS back gestures.
- [ ] 8. Deep links route to intended screens from cold launch and background state.
- [ ] 9. Zero hardcoded sample records, fake metrics, or random numbers exist in `lib/` (`docs/REAL_DATA_INTEGRITY.md`).
- [ ] 10. Data mutations persist to disk across complete application restart.

### Category B: UI / UX & Responsive Design (10 Points)
- [ ] 11. Zero `RenderFlex` overflow warnings across all tested screen sizes.
- [ ] 12. Layouts tested at Mobile (375px), Tablet (768px), and Desktop (1200px+).
- [ ] 13. Light theme displays high-contrast typography on all surfaces.
- [ ] 14. Dark theme displays high-contrast typography without inverted unreadable text.
- [ ] 15. Dynamic font scaling (1.5x, 2.0x) does not clip or truncate critical text.
- [ ] 16. Touch targets meet minimum 48x48dp (mobile) and 32x32dp (desktop).
- [ ] 17. Interactive elements provide ripple or visual click feedback.
- [ ] 18. Mouse hover feedback (`MouseRegion`) operational on desktop platforms.
- [ ] 19. Keyboard shortcuts functional on desktop (Ctrl+S, Ctrl+F, Esc).
- [ ] 20. High-DPI display scaling (125%, 150%, 200%) renders crisp vector assets.

### Category C: Security & Privacy (10 Points)
- [ ] 21. Zero hardcoded private API keys, secrets, or passwords in source code.
- [ ] 22. Authentication tokens (JWT, refresh tokens) stored in `FlutterSecureStorage`.
- [ ] 23. Plaintext HTTP traffic disabled; all endpoints enforce HTTPS.
- [ ] 24. SSL certificate validation active in release builds (no dummy callbacks).
- [ ] 25. Platform manifests request only strictly necessary permissions.
- [ ] 26. iOS `PrivacyInfo.xcprivacy` manifest declares all accessed API categories.
- [ ] 27. User passwords never logged in console outputs or analytics.
- [ ] 28. SQL queries parameterized to eliminate injection vulnerabilities.
- [ ] 29. WebViews restrict unauthorized domain navigation; mock fixtures are 100% isolated to `test/` (zero test imports in `lib/`).
- [ ] 30. Logout purges all cached user tokens, secure storage, and local DB rows.

### Category D: Performance & Resilience (10 Points)
- [ ] 31. Scrolling 1,000-item lists maintains 60 FPS / 120 FPS without jank.
- [ ] 32. Heavy JSON parsing and image processing offloaded to `Isolate.run()`.
- [ ] 33. All `AnimationController`, `TextEditingController`, and `FocusNode` instances disposed.
- [ ] 34. All `StreamSubscription` instances cancelled in `dispose()`.
- [ ] 35. High-resolution images decoded with `cacheWidth` and `cacheHeight` constraints.
- [ ] 36. Const constructors maximized across static widget subtrees.
- [ ] 37. Offline mode functions gracefully using cached local database records.
- [ ] 38. Network loss during an active request triggers user-friendly retry banners.
- [ ] 39. Application memory usage remains stable across screen push/pop cycles.
- [ ] 40. App cold launch time remains under 2.0 seconds on target devices.

### Category E: Build, Packaging & Platform Integration (10 Points)
- [ ] 41. Code obfuscation (`--obfuscate`) and symbol splitting enabled on release build.
- [ ] 42. Generated debug symbol files securely archived for crash deobfuscation.
- [ ] 43. Windows MSIX package generated with valid publisher identity and icons.
- [ ] 44. Windows system tray minimization keeps process alive without taskbar clutter.
- [ ] 45. Windows native toast notifications trigger and restore application focus.
- [ ] 46. Crash reporting SDK (Sentry / Crashlytics) initializes and receives test events.
- [ ] 47. App version and build number incremented in `pubspec.yaml`.
- [ ] 48. `CHANGELOG.md` updated with user-facing release notes.
- [ ] 49. Clean installation and uninstallation verified on target platforms.
- [ ] 50. `flutter analyze` passes with 0 errors and 0 warnings.

---

## 3. Formal Launch Verdict
Based on the checklist, issue one of three verdicts:
1. **READY FOR LAUNCH**: All 50 points satisfied; zero blockers.
2. **READY WITH WARNINGS**: Minor non-blocking polish items noted; no security or crash risks.
3. **NOT READY (BLOCKERS)**: Any Critical defect (crash, data loss, secret leak, compile failure). Release prohibited.

---

## 4. Related Skills & Rules
- `skills/production-readiness/`
- `skills/real-data-integrity/`
- `skills/security-audit/`
- `skills/performance/`
- `skills/performance-engineering/`
- `docs/REAL_DATA_INTEGRITY.md`
- `docs/PERFORMANCE_ENGINEERING_STANDARDS.md`

