# Workflow: Architecture Planning & Technical Design

This workflow guides an AI coding agent through formulating, verifying, and documenting the technical architecture of a Flutter application prior to implementation.

---

## 1. Entry Conditions
- Product requirements document (`docs/PRD.md`) is established and approved.
- Technical stack, state management, persistence, or platform constraints must be selected.

---

## 2. Step-by-Step Procedure

### Phase 1: Structural Paradigm & Package Slicing
1. **Choose Architecture Pattern**:
   - For scalable enterprise apps: Select **Feature-First Clean Architecture** (`features/<feature>/{data, domain, presentation}`).
   - For small/medium apps: Select **MVVM** (`core/` + `models/`, `viewmodels/`, `views/`).
   - For multi-app monorepos: Select **Modular Architecture** (`melos.yaml`, `packages/core/`, `packages/features/`).
2. **Review Architectural Rules**:
   - Consult `rules/architecture/feature-first.md`, `rules/architecture/clean-architecture.md`, `rules/architecture/mvvm.md`, or `rules/architecture/modular.md`.

### Phase 2: State Management & Data Layer Selection
1. **Select State Management**:
   - BLoC / Cubit: Complex asynchronous event streams, audit requirements, large teams.
   - Riverpod: Compile-safe dependency graph, reactive caching, low boilerplate.
   - Provider / ValueNotifier: Simple reactive state with minimal dependencies.
   - GetX: Brownfield apps where GetX is already established (`rules/state-management/getx.md`).
2. **Select Persistence**:
   - Relational SQL: Drift (`rules/database/drift.md`).
   - High-performance embedded object store: Isar (`rules/database/isar.md`).
   - Key-value preferences/cache: Hive (`rules/database/hive.md`).
   - Secure secrets: `flutter_secure_storage` (`rules/database/secure-storage.md`).

### Phase 3: Technical Design Document Authoring
1. Create `docs/ARCHITECTURE.md` using `templates/ARCHITECTURE.md`.
2. Generate Mermaid architecture diagrams representing:
   - System component hierarchy
   - Data flow (UI $\leftrightarrow$ Controller $\leftrightarrow$ Use Case $\leftrightarrow$ Repository $\leftrightarrow$ Data Source)
   - State transition machine
3. Document major architectural trade-offs in `docs/DECISIONS.md`.

### Phase 4: Dependency Injection & Navigation Routing
1. Establish service locator (`get_it` + `injectable`) or provider tree.
2. Define declarative router strategy (`go_router`) with deep linking and guard redirects.

---

## 3. Exit Criteria & Quality Gates
- [ ] `docs/ARCHITECTURE.md` and `docs/DECISIONS.md` are documented.
- [ ] Data flow and layer dependency boundaries are strictly unidirectional.
- [ ] Dependency injection and routing strategies are established.
- [ ] Zero circular module dependencies exist in the proposed graph.

---

## 4. Related Skills & Rules
- `skills/flutter-architecture/`
- `skills/state-management/`
- `skills/database-integration/`
- `skills/navigation/`
- `core/engineering-standards.md`
