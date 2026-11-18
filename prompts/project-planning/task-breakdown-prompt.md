# Task Breakdown & Incremental Execution Prompt

Use this standardized prompt when initiating a new project, implementing a complex feature, or decomposing large requirements into sequential tasks.

---

### 1. PROJECT CONTEXT
- **Application Name**: [Project Name]
- **Target Platform(s)**: [Windows Desktop / Android / iOS / Web / macOS / Linux]
- **Current Technology Stack**: [Flutter / Dart / React / Next.js / Node.js / Python]
- **Architecture Pattern**: [Feature-First Clean Architecture / Modular / MVVM]
- **State Management**: [BLoC / Riverpod / Provider / ValueNotifier / Zustand]
- **Persistence & Networking**: [Drift / SQLite / Dio / REST / GraphQL]

---

### 2. OBJECTIVE
Decompose the requested feature or project scope into a disciplined, multi-phase task breakdown (`tasks/TASKS.md`), initialize required in-project documentation (`docs/`), configure `.gitignore` protection, and establish the sequential execution loop according to `docs/TASK_MANAGEMENT_STANDARDS.md`.

---

### 3. EXISTING BEHAVIOR
- Describe the current state of the repository before this work begins.
- Detail existing directory layout, available dependencies, and current test coverage baseline.

---

### 4. REQUIRED INVESTIGATION
1. Inspect `pubspec.yaml` (or `package.json`) to verify dependencies and SDK version constraints.
2. Inspect `lib/` (or `src/`) to identify existing module patterns, naming conventions, and state architectures.
3. Inspect `docs/` and `tasks/` to verify whether prior project documentation exists.
4. Check `.gitignore` to verify whether private AI documentation exclusion rules are configured.

---

### 5. CONSTRAINTS
- **Non-Negotiable Rule**: Plan first, document second, break down work, implement one task at a time, test, verify, update documentation, then move to the next task.
- **Never Implement Everything in One Operation**: Divide work into Project $\to$ Modules $\to$ Features $\to$ Phases $\to$ Tasks.
- **In-Project Documentation Only**: All planning documents must live inside `docs/` and `tasks/` in the project root. Never create global or temp files.
- **Mandatory GitHub Protection**: Private AI documentation and task registries must be excluded from Git via `.gitignore`.
- **Zero Dummy Data**: Production code must use real data flows; honest empty states with CTAs.
- **Surgical Edits**: Modify only the code directly required for the active task.

---

### 6. ACCEPTANCE CRITERIA
- [ ] Mandatory project analysis executed and recorded in `docs/MEMORY.md`.
- [ ] Core in-project documentation created or updated under `docs/` (`PRD.md`, `TRD.md`, `ARCHITECTURE.md`, `DESIGN.md`, `TASKS.md`, `MEMORY.md`).
- [ ] Master task registry created in `tasks/TASKS.md` adhering to the 13-point task schema.
- [ ] All tasks assigned valid statuses: `Not Started`, `In Progress`, `Blocked`, `Testing`, `Completed`.
- [ ] `.gitignore` updated with the mandatory private AI documentation exclusion block.
- [ ] `AGENTS.md` created or updated with the 14 permanent AI directives.
- [ ] The first recommended task (`TASK-001`) clearly identified.

---

### 7. EDGE CASES & FAILURE MODES
- **Missing or Ambiguous Requirements**: State assumptions explicitly in `docs/MEMORY.md` or ask the user a concise clarifying question before coding.
- **Prerequisite Failures**: If an upstream dependency fails during testing, pause and mark dependent tasks as `Blocked`.
- **Existing Tracked Files in Git**: Explain to the user that `.gitignore` does not retroactively untrack already-committed files; do not untrack without explicit permission.

---

### 8. TESTING & VERIFICATION REQUIREMENTS
- Execute static analysis check: `flutter analyze` (must yield 0 errors, 0 warnings).
- Verify `.gitignore` rules: `git check-ignore -v tasks/TASKS.md docs/PRD.md MEMORY.md`.
- Execute automated project tests: `flutter test`.

---

### 9. EXPECTED OUTPUT
1. **Project Analysis Summary**: Technology stack, discovered architecture, and task complexity classification.
2. **In-Project Documentation Tree**: List of documents created or updated inside `docs/` and `tasks/`.
3. **Phased Task Breakdown Table**: Master phase roadmap and granular tasks with Task IDs and statuses.
4. **Git Protection Status**: Confirmation of `.gitignore` configuration and `git check-ignore` verification.
5. **Next Recommended Task**: Detailed specification of `TASK-001` ready for execution.
