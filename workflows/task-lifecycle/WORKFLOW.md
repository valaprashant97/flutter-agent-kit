# Workflow: Professional Task Management & Sequential Execution

This workflow guides AI coding agents through the end-to-end software engineering lifecycle: upfront project analysis, in-project documentation generation, large task breakdown, sequential implementation slices, test verification, and continuous progress recording.

> [!NOTE]
> This workflow applies across all software projects, frameworks, and languages (Flutter, Dart, React, Next.js, Node.js, Python). It enforces the non-negotiable principle: **Plan First, Document Second, Break Down the Work, Implement One Task at a Time, Test, Verify, Update Documentation, and Then Move to the Next Task.**

---

## 1. Entry Conditions

- The user requests a new project, a complex multi-feature module, or a major architectural refactor.
- A task is too large, risky, or ambiguous to be executed safely in a single operation.
- Initial project onboarding where architecture, task breakdown, and documentation must be established.

---

## 2. Step-by-Step Procedure

### Phase 1: Mandatory Project Analysis (Pre-Implementation Discovery)
1. **Inspect Existing Architecture**:
   - Examine directory layout, configuration files (`pubspec.yaml`, `package.json`, `requirements.txt`), and dependencies.
   - Identify existing architectural patterns (Clean Architecture, Feature-First, MVVM, Modular) and state management approaches.
2. **Review Documentation & Directives**:
   - Read existing `README.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.cursorrules`.
3. **Classify Scope & Surface Assumptions**:
   - Classify complexity: **Small** (surgical 1-file fix), **Medium** (single screen/module), or **Large** (multi-feature/greenfield).
   - Identify missing constraints or ambiguities; state assumptions explicitly in `docs/MEMORY.md`.

### Phase 2: In-Project Documentation Initialization
1. Create or update core documentation inside the project root under `docs/`:
   - `docs/PRD.md`: Product requirements, user journeys, MVP scope boundaries.
   - `docs/TRD.md`: Technical requirements, hardware constraints, NFR benchmarks.
   - `docs/ARCHITECTURE.md`: System layers, data flow, component dependencies.
   - `docs/DESIGN.md`: 13 color roles, typography, 4pt/8pt spacing tokens, reusable components.
   - `docs/DATABASE.md`: Schema, tables, relationships, indexes, migrations.
   - `docs/API.md`: Endpoints, request/response models, auth, error conventions.
   - `docs/SECURITY.md`: Secret protection, at-rest/in-transit encryption, threat model.
   - `docs/TEST_PLAN.md`: Testing pyramid, matrices, edge cases, acceptance criteria.
   - `docs/IMPLEMENTATION_PLAN.md`: Phase roadmap, objectives, milestones.
   - `docs/DECISIONS.md`: Initial Architecture Decision Records (ADR).
   - `docs/MEMORY.md`: Active context, discovered conventions, next actions.

### Phase 3: Large Task Breakdown System
1. Decompose the implementation into sequential development phases (e.g. Foundation $\to$ Data/Auth $\to$ Features $\to$ Polish $\to$ Certification).
2. Author `tasks/TASKS.md` ensuring every task conforms to the 13-field schema:
   - `Task ID`, `Title`, `Description`, `Objective`, `Requirements`, `Files Affected`, `Dependencies`, `Implementation Steps`, `Acceptance Criteria`, `Testing Requirements`, `Expected Outcome`, `Priority`, `Status`.
3. Ensure every task is small enough to be implemented, tested, and reviewed independently.

### Phase 4: Configure GitHub Protection (.gitignore)
1. Inspect existing `.gitignore` in the project root.
2. Append the mandatory private AI documentation exclusion block:
   ```gitignore
   # AI Generated Project Documentation & Tasks (Local Only)
   /docs/
   /tasks/
   /MEMORY.md
   /DECISIONS.md
   /IMPLEMENTATION_PLAN.md
   /PROJECT_ANALYSIS.md
   /TECHNICAL_ANALYSIS.md
   ```
3. Verify rules using `git check-ignore -v tasks/TASKS.md docs/PRD.md MEMORY.md`.

### Phase 5: Establish Permanent AI Agent Instructions (AGENTS.md)
1. Create or update `AGENTS.md` in the project root.
2. Embed the 14 permanent AI directives (read docs first, follow task breakdown, one task at a time, respect architecture, design system tokens, zero dummy data, navigation clarity, performance engineering, continuous memory updates, ADRs, real verification commands, surgical changes, secret protection, 12-point checklist).

### Phase 6: Sequential Task Execution Loop
Execute each task strictly one at a time using this loop:
1. **Select Task**: Choose the next sequential task from `tasks/TASKS.md` whose dependencies are `Completed`.
2. **Set In Progress**: Update task status to `In Progress` in `tasks/TASKS.md` and record active task in `docs/MEMORY.md`.
3. **Inspect Relevant Code**: Read only the specific files required for the task.
4. **Implement Surgical Slice**: Write minimal correct code adhering to architectural standards, design tokens, and real data integrity.
5. **Execute Real Tests**:
   ```bash
   # Code Quality & Linter check
   flutter analyze
   # Targeted automated tests
   flutter test test/path/to/targeted_test.dart
   ```
6. **Remediate Failures**: If tests or static analysis fail, diagnose the actual root cause and apply the smallest safe fix. Never suppress errors or fake passing tests.
7. **Verify 12-Point Checklist**: Run through the Task Completion Verification Checklist.
8. **Update Documentation**:
   - Mark task status as `Completed` in `tasks/TASKS.md`.
   - Update `docs/MEMORY.md` with completed task proof and next recommended task.
9. **Report**: Deliver a concise Task Completion Report to the user.
10. **Advance**: Proceed to the next task until the phase is complete.

---

## 3. Exit Criteria

- [ ] All development phases and tasks in `tasks/TASKS.md` are marked `Completed`.
- [ ] In-project documentation (`docs/`) is complete, accurate, and reflects actual implementation.
- [ ] Mandatory `.gitignore` rules protect private AI documentation from being committed to Git.
- [ ] Permanent `AGENTS.md` instructions are established in the project root.
- [ ] Every individual task passed the 12-Point Task Completion Verification Checklist.
- [ ] Full automated test suite passes (`flutter test`) and static analysis is clean with 0 warnings (`flutter analyze`).
- [ ] Master project memory (`docs/MEMORY.md`) is up-to-date with zero fabricated claims.
