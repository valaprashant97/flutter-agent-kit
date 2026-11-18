# Professional Software Development Standards: Mandatory 15-Phase SDLC & Task Management

This document defines the production-grade software engineering, 15-phase Software Development Lifecycle (SDLC), task management, in-project documentation architecture, and incremental development standard for the **Flutter Agent Kit**. All AI coding agents (**Cursor**, **Claude Code**, **Gemini CLI**, **GitHub Copilot**, **OpenAI Codex**, **Antigravity**) must strictly adhere to these standards across all software projects, including Flutter, Dart, React, Next.js, Node.js, Python, Go, and other stacks.

---

## 1. Core Engineering Philosophy & Master Invariant

$$\textbf{IDEA \& RESEARCH} \longrightarrow \textbf{PRD \& REQUIREMENTS} \longrightarrow \textbf{USER FLOW} \longrightarrow \textbf{WIREFRAME \& UI/UX} \longrightarrow \textbf{DESIGN SYSTEM} \longrightarrow \textbf{TECHNICAL ARCHITECTURE} \longrightarrow \textbf{DATABASE \& API DESIGN} \longrightarrow \textbf{TASK BREAKDOWN} \longrightarrow \textbf{PROJECT SETUP} \longrightarrow \textbf{DEVELOPMENT} \longrightarrow \textbf{INTEGRATION} \longrightarrow \textbf{TESTING \& QA} \longrightarrow \textbf{SECURITY \& OPTIMIZATION} \longrightarrow \textbf{DEPLOYMENT} \longrightarrow \textbf{MONITORING \& MAINTENANCE}$$

> [!IMPORTANT]
> **NEVER attempt to complete a large, complex software project in one massive coding operation.**
> AI coding agents must never produce sprawling, unverified multi-file diffs. Every project must be developed systematically through disciplined upfront analysis, structured in-project documentation, granular independent tasks, incremental implementation slices, automated verification, and continuous progress recording.
>
> The 15-phase workflow is the **DEFAULT** development workflow for all new software projects and major product development tasks.

---

## 2. The Mandatory 15-Phase Professional SDLC

Every new product or major feature initiative must proceed through these 15 distinct, sequential phases:

### Phase 01: Idea & Research
- **Purpose**: Understand the product idea, user need, and market context before development starts.
- **Key Activities**:
  1. Understand the core problem being solved.
  2. Identify primary and secondary target users.
  3. Research user needs, pain points, and expectations.
  4. Analyze competitors and alternatives where relevant.
  5. Identify the product's unique value proposition.
  6. Evaluate technical feasibility and platform constraints.
  7. Identify project scope, boundaries, and resource/timeline constraints.
  8. Define the Minimum Viable Product (MVP) vs. future possibilities.
- **Deliverables**:
  - `docs/PROJECT_OVERVIEW.md`: Product vision, target users, value proposition, and MVP scope.
  - `docs/RESEARCH.md`: Competitive analysis, market/technical feasibility research (when required).
- **Completion Gate**: Clear, verified understanding of the problem, target users, and MVP boundaries.

### Phase 02: PRD & Requirements
- **Purpose**: Formalize product and technical requirements into concrete specifications.
- **Key Activities**:
  1. Define measurable product objectives and business metrics.
  2. Define user personas, roles, and granular permissions.
  3. Detail functional requirements (feature by feature).
  4. Detail non-functional requirements (performance, accessibility, security, scalability, uptime).
  5. Explicitly define MVP scope vs. out-of-scope features.
  6. Define success criteria and acceptance thresholds.
  7. Document assumptions, technical constraints, and pending decisions.
- **Deliverables**:
  - `docs/PRD.md`: Formal Product Requirements Document.
  - `docs/TRD.md`: Technical Requirements Document covering non-functional limits and integration constraints.
- **Completion Gate**: Complete, unambiguous requirements baseline with explicit acceptance criteria.

