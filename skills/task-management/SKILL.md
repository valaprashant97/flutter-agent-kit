---
name: task-management
description: Mandatory 15-phase professional software development lifecycle, in-project documentation architecture, large task breakdown, sequential execution loop, gitignore protection, and incremental development workflow.
---

# task-management

## 1. Skill Name
`task-management`

## 2. Purpose
Provides a disciplined, production-grade 15-phase Software Development Lifecycle (SDLC) for AI coding agents to plan, document, decompose, implement, test, integrate, deploy, and maintain software projects across Flutter, Dart, and cross-platform stacks.

This 15-phase workflow is the **DEFAULT** development lifecycle for all new software projects and major product development tasks.

Enforces the non-negotiable core invariant:
$$\textbf{IDEA \& RESEARCH} \longrightarrow \textbf{PRD \& REQUIREMENTS} \longrightarrow \textbf{USER FLOW} \longrightarrow \textbf{WIREFRAME \& UI/UX} \longrightarrow \textbf{DESIGN SYSTEM} \longrightarrow \textbf{TECHNICAL ARCHITECTURE} \longrightarrow \textbf{DATABASE \& API DESIGN} \longrightarrow \textbf{TASK BREAKDOWN} \longrightarrow \textbf{PROJECT SETUP} \longrightarrow \textbf{DEVELOPMENT} \longrightarrow \textbf{INTEGRATION} \longrightarrow \textbf{TESTING \& QA} \longrightarrow \textbf{SECURITY \& OPTIMIZATION} \longrightarrow \textbf{DEPLOYMENT} \longrightarrow \textbf{MONITORING \& MAINTENANCE}$$

## 3. When to Use
- **Default for All New Projects (Greenfield)**: Execute from Phase 01 through Phase 15 in exact sequence.
- **Major Product Development / Feature Additions**: For substantial modules or features, execute the 15 phases proportionally.
- **Existing Projects (Brownfield)**: Audit the codebase to determine the current phase, inspect existing documentation, and resume from the appropriate phase without recreating completed work.
- **In-Project Documentation Setup**: When establishing `docs/` and `tasks/` in the project root.
- **Local Git Protection**: When configuring `.gitignore` to prevent private AI planning files from leaking to public Git remotes.

## 4. When Not to Use
- **Trivial 1-Line Bug Fixes**: Localized typo fixes, single-character adjustments, or dependency version bumps where multi-phase documentation is counterproductive.
- **Ad-Hoc Inspection Commands**: One-off user-requested commands (e.g. `git status`, `flutter doctor`, `flutter analyze`).

## 5. Required Project Context
- Project root directory layout and framework configuration (`pubspec.yaml`, `package.json`, etc.).
- Discovered architecture, conventions, and state management patterns.
- User requirements, target platforms (Windows, Android, iOS, Web), and operational constraints.
- Existing `.gitignore`, `AGENTS.md`, and in-project documentation (`docs/`, `tasks/`).

## 6. Step-by-Step 15-Phase Development Lifecycle

### PHASE 01: IDEA & RESEARCH
- **Activities**: Understand the problem; identify target users and personas; research user needs; analyze competitors; identify unique value proposition; evaluate technical feasibility; identify scope and constraints; define MVP vs. future enhancements.
- **Deliverables**: `docs/PROJECT_OVERVIEW.md`, `docs/RESEARCH.md` (when research required).
- **Gate**: Clear, approved understanding of problem, target users, and MVP boundaries.

### PHASE 02: PRD & REQUIREMENTS
- **Activities**: Define product objectives and KPIs; define user personas, roles, and permissions; detail functional and non-functional requirements; define MVP scope vs. out-of-scope; define success criteria; identify assumptions and pending decisions.
- **Deliverables**: `docs/PRD.md`, `docs/TRD.md`.
- **Gate**: Complete, unambiguous requirements baseline with explicit acceptance criteria.

### PHASE 03: USER FLOW
- **Activities**: Identify all required screens and modals; define navigation structure (bottom nav, drawer, router); map end-to-end user journeys; create screen-to-screen navigation flows (Mermaid diagrams); map user actions and outcomes; define auth/session flows; identify loading, empty, partial, success, and error states; identify critical edge cases.
- **Deliverables**: `docs/USER_FLOW.md`, `docs/SCREEN_LIST.md`.
- **Gate**: Full screen inventory and verified navigation diagram with zero dead ends.

