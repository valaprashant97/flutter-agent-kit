# Workflow: Product Requirements Discovery & PRD Generation

This workflow guides an AI coding agent through discovering, clarifying, scoping, and documenting complete product requirements for a Flutter application.

---

## 1. Entry Conditions
- User provides a raw feature request, user story, business objective, or high-level app idea.
- The project is starting greenfield or undergoing a major milestone expansion.

---

## 2. Step-by-Step Procedure

### Phase 1: Problem Discovery & Stakeholder Alignment
1. **Analyze User Intent**: Parse the user's prompt to identify the core problem, target audience, and primary value proposition.
2. **Clarify Ambiguities**: If key constraints (target platforms, offline requirements, authentication methods, monetization) are unspecified, ask targeted clarifying questions before writing code.
3. **Map User Personas**: Define primary user personas, their goals, frustrations, and device usage context (e.g. mobile on-the-go vs desktop multi-window power user).

### Phase 2: Feature Scope Matrix & MVP Boundary
1. **Differentiate MVP from Post-MVP**:
   - **Must-Have (P0 / MVP)**: Core user journey required for a viable first release.
   - **Should-Have (P1)**: High-value features deferred to iteration 2.
   - **Could-Have (P2)**: Nice-to-have enhancements.
   - **Won't-Have (Out of Scope)**: Explicitly defined out-of-scope items to prevent scope creep.
2. **Edge Case Identification**: Document network failure scenarios, offline handling, permission denials, and session timeouts.

### Phase 3: PRD Generation
1. Initialize or update `docs/PRD.md` using the template at `templates/PRD.md`.
2. Populate all sections:
   - Executive Summary & Problem Statement
   - User Personas & Core Journeys
   - Functional Requirements (numbered: FR-1, FR-2, ...)
   - Non-Functional Requirements (Performance, Security, Accessibility, Target Platforms)
   - Success Metrics & KPIs

### Phase 4: Downstream Handoff
1. Present the completed PRD summary to the user for review.
2. Once approved, proceed to `workflows/architecture-planning/` and `workflows/design-system/`.

---

## 3. Exit Criteria & Quality Gates
- [ ] `docs/PRD.md` is authored with zero vague placeholders (`TBD`, `TODO`).
- [ ] Target platforms (Windows, iOS, Android, Web, macOS, Linux) are explicitly defined.
- [ ] MVP boundaries are mutually agreed upon with the user.
- [ ] Functional requirements are numbered and testable.

---

## 4. Related Skills & Rules
- `skills/project-analysis/`
- `skills/flutter-architecture/`
- `core/project-understanding.md`
- `templates/PRD.md`
