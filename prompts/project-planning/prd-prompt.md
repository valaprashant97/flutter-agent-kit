# PRD Creation & Scoping Prompt

You are acting as a Principal Product Manager and Mobile/Desktop Software Architect experienced in taking Flutter products from idea to production under the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application**: [DESCRIBE APP NAME, DOMAIN & CONCEPT]
- **Target Platforms**: [Windows Desktop, Android, iOS, Web, macOS, Linux]
- **Target Audience**: [PRIMARY USERS, TECHNICAL PROFILE, OPERATING CONTEXT]

---

## 2. OBJECTIVE
Create a complete, production-grade `PRD.md` (Product Requirements Document) based on `templates/PRD.md` that serves as the deterministic source of truth for downstream architecture, design, and implementation workflows.

---

## 3. EXISTING BEHAVIOR
- Greenfield: No existing implementation; requirements must be established from scratch.
- Brownfield: [DESCRIBE CURRENT STATE, EXISTING FEATURES, OR DEFICIENCIES BEING ADDRESSED]

---

## 4. REQUIRED INVESTIGATION
1. Inspect reference materials, domain models, or competitor benchmarks if provided.
2. Verify platform capabilities and constraints (e.g. Windows system tray vs mobile background services).
3. Identify dependencies between core user journeys.

---

## 5. CONSTRAINTS
- Do not generate Dart implementation code in this planning phase.
- Scope must clearly separate **MVP (P0)** from **Post-MVP (P1/P2)**.
- Do not invent speculative features or unnecessary abstractions.
- All non-functional requirements must have measurable numeric thresholds (e.g. cold start < 1.5s, 60fps).

---

## 6. ACCEPTANCE CRITERIA
- [ ] Problem statement and value proposition clearly articulated.
- [ ] Numbered functional requirements (FR-1, FR-2, etc.) with explicit user journeys.
- [ ] Non-functional requirements defined (Performance, Security, Offline, Accessibility).
- [ ] Screen inventory with the 4 mandatory UI states (Loading, Success, Empty, Error) for each screen.
- [ ] Out-of-scope backlog explicitly itemized.

---

## 7. EDGE CASES
- Network unavailability and offline degradation requirements.
- Session timeout and unauthorized access handling.
- Window resizing, high-DPI scaling, and multi-monitor movement (desktop).
- Background process suspension and state restoration (mobile).

---

## 8. TESTING REQUIREMENTS
- Define acceptance test criteria for every functional requirement.
- Identify user flows requiring end-to-end integration tests.

---

## 9. EXPECTED OUTPUT
A complete, beautifully formatted Markdown document ready to save directly as `docs/PRD.md` matching the structure in `templates/PRD.md`.