### PHASE 04: WIREFRAME & UI/UX
- **Activities**: Create structured low-fidelity textual or visual wireframes; define content hierarchy; position navigation elements and primary actions; define form layouts and validation behavior; define interaction behaviors and gestures; plan responsive viewports (mobile, tablet, desktop); identify reusable UI components; review accessibility (tap targets $\ge 48\times 48\text{ pt}$, contrast $\ge 4.5:1$).
- **Deliverables**: `docs/WIREFRAME.md`, `docs/UI_UX_SPECIFICATION.md`.
- **Gate**: Wireframe layout approved; content hierarchy and responsive breakpoints locked.

### PHASE 05: DESIGN SYSTEM
- **Activities**: Establish visual direction; define semantic color palette (13 color roles); define typography hierarchy; define 4pt/8pt modular spacing grid; define elevations, shadows, and corner radii; define button hierarchy (Primary, Secondary, Text, Destructive); define card and input styling; define iconography family; define light/dark theme variants; define purposeful animation curves and duration constants.
- **Deliverables**: `docs/DESIGN.md`.
- **Gate**: All UI tokens defined. *Rule: All future UI development must follow `DESIGN.md`.*

### PHASE 06: TECHNICAL ARCHITECTURE
- **Activities**: Select tech stack based on requirements; define application architecture (Clean Architecture, Feature-First); define presentation, business logic, domain, and data layers; define module responsibilities and folder structure; select state management pattern; define unidirectional data flow; define global and domain error handling; define security boundaries and secret management; plan scalability and offline caching.
- **Deliverables**: `docs/ARCHITECTURE.md`, `docs/TECH_STACK.md` (when useful).
- **Gate**: Approved architecture and module boundaries with zero cyclic dependencies.

### PHASE 07: DATABASE & API DESIGN
- **Activities**: Select database technology (Drift, SQLite, Hive, PostgreSQL, Firestore); design schema, tables, and relationships; define primary/foreign keys, indexes, and constraints; define data validation invariants; define API endpoints, contracts, and payloads; define request/response structures with typed errors; define authentication and authorization; define third-party integrations; define migration strategy and seed data procedures (real data format, zero fake dummy records).
- **Deliverables**: `docs/DATABASE.md`, `docs/API.md`.
- **Gate**: Complete, unambiguous data schema and API contract specifications.

### PHASE 08: TASK BREAKDOWN
- **Activities**: Divide development into phases, modules, and features; decompose features into atomic implementation tasks (1-2 files per task); map task dependencies; assign priorities (`Critical`, `High`, `Medium`, `Low`); establish explicit acceptance criteria and testing requirements; author tasks using the **13 Mandatory Schema Fields**:
  1. `Task ID` (e.g. `TASK-001`)
  2. `Title`
  3. `Description`
  4. `Objective`
  5. `Requirements`
  6. `Files/Modules Affected`
  7. `Dependencies`
  8. `Implementation Steps`
  9. `Acceptance Criteria`
  10. `Testing Requirements`
  11. `Expected Outcome`
  12. `Priority`
  13. `Status` (`Not Started`, `In Progress`, `Blocked`, `Testing`, `Completed`)
- **Deliverables**: `tasks/IMPLEMENTATION_PLAN.md`, `tasks/TASKS.md`, `tasks/phases/`.
- **Gate**: All tasks registered with valid dependencies. *Rule: Never implement an entire project in one operation.*

### PHASE 09: PROJECT SETUP
- **Activities**: Inspect existing project before modifying; initialize project foundation or configure dependencies; pin package versions; configure development tools and build scripts; configure environment variables (`.env.example`); configure Git repository and commit conventions; configure linting (`analysis_options.yaml`); configure test harness; configure `.gitignore` protection; verify initial build succeeds.
- **Deliverables**: Working project foundation, `AGENTS.md`, `.gitignore`, `README.md`.
- **Gate**: Clean compilation, linter pass, and verified `.gitignore` protection.

