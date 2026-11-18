# Workflow: Mandatory 15-Phase Software Development Lifecycle

This workflow guides AI coding agents through the mandatory 15-phase Professional Software Development Lifecycle (SDLC): upfront research, requirements, user flow, wireframes, design system, architecture, database/API design, task breakdown, setup, incremental development, integration, testing/QA, security/optimization, deployment, and monitoring/maintenance.

> [!NOTE]
> This workflow is the **DEFAULT** development lifecycle for all new software projects and major product development tasks across Flutter, Dart, React, Next.js, Node.js, Python, Go, and other stacks.
>
> Core Invariant:
> $$\textbf{IDEA \& RESEARCH} \to \textbf{PRD} \to \textbf{USER FLOW} \to \textbf{WIREFRAME} \to \textbf{DESIGN} \to \textbf{ARCHITECTURE} \to \textbf{DB \& API} \to \textbf{TASKS} \to \textbf{SETUP} \to \textbf{DEV} \to \textbf{INTEGRATION} \to \textbf{QA} \to \textbf{SECURITY} \to \textbf{DEPLOY} \to \textbf{MAINTENANCE}$$

---

## 1. Entry Conditions

- The user requests a new software project (greenfield), a new major feature or module, or a full product build.
- An existing project is onboarded for ongoing feature development or refactoring (brownfield).
- Project scope exceeds a trivial 1-line bug fix.

---

## 2. Step-by-Step 15-Phase Procedure

### PHASE 01: Idea & Research
1. Identify the core user problem, target audience, and market context.
2. Formulate the unique value proposition and evaluate technical feasibility.
3. Define the MVP scope boundary vs. future iterations.
4. **Deliverables**: Create `docs/PROJECT_OVERVIEW.md` and `docs/RESEARCH.md` (when required).
5. **Gate**: Clear, approved understanding of the product problem, target users, and MVP boundaries.

### PHASE 02: PRD & Requirements
1. Define product objectives, key performance indicators, user personas, and permissions.
2. Document detailed functional and non-functional requirements.
3. Explicitly define in-scope vs. out-of-scope capabilities for MVP.
4. **Deliverables**: Create `docs/PRD.md` and `docs/TRD.md`.
5. **Gate**: Complete, unambiguous requirements baseline with explicit acceptance criteria.

### PHASE 03: User Flow
1. Inventory all required screens, dialogs, and bottom sheets.
2. Map complete user journeys and screen transitions with Mermaid state diagrams.
3. Define auth, loading, empty, success, and error state transitions.
4. **Deliverables**: Create `docs/USER_FLOW.md` and `docs/SCREEN_LIST.md`.
5. **Gate**: Full screen inventory and verified navigation diagram with zero dead ends.

### PHASE 04: Wireframe & UI/UX
1. Create low-fidelity structural wireframes for all major screens and modals.
2. Establish content hierarchy, form layout sequencing, and responsive breakpoints.
3. Review accessibility: tap targets $\ge 48 \times 48\text{ pt}$, contrast $\ge 4.5:1$.
4. **Deliverables**: Create `docs/WIREFRAME.md` and `docs/UI_UX_SPECIFICATION.md`.
5. **Gate**: Wireframe layout approved; content hierarchy and responsive breakpoints locked.

### PHASE 05: Design System
1. Establish visual direction and archetype (Clean Utility, Modern Minimal, Data-Dense).
2. Define semantic color palette, typography hierarchy, 4pt/8pt spacing tokens, buttons, cards, and icons.
3. Define light/dark theme variants and purposeful animation curves.
4. **Deliverables**: Create `docs/DESIGN.md`.
5. **Gate**: All UI tokens defined. *Rule: All future UI development must follow `DESIGN.md`.*

### PHASE 06: Technical Architecture
1. Select the technology stack based on objective project requirements.
2. Define application architecture (Clean Architecture, Feature-First, Modular).
3. Define frontend, backend, module boundaries, state management, and data flow.
4. **Deliverables**: Create `docs/ARCHITECTURE.md` and `docs/TECH_STACK.md` (when useful).
5. **Gate**: Approved architecture and module boundaries with zero cyclic dependencies.

### PHASE 07: Database & API Design
1. Select database engine and design relational/document schema, indexes, and constraints.
2. Design API endpoints, request/response models, auth headers, and typed error envelopes.
3. Define seed data strategy (real-world format, zero fake dummy records).
4. **Deliverables**: Create `docs/DATABASE.md` and `docs/API.md`.
5. **Gate**: Complete, unambiguous data schema and API contract specifications.

### PHASE 08: Task Breakdown
1. Divide implementation into sequential phases, modules, and features.
2. Decompose features into atomic implementation tasks (1-2 files per task).
3. Ensure every task contains all **13 Mandatory Schema Fields**:
   - `Task ID`, `Title`, `Description`, `Objective`, `Requirements`, `Files Affected`, `Dependencies`, `Implementation Steps`, `Acceptance Criteria`, `Testing Requirements`, `Expected Outcome`, `Priority`, `Status`.
