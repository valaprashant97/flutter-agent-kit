# Production Monitoring & Crash Telemetry Prompt

You are acting as a Site Reliability Engineer (SRE) and Observability Specialist for client applications guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application**: [APP NAME & VERSION]
- **Target Platforms**: [Windows Desktop, Android, iOS, Web, macOS, Linux]
- **Observability Standards**: `rules/error-handling/global-error-handling.md`, `skills/error-handling/`

---

## 2. OBJECTIVE
Implement end-to-end production monitoring, crash reporting, telemetry breadcrumb capture, and performance tracing (Sentry or Firebase Crashlytics) in modern Flutter with strict PII scrubbing.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE CURRENT MONITORING STATUS: ZERO CRASH REPORTING, MISSING SYMBOLS, OR UNCAUGHT EXCEPTIONS SWALLOWED SILENTLY]

---

## 4. REQUIRED INVESTIGATION
1. Inspect `pubspec.yaml` for observability SDKs (`sentry_flutter`, `firebase_crashlytics`, or custom telemetry).
2. Check `main.dart` error initialization hooks.
3. Review network interceptors to verify error telemetry forwarding.

---

## 5. CONSTRAINTS
- Modern Flutter dual hook architecture required: `FlutterError.onError` for framework errors + `PlatformDispatcher.instance.onError` for asynchronous exceptions.
- Zero PII in telemetry: Authorizations headers, passwords, credit card numbers, and raw user inputs must be scrubbed.
- Never crash the application if the telemetry provider itself throws an exception.
- Deobfuscation debug symbol tables must be linked to release build pipelines.

---

## 6. ACCEPTANCE CRITERIA
- [ ] `FlutterError.onError` and `PlatformDispatcher.instance.onError` configured in `main()`.
- [ ] Graceful fallback error screen configured via `ErrorWidget.builder`.
- [ ] Navigation breadcrumbs and network error statuses tracked.
- [ ] Sensitive headers and tokens automatically scrubbed from event payloads.
- [ ] Release symbol upload automated in build scripts.

---

## 7. EDGE CASES
- Crash occurs during early application initialization before the telemetry SDK connects.
- Device is offline during a fatal exception (crashes must be cached locally and flushed upon next launch).
- High-frequency error bursts causing telemetry quota exhaustion (rate limiting / sampling required).

---

## 8. TESTING REQUIREMENTS
- Unit test verifying PII sanitization regex strips `Bearer ...` tokens and passwords.
- Verify test exception triggers telemetry recording in staging environment.

---

## 9. EXPECTED OUTPUT
1. Observability and crash reporting architecture plan.
2. Complete `main.dart` and telemetry service implementation.
3. Verification results proving error interception and PII sanitization.