### PHASE 10: DEVELOPMENT
- **Activities**: Select exactly one unblocked task from `tasks/TASKS.md` whose prerequisites are completed; read relevant specifications (`PRD.md`, `DESIGN.md`, `ARCHITECTURE.md`); inspect code; implement minimal vertical slice; adhere strictly to `DESIGN.md` and `ARCHITECTURE.md`; handle edge cases and errors; write unit/widget tests; execute the **Mandatory Task Execution Loop**:
  $$\text{READ} \longrightarrow \text{UNDERSTAND} \longrightarrow \text{PLAN} \longrightarrow \text{IMPLEMENT} \longrightarrow \text{TEST} \longrightarrow \text{REVIEW} \longrightarrow \text{FIX} \longrightarrow \text{DOCUMENT} \longrightarrow \text{VERIFY} \longrightarrow \text{MARK COMPLETED}$$
- **Deliverables**: Working code, test files, updated `tasks/TASKS.md`, updated `MEMORY.md`.
- **Gate**: 12-point task completion verification checklist satisfied.

### PHASE 11: INTEGRATION
- **Activities**: Connect UI presentation layer with controllers/BLoCs; connect services with database and API clients; integrate authentication state and token refresh loops; wire cross-module communications and routing; verify end-to-end navigation flows from `docs/USER_FLOW.md`; verify data flow from user input to persistence; verify error propagation and user-friendly error UI; verify state preservation across app lifecycles.
- **Deliverables**: Fully integrated application workflows with zero orphan components.
- **Gate**: All primary user journeys work seamlessly end-to-end.

### PHASE 12: TESTING & QA
- **Activities**: Execute unit tests (business logic, models); execute widget/component tests (UI state rendering); execute integration tests (multi-component workflows); test happy paths and boundary conditions; test invalid inputs and validation errors; test empty, loading, error, and offline states; test user permissions and token expiration; perform visual and platform compatibility checks.
- **Deliverables**: `docs/TEST_PLAN.md`, test execution reports, updated bug list.
- **Gate**: All tests pass; zero blocking defects; static analysis returns 0 errors.

### PHASE 13: SECURITY & OPTIMIZATION
- **Activities**: Security audit (authentication, API security, secret isolation, input sanitization, data encryption, dependency vulnerabilities); Performance optimization (database query indexes, memory leak elimination, UI frame budget 60/120 FPS, const constructors, pure build methods, isolate offloading, caching).
- **Deliverables**: `docs/SECURITY.md`, performance profiling report.
- **Gate**: Zero critical security vulnerabilities; performance targets met.

### PHASE 14: DEPLOYMENT
- **Activities**: Configure production environment variables; generate release builds; verify database migrations; configure packaging (MSIX / Win32 installer for Windows, AAB for Android, IPA for iOS, Docker/CDN for Web); verify release build in clean environment; prepare release notes in `CHANGELOG.md`; prepare rollback strategy.
- **Deliverables**: Production release artifacts, updated `CHANGELOG.md`, deployment runbook.
- **Gate**: Production build succeeds; release candidate verified in clean environment.

### PHASE 15: MONITORING & MAINTENANCE
- **Activities**: Monitor application errors, exceptions, and crash logs; monitor API latencies and database health; collect user feedback and track bug reports; maintain dependencies and apply security updates; implement bug fixes using the disciplined sequential execution loop; maintain in-project documentation.
- **Deliverables**: Updated `CHANGELOG.md`, maintenance records, synchronized `MEMORY.md` and `TASKS.md`.
- **Gate**: Application health verified; error tracking operational; docs updated.

---

## 7. Engineering Rules
- **Default Lifecycle**: The 15-phase SDLC is the default lifecycle for all new projects and major feature builds.
- **Sequential Execution**: Never jump directly into Phase 10 implementation before completing prerequisite planning phases (01–08).
- **Proportional Scope Handling**:
  - Small task (1 file, localized bug): Execute Phase 10 directly with targeted test verification.
  - Medium task (single module): Execute Phases 02, 06, 08, 10, 12.
  - Large task (greenfield / multi-feature): Execute all 15 phases sequentially.