### Phase 03: User Flow
- **Purpose**: Plan how users navigate and interact with the application.
- **Key Activities**:
  1. Identify all required screens, modal surfaces, and dialogs.
  2. Define navigation structure (bottom bar, drawer, tab bar, breadcrumbs, app router).
  3. Define primary user journeys (onboarding, authentication, core feature flows).
  4. Create screen-to-screen navigation flows using Mermaid state/flow diagrams.
  5. Map user actions to expected system outcomes.
  6. Define authentication, session recovery, password reset, and logout flows.
  7. Map universal state transitions: loading, empty, partial, success, and error states.
  8. Identify critical edge cases (network loss, permission denial, invalid parameters).
- **Deliverables**:
  - `docs/USER_FLOW.md`: Navigation state machine, screen transitions, and user journeys.
  - `docs/SCREEN_LIST.md`: Exhaustive index of all screens, routes, and modal surfaces.
- **Completion Gate**: Full screen inventory and verified navigation diagram with zero dead ends.

### Phase 04: Wireframe & UI/UX
- **Purpose**: Plan the complete user interface and information architecture before implementing production code.
- **Key Activities**:
  1. Create structured low-fidelity textual or visual wireframes for every screen.
  2. Establish content hierarchy, visual weighting, and scanning patterns.
  3. Position navigation elements, primary action buttons, and secondary controls.
  4. Define form layouts, field groupings, input sequencing, and inline validation placements.
  5. Define interaction behaviors (gestures, swipe-to-dismiss, scroll actions, tap targets).
  6. Plan responsive viewport adaptations (mobile, tablet, desktop, ultra-wide).
  7. Identify reusable interface elements and templates.
  8. Review accessibility: minimum tap target size ($48 \times 48\text{ pt}$), WCAG 2.1 AA contrast, and screen reader flow.
- **Deliverables**:
  - `docs/WIREFRAME.md`: Structural layout wireframes for all major screens and modals.
  - `docs/UI_UX_SPECIFICATION.md`: Interaction specifications, gesture behaviors, and accessibility rules.
- **Completion Gate**: Wireframe layout approved; content hierarchy and responsive breakpoints locked.

### Phase 05: Design System
- **Purpose**: Establish a coherent, cohesive visual design system before implementing UI code.
- **Key Activities**:
  1. Establish visual direction and archetype (Clean Utility, Modern Minimal, Data-Dense).
  2. Define semantic color palette: primary, secondary, surface, background, error, warning, success, info.
  3. Define typography hierarchy: display, headline, title, body, and label styles with explicit line heights.
  4. Define 4pt/8pt modular spacing grid (none: 0, xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48).
  5. Define elevation, shadows, border radii, and stroke weights.
  6. Define button hierarchy: Primary (Filled), Secondary (Tonal/Outlined), Tertiary (Text), Destructive.
  7. Define card, container, and dialog styling rules.
  8. Define iconography rules (consistent icon family, filled vs. outlined, semantic sizing).
  9. Define light and dark theme token variants.
  10. Define purposeful animation curves, micro-interactions, and duration constants ($150\text{--}300\text{ ms}$).
  11. Define accessible contrast ratios ($\ge 4.5:1$ for normal text, $\ge 3:1$ for large text).
  12. Define reusable atomic component tokens.
- **Deliverables**:
  - `docs/DESIGN.md`: Comprehensive design token specification.
- **Completion Gate**: All UI tokens defined. *Rule: All future UI development must strictly follow `DESIGN.md`.*

### Phase 06: Technical Architecture
- **Purpose**: Plan the complete technical structure, module boundaries, and data flow.
- **Key Activities**:
  1. Select an appropriate technology stack based on objective requirements.
  2. Define application architecture (Clean Architecture, Feature-First, Modular).
  3. Define frontend structure: presentation, business logic, domain entities, and data sources.
  4. Define backend structure: controllers, application services, domain models, and repositories.
  5. Define module responsibilities, dependency inversion, and directory structure.
  6. Select and document state management pattern and lifecycle management.
  7. Define application data flow (unidirectional data flow, reactive streams).
  8. Establish global and domain-specific error handling strategies (sealed result types, error boundaries).
  9. Define security boundaries, authentication token handling, and secret isolation.
  10. Formulate scalability, caching, offline capability, and memory management strategies.