4. **Deliverables**: Create `tasks/IMPLEMENTATION_PLAN.md`, `tasks/TASKS.md`, and `tasks/phases/`.
5. **Gate**: All tasks registered with valid dependencies. *Rule: Never implement an entire project in one operation.*

### PHASE 09: Project Setup
1. Inspect existing project structure before modifying code.
2. Initialize project foundation (if greenfield) and configure dependencies.
3. Configure linting, formatting, test runners, and environment variables (`.env.example`).
4. Configure `.gitignore` to protect private AI documentation (`/docs/`, `/tasks/`, `/MEMORY.md`, etc.).
5. **Deliverables**: Cleanly compiling foundation, `AGENTS.md`, `.gitignore`, `README.md`.
6. **Gate**: Clean compilation, linter pass, and verified `.gitignore` protection.

### PHASE 10: Development (Sequential Single-Task Execution)
1. Select the next unblocked task from `tasks/TASKS.md` whose prerequisites are completed.
2. Update task status to `In Progress` in `tasks/TASKS.md` and update `MEMORY.md`.
3. Inspect relevant files and implement minimal vertical slice satisfying the requirements.
4. Comply strictly with `docs/DESIGN.md` and `docs/ARCHITECTURE.md`.
5. Execute the **Mandatory Task Execution Loop**:
   $$\text{READ} \to \text{UNDERSTAND} \to \text{PLAN} \to \text{IMPLEMENT} \to \text{TEST} \to \text{REVIEW} \to \text{FIX} \to \text{DOCUMENT} \to \text{VERIFY} \to \text{MARK COMPLETED}$$
6. Verify the 12-point task completion checklist before marking task `Completed`.
7. **Deliverables**: Working code, test files, updated `tasks/TASKS.md`, updated `MEMORY.md`.
8. **Gate**: 12-point task completion verification checklist satisfied.

### PHASE 11: Integration
1. Connect UI with state managers, controllers, and services.
2. Connect services with local database and remote API endpoints.
3. Integrate authentication, session recovery, navigation, and error handling.
4. **Deliverables**: Fully integrated application workflows with zero orphan components.
5. **Gate**: All primary user journeys work seamlessly end-to-end.

### PHASE 12: Testing & QA
1. Run automated unit, widget/component, and integration test suites.
2. Test happy paths, boundary conditions, validation errors, empty/loading states, and offline degradation.
3. Verify 100% test pass rate and clean static analysis.
4. **Deliverables**: `docs/TEST_PLAN.md`, test execution reports, updated bug register.
5. **Gate**: All tests pass; zero blocking defects; static analysis returns 0 errors.

### PHASE 13: Security & Optimization
1. Audit authentication, API security, secret isolation, input sanitization, and dependencies.
2. Optimize database queries, eliminate memory leaks, enforce 60/120 FPS frame rendering, and profile CPU/RAM.
3. **Deliverables**: `docs/SECURITY.md`, performance profiling report.
4. **Gate**: Zero critical security vulnerabilities; performance targets met.

### PHASE 14: Deployment
1. Configure release builds, production environment variables, and database migrations.
2. Package platform-specific artifacts (Windows MSIX/installer, Android AAB, iOS IPA, Web container/CDN).
3. Prepare user-facing release notes in `CHANGELOG.md` and establish rollback strategy.
4. **Deliverables**: Release artifacts, updated `CHANGELOG.md`, deployment runbook.
5. **Gate**: Production build succeeds; release candidate verified in clean environment.

### PHASE 15: Monitoring & Maintenance
1. Monitor runtime errors, exceptions, and crashes; track API latencies and database health.
2. Collect user feedback and manage defect backlog.
3. Maintain dependencies, apply security patches, and synchronize in-project documentation.
4. **Deliverables**: Updated `CHANGELOG.md`, maintenance records, synchronized `MEMORY.md` and `TASKS.md`.
5. **Gate**: Application health verified; error tracking operational; docs updated.

---

## 3. Exit Criteria

- [ ] All 15 development phases (or proportional phases for smaller tasks) executed in proper sequence.
- [ ] In-project documentation (`docs/` and `tasks/`) complete, accurate, and reflects actual code.
- [ ] Mandatory `.gitignore` rules protect private AI documentation from being committed to Git.
- [ ] Permanent `AGENTS.md` instructions are established in the project root.
- [ ] Every individual task passed the 12-point task completion checklist.
- [ ] Full automated test suite passes with 100% success rate.
- [ ] Static analysis returns 0 errors and 0 warnings.
- [ ] `tasks/TASKS.md` and `MEMORY.md` accurately record project state.
