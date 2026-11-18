---
name: task-management
description: Hierarchical task breakdown, in-project documentation architecture, sequential execution loop, gitignore protection, and incremental development workflow.
---

# task-management

## 1. Skill Name
`task-management`

## 2. Purpose
Provides a disciplined software engineering methodology for AI coding agents to plan, document, decompose, and incrementally implement complex projects across Flutter, Dart, React, Next.js, Node.js, Python, and other technologies. Enforces the golden rule: **Plan First, Document Second, Break Down the Work, Implement One Task at a Time, Test, Verify, Update Documentation, and Then Move to the Next Task.**

## 3. When to Use
- When initiating a new greenfield project or receiving a complex multi-feature request.
- When working on large, multi-module tasks that cannot be reliably implemented in a single turn.
- When establishing in-project architecture and requirements documentation (`PRD.md`, `TRD.md`, `ARCHITECTURE.md`, `DESIGN.md`, `TASKS.md`, `MEMORY.md`).
- When setting up `.gitignore` protection to prevent AI planning and task files from leaking to public Git remotes.
- When managing multi-phase feature roadmaps, tracking task statuses (`Not Started`, `In Progress`, `Blocked`, `Testing`, `Completed`).

## 4. When Not to Use
- When executing a trivial 1-line bug fix, localized typo correction, or single method edit where full phase breakdown would cause unnecessary overhead.
- When the user explicitly requests an immediate one-off command execution (e.g. `flutter doctor`, `git status`).

## 5. Required Project Context
- Existing project directory layout and technology stack (`pubspec.yaml`, `package.json`, or `requirements.txt`).
- Discovered architecture, conventions, and state management patterns.
- User requirements, target platforms, and operational constraints.
- Existing `.gitignore` and `AGENTS.md` in the project root.

## 6. Step-by-Step Workflow
1. **Mandatory Project Analysis**:
   - Inspect existing project structure, dependencies, state management, and conventions.
   - Surface missing information, unstated constraints, or technical assumptions.
   - Classify task complexity: Small, Medium, or Large.
2. **In-Project Documentation Initialization**:
   - Create or update documentation inside `docs/` in the project root (`PRD.md`, `TRD.md`, `ARCHITECTURE.md`, `DESIGN.md`, `DATABASE.md`, `API.md`, `SECURITY.md`, `TEST_PLAN.md`, `IMPLEMENTATION_PLAN.md`, `DECISIONS.md`, `MEMORY.md`).
3. **Hierarchical Task Breakdown**:
   - Break down work into Project $\to$ Modules $\to$ Features $\to$ Phases $\to$ Tasks.
   - Author `tasks/TASKS.md` ensuring every task has the 13 mandatory schema fields (Task ID, title, description, objective, requirements, affected files, dependencies, steps, acceptance criteria, testing requirements, expected outcome, priority, status).
4. **Configure GitHub Protection**:
   - Append `/docs/`, `/tasks/`, `/MEMORY.md`, `/DECISIONS.md`, `/IMPLEMENTATION_PLAN.md` to `.gitignore`.
   - Verify rules with `git check-ignore`.
5. **Establish Permanent Agent Directives**:
   - Create or update `AGENTS.md` with the 14 permanent AI directives.
6. **Sequential Execution Loop**:
   - Select exactly one unblocked task whose dependencies are completed.
   - Set status to `In Progress` in `TASKS.md` and update `MEMORY.md`.
   - Inspect relevant code and implement minimal correct vertical slice.
   - Run verification commands (`flutter analyze`, `flutter test`).
   - If tests fail, execute root-cause remediation; never mark a task complete without empirical proof.
   - Update `TASKS.md` (`Completed`) and `MEMORY.md`.
   - Provide a concise Task Completion Report and proceed to the next task.

## 7. Engineering Rules
- **Non-Negotiable Rule**: Plan first, document second, break down work, implement one task at a time, test, verify, update documentation, then move to the next task.
- **Single Task Focus**: Never implement multiple complex tasks in one operation.
- **In-Project Documentation Invariant**: All AI-generated project planning and development documentation must reside inside the project repository root. Never generate project documentation in global or temp folders.
- **Local Protection Invariant**: Private AI documentation and task registries must be excluded from Git remotes via `.gitignore`.
- **12-Point Checklist**: A task is completed ONLY when all 12 items of the Task Completion Verification Checklist pass.
- **Honest Status Tracking**: Never silently skip tasks or mark broken code as completed.

## 8. Code Examples

### Structured Task Breakdown Entry (`tasks/TASKS.md`)
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
- **Massive Sprawling Diffs**: Attempting to implement an entire multi-screen application in one prompt, resulting in hundreds of compiler errors and hallucinated APIs.
- **Global Documentation Leakage**: Storing planning documents in global user folders or scratch directories where future agents cannot discover them.
- **Premature Task Completion**: Marking a task as completed immediately after generating code without running static analysis or test suites.
- **Silent Skipping**: Bypassing difficult or failing tasks to start fun UI tasks before prerequisite database or auth layers exist.
- **Accidental Git Publishing**: Failing to configure `.gitignore` protection, allowing private AI planning documents and local task files to be pushed to public repositories.

## 10. Testing and Verification
- **Structural Integrity**: Run `dart run scripts/validation/validate-structure.dart` to verify all skills and workflows.
- **Master Validation Suite**: Execute `powershell -ExecutionPolicy Bypass -File scripts\PowerShell\validate-kit.ps1`.
- **Git Protection Verification**: Run `git check-ignore -v tasks/TASKS.md` to confirm local-only protection.
- **Static Analysis**: Verify `flutter analyze` returns 0 errors and 0 warnings.
- **Unit & Regression Testing**: Run `flutter test` across all completed feature slices.

## 11. Completion Criteria
- Comprehensive in-project documentation initialized inside project root (`docs/`).
- Master task registry created (`tasks/TASKS.md`) with 13-field schema and valid statuses.
- Mandatory `.gitignore` rules configured and verified with `git check-ignore`.
- Permanent `AGENTS.md` directives created or updated in project root.
- Active task verified with 100% passing tests and clean static analysis.
- `TASKS.md` and `MEMORY.md` updated with verifiable progress.

## 12. Related Skills
- `project-analysis` (Non-destructive codebase discovery and architecture inspection)
- `flutter-architecture` (Feature-first Clean Architecture, service boundaries)
- `real-data-integrity` (Zero dummy data, honest empty states, dynamic data flow)
- `design-system` (13 color roles, typography, 4pt/8pt modular spacing grid)
- `performance-engineering` (Big-O complexity analysis, pure build methods, isolate concurrency)
- `testing` (Unit, widget, and integration test execution)
- `production-readiness` (50-point pre-flight launch certification)