- **Deliverables**:
  - `docs/ARCHITECTURE.md`: High-level system architecture, module boundaries, and folder structure.
  - `docs/TECH_STACK.md`: Technology stack selection matrix with technical rationale (when useful).
- **Completion Gate**: Approved architecture and module boundaries with zero cyclic dependencies.

### Phase 07: Database & API Design
- **Purpose**: Design the application's data layer, persistence models, and communication interfaces.
- **Key Activities**:
  1. Select database technology (Drift, SQLite, PostgreSQL, Hive, Firestore).
  2. Define database schema: entities, tables, collections, foreign keys, and relationships.
  3. Define primary keys, composite keys, unique constraints, and database indexes.
  4. Define data validation invariants and nullability constraints.
  5. Define API endpoints, REST/GraphQL contracts, query parameters, and payload structures.
  6. Define request and response schemas with typed error codes.
  7. Define authentication protocols (JWT, OAuth2, session cookies, API keys) and authorization scopes.
  8. Define third-party integrations, webhook contracts, and rate limiting policies.
  9. Define database migration strategies and seed data procedures (real data format, zero mock junk).
  10. Define backup, replication, and disaster recovery requirements.
- **Deliverables**:
  - `docs/DATABASE.md`: Relational schema, ER diagram, indexes, constraints, and migration plan.
  - `docs/API.md`: API endpoint specifications, request/response models, and error envelopes.
- **Completion Gate**: Complete, unambiguous data schema and API contract specifications.

### Phase 08: Task Breakdown
- **Purpose**: Convert the approved project plan into small, manageable implementation tasks.
- **Key Activities**:
  1. Divide development into sequential phases and modules.
  2. Decompose features into atomic implementation tasks (1-2 files per task).
  3. Identify cross-task dependencies and construct the execution DAG.
  4. Assign task priorities (`Critical`, `High`, `Medium`, `Low`).
  5. Establish explicit acceptance criteria and testing requirements for every task.
  6. Ensure every task adheres to the **13 Mandatory Schema Fields**:
     - `Task ID` (e.g. `TASK-001`, `TASK-042`)
     - `Title`
     - `Description`
     - `Objective`
     - `Requirements`
     - `Files/Modules Affected`
     - `Dependencies`
     - `Implementation Steps`
     - `Acceptance Criteria`
     - `Testing Requirements`
     - `Expected Outcome`
     - `Priority`
     - `Status` (`Not Started`, `In Progress`, `Blocked`, `Testing`, `Completed`)
- **Deliverables**:
  - `tasks/IMPLEMENTATION_PLAN.md`: Phase breakdown, milestones, risk mitigation, and verification gates.
  - `tasks/TASKS.md`: Master task registry containing all tasks with 13 mandatory schema fields.
  - `tasks/phases/`: Detailed phase breakdown documents (`PHASE_01.md`, etc.).
- **Completion Gate**: All tasks registered with valid dependencies. *Rule: Never implement an entire project in one operation.*

### Phase 09: Project Setup
- **Purpose**: Initialize or prepare the local development environment and tooling.
- **Key Activities**:
  1. Inspect existing project repository before making modifications.
  2. Initialize project foundation (if greenfield) or configure missing dependencies.
  3. Configure dependencies and pin exact versions (`pubspec.yaml`, `package.json`, `pyproject.toml`).
  4. Configure development tools, scripts, and build tasks.
  5. Configure environment variables and template `.env.example`.
  6. Configure Git repository, branches, and commit conventions.
  7. Configure linting, formatting, and static analysis tools (`analysis_options.yaml`, `.eslintrc`, `ruff.toml`).
  8. Configure testing frameworks, mock helpers, and test runners.
  9. Configure `.gitignore` to protect private AI documentation (`/docs/`, `/tasks/`, `/MEMORY.md`, etc.).
  10. Verify baseline project compiles and builds with zero errors.
