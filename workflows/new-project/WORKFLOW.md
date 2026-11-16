# Workflow: New Flutter Project Initiation

This workflow guides an AI coding agent through taking a new application from concept to a production-ready, runnable baseline.

---

## 1. Entry Conditions
- User provides a project idea, requirements document, or problem statement.
- Target development directory is empty or contains an uninitialized repository.

---

## 2. Step-by-Step Procedure

### Phase 1: Requirements Discovery & PRD
1. Analyze the user's idea and generate `docs/PRD.md` using `templates/PRD.md`.
2. Define:
   - Target users and core problem solved.
   - MVP scope vs Out-of-scope backlog.
   - Core user journeys and success criteria.

### Phase 2: Architecture & Technical Decisions
1. Generate `docs/ARCHITECTURE.md` using `templates/ARCHITECTURE.md`.
2. Select target platforms (e.g., Windows, Android, iOS, Web).
3. Select state management solution (BLoC, Riverpod, or Provider).
4. Record major technical decisions in `docs/DECISIONS.md`.

### Phase 3: Visual Design Specification
1. Generate `docs/DESIGN.md` using `templates/DESIGN.md`.
2. Establish color palette (light and dark mode), typography hierarchy, and spacing tokens.

### Phase 4: Task Decomposition
1. Create `docs/TASKS.md` with ordered, verifiable vertical slices.
2. Ensure Phase 1 in `docs/TASKS.md` covers project setup and baseline health check.

### Phase 5: Project Scaffolding
Execute project creation:
```bash
flutter create --org com.enterprise --platforms windows,android,ios,web,macos,linux app_name
cd app_name
```

### Phase 6: Core Infrastructure & Theming
1. Configure `analysis_options.yaml` with strict linting rules.
2. Configure `lib/core/theme/` with light and dark themes.
3. Configure `lib/core/routing/` with declarative `go_router`.

### Phase 7: Initial Verification
```bash
flutter analyze
flutter test
flutter run -d windows
```

---

## 3. Exit Criteria
- `docs/PRD.md`, `docs/ARCHITECTURE.md`, `docs/DESIGN.md`, and `docs/TASKS.md` created.
- Project compiles and runs cleanly on target platform with 0 analyzer warnings and 0 test failures.
