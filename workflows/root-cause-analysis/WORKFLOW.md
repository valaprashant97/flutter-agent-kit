# Workflow: Root Cause Analysis (RCA) & Post-Incident Engineering

This workflow guides an AI coding agent through conducting a rigorous Root Cause Analysis (RCA), preventing defect recurrence, and authoring post-incident engineering reports for Flutter applications.

---

## 1. Entry Conditions
- A critical bug, production incident, data loss issue, or regression has been identified or resolved.
- Stakeholders require an architectural explanation and prevention strategy.

---

## 2. Step-by-Step Procedure

### Phase 1: The 5-Whys Deep Diagnostic Analysis
Apply the 5-Whys methodology to trace from the superficial symptom down to the underlying systemic failure:
1. **Why did the app crash?** (e.g. `LateInitializationError: Field '_db' has not been initialized`).
2. **Why was `_db` uninitialized?** (e.g. `initDatabase()` was called asynchronously in `initState()` without awaiting).
3. **Why did the widget build before the database opened?** (e.g. The widget did not display a loading state while the database was connecting).
4. **Why was the loading state omitted?** (e.g. The screen was built as a `StatefulWidget` calling the database directly rather than subscribing to a state controller).
5. **Why was business logic in the UI?** (Systemic: Architecture standard not enforced during initial feature PR).

### Phase 2: Impact Assessment
1. **Severity Assessment**:
   - P0 (Blocker: Data corruption, security breach, total crash loop).
   - P1 (Critical: Core user flow broken, widespread crash on specific platform).
   - P2 (Major: Edge case crash, workaround exists).
   - P3 (Minor: Cosmetic / non-blocking).
2. **Blast Radius**: Determine affected platforms (Windows, Android, iOS), app versions, and user cohorts.

### Phase 3: Corrective & Preventative Action (CAPA)
1. **Immediate Remediation**: Surgical fix applied to resolve the defect (`core/change-discipline.md`).
2. **Automated Defense**:
   - Regression test authored in `test/` that would have caught the issue.
   - Static analysis lint added to `analysis_options.yaml` if applicable.
3. **Architectural Hardening**:
   - Refactor vulnerable pattern into a compile-time safe primitive (e.g. replace `late` with nullable or dependency injection).

### Phase 4: Authoring the RCA Document
Document the incident in `docs/RCA_<INCIDENT_ID>.md`:
- Incident Overview & Timeline
- Root Cause (Technical Mechanism & Contributing Factors)
- Immediate Fix Applied
- Preventative Actions & Follow-Up Tasks
- Verification & Test Evidence

---

## 3. Exit Criteria & Quality Gates
- [ ] 5-Whys analysis identifies the systemic root cause, not just the symptom.
- [ ] Automated regression test is committed and passing.
- [ ] Preventative actions (linters, architectural guards) are established.
- [ ] Full RCA report is documented and committed.

---

## 4. Related Skills & Rules
- `skills/debugging/`
- `skills/error-handling/`
- `skills/testing/`
- `core/verification-policy.md`