- **Deliverables**:
  - Working project foundation compiling cleanly.
  - Root `AGENTS.md` with permanent agent directives.
  - Root `.gitignore` with verified AI documentation exclusions.
  - Root `README.md` with developer onboarding instructions.
- **Completion Gate**: Clean compilation, linter pass, and verified `.gitignore` protection.

### Phase 10: Development
- **Purpose**: Implement features incrementally according to `tasks/TASKS.md`.
- **Key Activities**:
  1. Select exactly one unblocked task from `tasks/TASKS.md` whose prerequisites are completed.
  2. Read relevant specifications (`docs/PRD.md`, `docs/DESIGN.md`, `docs/ARCHITECTURE.md`).
  3. Inspect relevant source code files before modifying them.
  4. Implement the minimal vertical slice satisfying the task requirements.
  5. Comply strictly with established design tokens from `docs/DESIGN.md`.
  6. Comply strictly with architectural patterns from `docs/ARCHITECTURE.md`.
  7. Reuse existing components, services, and domain models.
  8. Handle errors gracefully with typed failures and realistic empty/loading states.
  9. Write unit and component tests verifying the implementation.
  10. Execute the **Mandatory Task Execution Loop**:
      $$\text{READ} \longrightarrow \text{UNDERSTAND} \longrightarrow \text{PLAN} \longrightarrow \text{IMPLEMENT} \longrightarrow \text{TEST} \longrightarrow \text{REVIEW} \longrightarrow \text{FIX} \longrightarrow \text{DOCUMENT} \longrightarrow \text{VERIFY} \longrightarrow \text{MARK COMPLETED}$$
- **Deliverables**:
  - Working source code and accompanying test files.
  - Updated `tasks/TASKS.md` with task set to `Completed`.
  - Updated `MEMORY.md` reflecting active phase, completed tasks, and next steps.
- **Completion Gate**: 12-point task completion verification checklist satisfied.

### Phase 11: Integration
- **Purpose**: Wire independently developed components into complete, functioning application workflows.
- **Key Activities**:
  1. Connect UI presentation layer with state managers and application controllers.
  2. Connect application services with local database and remote API clients.
  3. Integrate authentication state and token refresh loops with network clients.
  4. Wire cross-module communications, event buses, and deep linking routes.
  5. Verify end-to-end user navigation flows from `docs/USER_FLOW.md`.
  6. Verify data flow from user input through database persistence and UI refresh.
  7. Verify error propagation: ensure network failures and database exceptions display friendly UI.
  8. Verify state preservation across app pauses, route changes, and configuration changes.
- **Deliverables**:
  - Fully wired application workflows with zero orphan components.
- **Completion Gate**: All primary user journeys work seamlessly end-to-end.

### Phase 12: Testing & QA
- **Purpose**: Perform systematic, multi-tiered quality assurance.
- **Key Activities**:
  1. Execute automated unit test suites for business logic, utilities, and models.
  2. Execute widget/component tests verifying UI rendering and state responses.
  3. Execute integration tests verifying multi-component workflows and database operations.
  4. Execute end-to-end (E2E) tests simulating real user journeys.
  5. Test happy paths and boundary conditions.
  6. Test invalid inputs, validation failures, and malformed network responses.
  7. Test dynamic empty states, loading skeletons, and retryable error cards.
  8. Test simulated network failures, timeouts, and offline degradation.
  9. Test user permissions, role enforcement, and token expiry.
  10. Perform visual regression and platform compatibility verification.
- **Deliverables**:
  - `docs/TEST_PLAN.md`: Test strategy, coverage matrix, and test execution results.
  - Test execution logs confirming 100% pass rate.
  - Updated bug register with root cause and verified fixes.
- **Completion Gate**: All tests pass; zero blocking defects; static analysis returns 0 errors.