- **Existing Projects**: Audit existing codebase first (6-step discovery) to identify completed phases and resume from the active phase.
- **In-Project Documentation Invariant**: All private AI-generated project documentation must reside inside `docs/` and `tasks/` in the project root. Never generate project docs in temporary or global directories.
- **Git Protection Invariant**: Private AI documentation (`/docs/`, `/tasks/`, `/MEMORY.md`, etc.) must be ignored in `.gitignore`. Public docs (`README.md`, `LICENSE`, `CHANGELOG.md`) remain tracked.
- **Single-Task Focus**: Never implement multiple complex tasks in one turn. Execute one task at a time.
- **Honest Status Tracking**: Never mark a task `Completed` without empirical proof from compiler, linters, and test suites.

## 8. Code Examples

### Structured Task Entry (`tasks/TASKS.md`)
```markdown
#### TASK-005: Design Database Schema & Local Persistence
- **Task ID**: `TASK-005`
- **Title**: Design Database Schema & Local Persistence
- **Description**: Implement relational database tables, DAOs, and migrations using Drift (SQLite).
- **Objective**: Provide structured, ACID-compliant local offline storage.
- **Requirements**: Comply with Real Data Integrity standard (zero fake dummy records).
- **Files/Modules Affected**: `lib/core/database/app_database.dart`
- **Dependencies**: `TASK-004`
- **Implementation Steps**:
  1. Define table schema with foreign keys and composite indexes.
  2. Implement DAO classes for core entities.
  3. Write migration logic for schema versioning.
- **Acceptance Criteria**: Schema compiles cleanly; migrations run without data loss.
- **Testing Requirements**: Drift in-memory database unit tests.
- **Expected Outcome**: Local database operational.
- **Priority**: High
- **Status**: Not Started
```

### Git Exclusion Verification Command
```bash
# Verify that private AI task management files are properly ignored
git check-ignore -v tasks/TASKS.md docs/PRD.md MEMORY.md
```

## 9. Common Mistakes
- **Skipping Planning Phases**: Jumping directly to widget creation without requirements, wireframes, or architecture.
- **Over-Documenting Trivial Fixes**: Creating 15 documents for a simple 1-line typo fix.
- **Massive Sprawling Diffs**: Attempting to implement an entire multi-screen application in one prompt.
- **Global Documentation Leakage**: Storing planning documents in global user folders where future agents cannot discover them.
- **Premature Task Completion**: Marking a task as completed without running static analysis or test suites.
- **Accidental Git Publishing**: Failing to configure `.gitignore` protection, allowing private AI planning documents to be pushed to public repositories.

## 10. Testing and Verification
- **Structural Integrity**: Run `dart run scripts/validation/validate-structure.dart` to verify all skills and workflows.
- **Master Validation Suite**: Execute `powershell -ExecutionPolicy Bypass -File scripts\PowerShell\validate-kit.ps1`.
- **Git Protection Verification**: Run `git check-ignore -v tasks/TASKS.md docs/PRD.md` to confirm local-only protection.
- **Static Analysis**: Verify `flutter analyze` returns 0 errors and 0 warnings.
- **Unit & Regression Testing**: Run `flutter test` across all completed feature slices.

## 11. Completion Criteria
- 15-phase lifecycle followed in sequence (or proportionally for small/medium tasks).
- All required phase deliverables created in `docs/` and `tasks/`.
- Master task registry created (`tasks/TASKS.md`) with 13-field schema and valid statuses.
- Mandatory `.gitignore` rules configured and verified with `git check-ignore`.
- Active task verified with 100% passing tests and clean static analysis.
- `TASKS.md` and `MEMORY.md` updated with verifiable progress.

## 12. Related Skills
- `project-analysis` (Non-destructive codebase discovery and architecture inspection)
- `flutter-architecture` (Feature-first Clean Architecture, service boundaries)
- `design-system` (13 color roles, typography, 4pt/8pt modular spacing grid)
- `real-data-integrity` (Zero dummy data, honest empty states, dynamic data flow)
- `performance-engineering` (Big-O complexity analysis, pure build methods, isolate concurrency)
- `testing` (Unit, widget, and integration test execution)
- `production-readiness` (50-point pre-flight launch certification)