### Phase 13: Security & Optimization
- **Purpose**: Harden the application against vulnerabilities and optimize runtime performance.
- **Key Activities**:
  1. **Security Audit**:
     - Audit authentication, session management, and authorization enforcement.
     - Audit API security, HTTPS enforcement, and header protections.
     - Verify secret isolation (no hardcoded API keys, tokens, or private keys).
     - Audit input validation and sanitization (SQL injection, XSS prevention).
     - Verify data encryption at rest and in transit.
     - Check third-party dependencies for known vulnerabilities (`npm audit`, `dart pub audit`).
     - Audit logging to prevent sensitive data leaks (PII, credentials).
  2. **Performance Engineering**:
     - Optimize database queries, missing indexes, and unindexed joins.
     - Profile memory allocations and eliminate memory leaks (unclosed streams, listeners, controllers).
     - Optimize UI rendering performance (eliminate jank, maintain 60/120 FPS frame budget).
     - Minimize widget rebuild scopes and enforce pure `build()` methods.
     - Optimize image decoding (`cacheWidth`/`cacheHeight`) and asset compression.
     - Offload heavy compute tasks to background threads or isolates.
     - Implement caching strategies (HTTP cache headers, memory cache, disk cache).
- **Deliverables**:
  - `docs/SECURITY.md`: Security architecture, vulnerability audit findings, and mitigations.
  - Performance profiling report with measured metrics before and after optimization.
- **Completion Gate**: Zero critical security vulnerabilities; performance targets met.

### Phase 14: Deployment
- **Purpose**: Prepare, package, verify, and release production builds.
- **Key Activities**:
  1. Configure production environment variables and release configs.
  2. Generate release builds with production optimizations, minification, and tree-shaking.
  3. Verify production database migrations against staging environments.
  4. Configure platform-specific packaging:
     - **Flutter Windows**: MSIX packaging, Win32 executable signing, installer generation.
     - **Flutter Android**: Android App Bundle (AAB), ProGuard/R8 rules, keystore signing.
     - **Flutter iOS/macOS**: Xcode archive, provisioning profiles, entitlements.
     - **Web / Full-Stack**: Containerization (Docker), CDN assets, HTTPS configuration, CI/CD pipelines.
  5. Verify release build execution in a clean sandbox environment.
  6. Prepare user-facing release notes in `CHANGELOG.md`.
  7. Establish automated rollback strategy and contingency plan.
- **Deliverables**:
  - Production-ready release artifacts (MSIX, AAB, IPA, Docker image, static bundle).
  - Updated `CHANGELOG.md` with version notes.
  - Deployment runbook and rollback plan.
- **Completion Gate**: Production build succeeds; release candidate verified in clean environment.

### Phase 15: Monitoring & Maintenance
- **Purpose**: Maintain system health, monitor performance, and manage defects post-release.
- **Key Activities**:
  1. Monitor real-time application errors, exceptions, and crash telemetry.
  2. Monitor API performance, server latencies, and database query health.
  3. Track user-reported defects, reproduction steps, and root-cause analyses.
  4. Maintain and update dependencies, addressing deprecations and security patches.
  5. Implement and verify bug fixes using the disciplined sequential task execution loop.
  6. Maintain and synchronize in-project documentation with production code reality.
  7. Update persistent memory (`MEMORY.md`) and task roadmap (`TASKS.md`).
- **Deliverables**:
  - Updated `CHANGELOG.md` with patch notes.
  - Root cause analysis reports and maintenance records.
  - Synchronized `MEMORY.md` and `TASKS.md`.
- **Completion Gate**: Application health verified; error tracking operational; docs updated.

---

## 3. Workflow Execution Rules

1. **Exact Phase Order for New Projects**: Greenfield projects must follow the 15-phase sequence in exact order (Phase 01 $\to$ Phase 15).
2. **Never Skip Planning**: Never start production implementation (Phase 10) before Requirements (Phase 02), Design System (Phase 05), Architecture (Phase 06), and Tasks (Phase 08) are defined.
3. **Proportional Scope Handling**:
   - **Small Tasks** (1 file, localized fix): Skip directly to Phase 10 with lightweight testing and immediate verification.
   - **Medium Tasks** (single module, 2-5 tasks): Execute Phases 02, 06, 08, 10, 12.
   - **Large Projects / Greenfield Products**: Execute all 15 phases thoroughly.
4. **Existing Projects (Brownfield)**: Never restart from Phase 01 automatically. Perform the **6-Step Brownfield Discovery**:
   1. Analyze existing codebase structure and dependencies.
   2. Identify already completed phases.
   3. Inspect existing documentation in `docs/` and root.
   4. Identify missing, incomplete, or outdated deliverables.
   5. Determine current active phase.
   6. Resume execution from that phase while preserving existing code and conventions.
5. **No Redundant Re-creation**: Never recreate completed phases or rewrite functioning code without explicit justification.
6. **Approval Checkpoints**: Provide clear summaries and request user confirmation at major planning milestones (after Phase 02 PRD, Phase 05 Design System, Phase 08 Task Breakdown).
7. **Requirement Change Invariant**: If requirements change during development, halt Phase 10, update Phases 02/06/08 documentation first, and only then resume implementation.
8. **Phase Dependency Preservation**: Tasks in downstream phases (e.g. Phase 11 Integration) cannot be executed until their prerequisite Phase 10 tasks are completed.
9. **Empirical Gate Verification**: A phase must never be marked completed without verifying all required deliverables.
10. **Accurate Tracking**: Maintain truthful phase tracking in `MEMORY.md` and task tracking in `tasks/TASKS.md`.

---

## 4. In-Project Documentation Architecture & Git Protection

### In-Project Directory Structure
All planning, architecture, task registries, and persistent memory documents must be maintained directly within the project root directory:
```
<project-root>/
├── docs/
│   ├── PROJECT_OVERVIEW.md     # Phase 01: Product vision & MVP scope
│   ├── RESEARCH.md             # Phase 01: Competitive & feasibility research
│   ├── PRD.md                  # Phase 02: Product Requirements Document
│   ├── TRD.md                  # Phase 02: Technical Requirements Document
│   ├── USER_FLOW.md            # Phase 03: Navigation state machine & journeys
│   ├── SCREEN_LIST.md          # Phase 03: Complete inventory of screens & routes
│   ├── WIREFRAME.md            # Phase 04: Screen layout wireframes & hierarchy
│   ├── UI_UX_SPECIFICATION.md  # Phase 04: Interaction specs & accessibility
│   ├── DESIGN.md               # Phase 05: Visual design tokens & styling rules
│   ├── ARCHITECTURE.md         # Phase 06: System architecture & folder layout
│   ├── TECH_STACK.md           # Phase 06: Stack selection rationale
│   ├── DATABASE.md             # Phase 07: Data schema, indexes & migrations
│   ├── API.md                  # Phase 07: Endpoints, contracts & payloads
│   ├── TEST_PLAN.md            # Phase 12: Test strategy, coverage & results
│   ├── SECURITY.md             # Phase 13: Security audit findings & rules
│   ├── DECISIONS.md            # Cross-cutting Architectural Decision Records (ADRs)
│   ├── MEMORY.md               # Persistent Agent Context & Next Steps
│   └── CHANGELOG.md            # Phase 14/15: User-facing releases & history
├── tasks/
│   ├── IMPLEMENTATION_PLAN.md  # Phase 08: Phased roadmap & milestones
│   ├── TASKS.md                # Phase 08: Master Task Registry (13-field schema)
│   └── phases/                 # Phase breakdowns (PHASE_01.md, etc.)
├── src/                        # Application source code
├── tests/                      # Automated test suites
├── AGENTS.md                   # Phase 09: Permanent AI Agent Directives
├── README.md                   # Phase 09: Developer onboarding guide
└── .gitignore                  # Phase 09: Git exclusion rules
```

### Git Protection Rules (.gitignore)
Private AI planning documents, internal task registries, and session notes must never be pushed to public Git remotes.
```gitignore
# ==============================================================================
# AI Development & Task Management (Local Only - Never Push to Remote)
# ==============================================================================
/docs/
/tasks/
/MEMORY.md
/DECISIONS.md
/IMPLEMENTATION_PLAN.md
/PROJECT_ANALYSIS.md
/TECHNICAL_ANALYSIS.md
```
*(Note: Keep public documentation such as `README.md`, `LICENSE`, and `CHANGELOG.md` tracked by Git. Keep `AGENTS.md` tracked unless specific project conventions dictate otherwise. Always verify with `git check-ignore`).*

---

## 5. Mandatory Task Execution Loop & 13-Field Schema

When implementing tasks in **Phase 10: Development**, the agent must execute one task at a time following the 10-step loop:
$$\text{READ} \longrightarrow \text{UNDERSTAND} \longrightarrow \text{PLAN} \longrightarrow \text{IMPLEMENT} \longrightarrow \text{TEST} \longrightarrow \text{REVIEW} \longrightarrow \text{FIX} \longrightarrow \text{DOCUMENT} \longrightarrow \text{VERIFY} \longrightarrow \text{MARK COMPLETED}$$

### 13 Mandatory Task Schema Fields
Every task in `tasks/TASKS.md` must contain:
1. `Task ID`: Unique stable identifier (e.g., `TASK-001`, `TASK-042`).
2. `Title`: Concise descriptive title.
3. `Description`: Summary of task scope.
4. `Objective`: Core technical purpose.
5. `Requirements`: Functional and non-functional requirements.
6. `Files/Modules Affected`: Specific file paths to create, modify, or delete.
7. `Dependencies`: Prerequisite task IDs that must be completed first.
8. `Implementation Steps`: Ordered, actionable steps.
9. `Acceptance Criteria`: Measurable conditions for success.
10. `Testing Requirements`: Unit, integration, or manual test specifications.
11. `Expected Outcome`: Observable state after completion.
12. `Priority`: `Critical`, `High`, `Medium`, or `Low`.
13. `Status`: Exactly one of: `Not Started`, `In Progress`, `Blocked`, `Testing`, `Completed`.

---

## 6. 12-Point Task Completion Verification Checklist
A task in Phase 10 is considered complete **ONLY** when all 12 items are verified:
1. [ ] Requirements fully implemented as specified.
2. [ ] Zero compiler/analyzer errors and clean static analysis.
3. [ ] All existing and new unit/widget/integration tests pass.
4. [ ] Edge cases handled gracefully (null values, timeouts, bounds).
5. [ ] No hardcoded fake dummy data where real data flow is required.
6. [ ] Proper error handling, logging, and user recovery UI implemented.
7. [ ] Security best practices followed (no hardcoded secrets or unprotected routes).
8. [ ] Performance and memory implications verified (no leaks, pure build methods).
9. [ ] Clean code adhering to existing project conventions.
10. [ ] `tasks/TASKS.md` updated with `Completed` status.
11. [ ] `MEMORY.md` updated with current context and next steps.
12. [ ] Documentation updated to reflect changes.

---

## 7. Failed Task Remediation Protocol
When a test fails, code will not compile, or an implementation breaks:
1. **Stop Immediately**: Do not start another task or write unrelated code.
2. **Reproduce & Isolate**: Run the failing test or command directly to inspect the exact stack trace.
3. **Analyze Root Cause**: Inspect the causal logic, not just the surface symptom.
4. **Formulate Minimal Fix**: Plan the smallest surgical correction that restores correctness without collateral side effects.
5. **Apply & Verify**: Implement the fix and rerun the exact failing test suite.
6. **Run Full Regression**: Run the entire project test suite to verify zero regressions.
7. **Document the Fix**: Record the root cause, fix, and prevention in `MEMORY.md` and `DECISIONS.md`.
