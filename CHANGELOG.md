# Changelog

All notable changes to the **Flutter Agent Kit** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.6.0] - 2026-11-18

### Mandatory 15-Phase Professional SDLC, Task Management & In-Project Documentation Architecture

#### Added
- **15-Phase Professional SDLC & Task Management Specification**:
  - `docs/TASK_MANAGEMENT_STANDARDS.md`: Authoritative engineering standard establishing the mandatory 15-Phase Professional SDLC as the default development workflow for all new software projects and major feature builds ($\text{Idea \& Research} \to \text{PRD \& Requirements} \to \text{User Flow} \to \text{Wireframe \& UI/UX} \to \text{Design System} \to \text{Technical Architecture} \to \text{Database \& API Design} \to \text{Task Breakdown} \to \text{Project Setup} \to \text{Development} \to \text{Integration} \to \text{Testing \& QA} \to \text{Security \& Optimization} \to \text{Deployment} \to \text{Monitoring \& Maintenance}$), 13 mandatory task schema fields, 5 valid task statuses, automatic in-project documentation architecture (`docs/` and `tasks/` in project root), mandatory `.gitignore` protection rules, 10-step sequential execution loop, 12-point task completion verification checklist, 7-step failed task diagnosis & remediation protocol, and brownfield discovery workflow.
- **Dedicated Agent Skill**:
  - `skills/task-management/SKILL.md`: Self-contained 12-section canonical skill manifest enforcing the 15-phase SDLC, hierarchical task decomposition, in-project documentation architecture, sequential execution loop, gitignore protection, and incremental development workflow across all technologies (Total: 35 Skills).
- **Dedicated Lifecycle Workflow**:
  - `workflows/task-lifecycle/WORKFLOW.md`: Complete 15-phase systematic workflow guiding AI coding agents through each phase from initial idea research to post-launch maintenance with concrete entry conditions, deliverables, and completion gates (Total: 25 Workflows).
- **Standardized Task Breakdown Prompt**:
  - `prompts/project-planning/task-breakdown-prompt.md`: Enforces the canonical 9-section context specification for decomposing complex, multi-feature projects into atomic, verifiable tasks with the 13-field schema (Total: 20 Prompts).
- **Project Planning Templates (20 Templates)**:
  - `templates/PROJECT_OVERVIEW.md`: Product vision, target audience, value proposition, and MVP scope (Phase 01).
  - `templates/RESEARCH.md`: Competitive analysis, market/technical feasibility research (Phase 01).
  - `templates/USER_FLOW.md`: Navigation state machine, screen transitions, and user journeys (Phase 03).
  - `templates/SCREEN_LIST.md`: Inventory of all application screens, routes, and modal surfaces (Phase 03).
  - `templates/WIREFRAME.md`: Structural layout wireframes for all major screens and modals (Phase 04).
  - `templates/UI_UX_SPECIFICATION.md`: Interaction specifications, gesture behaviors, and accessibility (Phase 04).
  - `templates/TECH_STACK.md`: Technology stack decision and trade-off analysis matrix (Phase 06).
  - `templates/TRD.md`: Production-ready Technical Requirements Document template covering system context, non-functional requirements, data models, integration contracts, security, and rollout strategy (Phase 02).
  - `templates/IMPLEMENTATION_PLAN.md`: Production-ready Implementation Plan Document template detailing execution phases, dependencies, milestones, risk mitigation, and verification gates (Phase 08).
  - `templates/tasks/phases/PHASE_01.md`: Phase breakdown template illustrating atomic task decomposition using the 13-field schema.
- **Universal Cross-Stack AI Skill**:
  - `C:\Users\admin\.gemini\config\skills\software-engineering-workflow\SKILL.md`: Global AI skill enabling Antigravity and AI coding agents to automatically apply this 15-phase workflow across Flutter, React, Next.js, Node.js, Python, and other technologies.

#### Changed
- `core/agent-principles.md`: Added Section 7 "The Mandatory 15-Phase SDLC & Task Management Invariant".
- `core/engineering-standards.md`: Added Section 12 "Mandatory 15-Phase SDLC & Task Management Standard".
- Aligned all agent entry points (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursorrules`, `.github/copilot-instructions.md`) with explicit 15-phase SDLC invariants, `.gitignore` rules, and updated catalog sizes (35 skills, 25 workflows).
- Upgraded `templates/TASKS.md` to strictly enforce the 13-field schema and 5 valid task statuses.
- Upgraded `templates/MEMORY.md` to track active phase, current task, completed tasks, pending tasks, and immediate next steps.
- Configured `.gitignore` in `flutter-agent-kit` with the mandatory AI Development & Task Management protection block (`/tasks/`, `/MEMORY.md`, `/DECISIONS.md`, `/IMPLEMENTATION_PLAN.md`, `/PROJECT_ANALYSIS.md`, `/TECHNICAL_ANALYSIS.md`).
- Synchronized `docs/SKILLS_CATALOG.md` (35 skills), `docs/WORKFLOWS.md` (25 workflows), `docs/AGENT_COMPATIBILITY.md`, `README.md`, and `TASKS.md`.
- Extended validation coverage in `scripts/PowerShell/validate-kit.ps1` to 115 files with 100% pass rate.

---

## [2.5.0] - 2026-11-17

### Skill System Audit, Scope Differentiation & Launch Certification

#### Added
- **Skill System Audit Report**:
  - `docs/SKILL_SYSTEM_AUDIT.md`: Complete audit report evaluating all 34 skills, 24 workflows, 51 rules, 19 prompts, 7 core files, and 5 agent entry points against structural compliance, scope distinctness, actionability, and token efficiency.

#### Changed
- `skills/performance/SKILL.md`: Differentiated from algorithmic engineering; focused explicitly on runtime DevTools timeline profiling, 60/120 FPS frame budget enforcement, raster/UI thread diagnosis, and widget rebuild optimization. Added cross-reference to `performance-engineering` in Section 12.
- `skills/performance-engineering/SKILL.md`: Sharpened focus on algorithmic efficiency, Big-O computational time & auxiliary space complexity, collection pre-indexing, memory lifecycle management, and isolate offloading. Added cross-reference to `performance` in Section 12.
- `workflows/performance-review/WORKFLOW.md`: Upgraded from a brief outline to a structured, 4-phase rapid profiling procedure with canonical Entry Conditions, Step-by-Step Procedure, and Exit Criteria checklist, clearly scoped as a targeted quick fix alongside comprehensive `performance-audit`.
- `docs/AGENT_COMPATIBILITY.md`: Synchronized with current catalog sizes (34 skills, 24 workflows, 51 rules, 7 core files) and core invariant references.
- `docs/FINAL_QUALITY_AUDIT.md`: Updated certification metrics and resolution matrix to reflect all 34 skills and 24 workflows.
- `core/engineering-standards.md`: Cleaned up trailing blank lines.
- `scripts/PowerShell/validate-kit.ps1`: Extended validation coverage to 103 files including all audit reports with 100% pass rate.

---

## [2.4.0] - 2026-11-17

### Advanced Dart & Flutter Performance Engineering System

#### Added
- **Performance Engineering & Algorithmic Efficiency Specification**:
  - `docs/PERFORMANCE_ENGINEERING_STANDARDS.md`: Authoritative engineering standard establishing the performance decision hierarchy ($\text{Correctness} > \text{Reliability} > \text{Maintainability} > \text{Measured Performance} > \text{Premature Optimization}$), Big-O time and auxiliary space complexity analysis, data structure selection matrix ($O(1)$ lookups, `StringBuffer`, lazy `Iterable` evaluations), pure `build()` methods, `const` subtrees, granular state rebuild scoping, resource disposal in `dispose()`, safe image decoding (`cacheWidth`/`cacheHeight` with DPR), isolate offloading rules, DevTools profiling protocols, standardized code review complexity format, and the 15-point mandatory performance checklist.
- **Dedicated Agent Skill**:
  - `skills/performance-engineering/SKILL.md`: Self-contained 12-section canonical skill manifest enforcing algorithmic efficiency, Big-O complexity analysis, memory leak prevention, Flutter frame rendering optimization, and isolate concurrency (Total: 34 Skills).
- **Dedicated Audit Workflow**:
  - `workflows/performance-audit/WORKFLOW.md`: 5-phase systematic audit workflow for discovering algorithmic bottlenecks, diagnosing memory leaks, scoping widget rebuilds, auditing isolate concurrency, and verifying performance via DevTools (Total: 24 Workflows).
- **Standardized Algorithmic Efficiency Prompt**:
  - `prompts/performance/algorithmic-efficiency-review.md`: Enforces the canonical 9-section context specification for executing algorithmic complexity and performance reviews (Total: 19 Prompts).

#### Changed
- `core/agent-principles.md`: Added Section 6 "The Performance Engineering & Algorithmic Efficiency Invariant".
- `core/engineering-standards.md`: Added Section 11 "Advanced Performance Engineering & Algorithmic Efficiency Standard".
- Aligned all agent entry points (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursorrules`, `.github/copilot-instructions.md`) with explicit performance engineering invariants referencing `docs/PERFORMANCE_ENGINEERING_STANDARDS.md`.
- Upgraded `rules/dart/async-concurrency.md`: Cross-referenced isolate offloading rules and payload sizing trade-offs.
- Upgraded `rules/flutter/widget-lifecycle.md`: Emphasized pure `build()` methods and controller disposal in `dispose()`.
- Upgraded `skills/code-review/SKILL.md`: Mandated the 4-line `**Performance Analysis**` block for code generation and review.
- Upgraded `workflows/feature-development/WORKFLOW.md`: Integrated the 15-point performance checklist into vertical-slice implementation and exit criteria.
- Upgraded `workflows/production-audit/WORKFLOW.md`: Cross-referenced performance engineering skills and standards.
- Synchronized `docs/SKILLS_CATALOG.md` (34 skills), `docs/WORKFLOWS.md` (24 workflows), `docs/ARCHITECTURE.md`, `README.md`, and `TASKS.md`.
- Updated automated validation suites (`scripts/PowerShell/validate-kit.ps1`, `tests/AGENT_KIT_VALIDATION.md`) to validate 102 files, 34 skills, and 24 workflows with 0 failures.

---

## [2.3.0] - 2026-11-17

### Navigation Clarity, Icon Usability & Action Discoverability System

#### Added
- **Navigation Clarity & Icon Usability Specification**:
  - `docs/NAVIGATION_AND_ICON_STANDARDS.md`: Canonical standard establishing the 3–5 mobile bottom nav destination rule, universal vs domain icon policy, action-descriptive accessibility semantics, 4-tier action hierarchy (Primary/Secondary/Tertiary/Destructive), progressive disclosure menus, and the 10-point navigation & action discoverability checklist.
- **Dedicated Agent Skill**:
  - `skills/navigation-clarity/SKILL.md`: Self-contained 12-section canonical skill manifest enforcing icon usability, visible text pairings, navigation hierarchy, and destructive action confirmation (Total: 33 Skills).
- **Dedicated Audit Workflow**:
  - `workflows/navigation-usability-audit/WORKFLOW.md`: 5-phase systematic audit workflow for scanning navigation elements, detecting bare ambiguous icons, verifying action-descriptive labels, inspecting destructive action safeguards, and proposing non-destructive upgrades (Total: 23 Workflows).
- **Standardized Navigation Usability Audit Prompt**:
  - `prompts/ui-ux/navigation-icon-audit.md`: Enforces the canonical 9-section context specification for executing navigation clarity audits (Total: 18 Prompts).

#### Changed
- `core/agent-principles.md`: Added Section 5 "The Navigation Clarity & Action Discoverability Invariant".
- `core/engineering-standards.md`: Added Section 10 "Navigation Clarity, Icon Usability & Action Discoverability Standard".
- Aligned all agent entry points (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursorrules`, `.github/copilot-instructions.md`) with explicit navigation clarity invariants referencing `docs/NAVIGATION_AND_ICON_STANDARDS.md`.
- Upgraded `skills/navigation/SKILL.md`: Embedded 3–5 destination constraints and cross-referenced `navigation-clarity`.
- Upgraded `skills/accessibility/SKILL.md`: Added action-descriptive label rules (describing operational action instead of icon graphic name) and cross-referenced `navigation-clarity`.
- Upgraded `rules/ui-ux/accessibility.md`: Enforced action-descriptive accessibility semantics and destructive action confirmation patterns.
- Upgraded `skills/code-review/SKILL.md`: Added `navigation-clarity` to verification matrix and related skills.
- Synchronized `docs/SKILLS_CATALOG.md` (33 skills), `docs/WORKFLOWS.md` (23 workflows), `docs/ARCHITECTURE.md`, `README.md`, and `TASKS.md`.
- Updated automated validation suites (`scripts/PowerShell/validate-kit.ps1`, `tests/AGENT_KIT_VALIDATION.md`) to validate 99 files, 33 skills, and 23 workflows with 0 failures.

---

## [2.2.0] - 2026-11-17

### Global Design Consistency & Design System Enforcement

#### Added
- **Global Design Consistency Specification**:
  - `docs/DESIGN_SYSTEM_STANDARDS.md`: Canonical standard establishing the One Coherent Visual Identity principle, 12-step Design System First protocol, 13 canonical color roles, 4pt/8pt modular spacing grid (`AppSpacing`), standard corner radii (`AppRadii`), 7 design direction archetypes, native Flutter theming architecture, reusable component library specifications, visual inspection protocols, and brownfield audit matrix.
- **Dedicated Design Consistency Audit Workflow**:
  - `workflows/design-consistency-audit/WORKFLOW.md`: 5-phase systematic audit workflow for detecting and eliminating hardcoded colors, arbitrary spacing, mismatched corner radii, competing icon sets, and light/dark theme contrast failures (Workflow #22).
- **Standardized Design Consistency Audit Prompt**:
  - `prompts/ui-ux/design-consistency-audit.md`: Enforces the canonical 9-section context specification for executing design consistency audits (Prompt #17).

#### Changed
- `skills/design-system/SKILL.md`: Upgraded with global design consistency principles, the 7 product archetypes, reusable component guidelines, and the 13-point design checklist.
- `templates/DESIGN.md`: Expanded into a complete design system blueprint incorporating archetype selection, 13 color roles, typography scale, spacing grid, radii, elevation, iconography, and the 13-point checklist.
- `core/agent-principles.md`: Added Section 4 "The Global Design Consistency Invariant".
- `core/engineering-standards.md`: Added Section 9 "Global Design Consistency & Design System Standard".
- Synchronized all agent entry points (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursorrules`, `.github/copilot-instructions.md`) with explicit design consistency requirements referencing `docs/DESIGN_SYSTEM_STANDARDS.md`.
- Upgraded `skills/ui-implementation/SKILL.md` and `skills/responsive-design/SKILL.md` to mandate design system tokenization and checklist compliance.
- Upgraded `workflows/design-system/WORKFLOW.md`, `workflows/ui-redesign/WORKFLOW.md`, and `workflows/feature-development/WORKFLOW.md` to enforce global design consistency.
- Upgraded `prompts/ui-ux/design-prompt.md` and `prompts/feature-development/feature-prompt.md` to require design tokens and component reuse.
- Updated `docs/SKILLS_CATALOG.md`, `docs/WORKFLOWS.md`, `docs/ARCHITECTURE.md`, and `README.md` to reflect 22 lifecycle workflows.
- Updated validation scripts (`validate-kit.ps1`, `validate-structure.dart`) and validation docs (`tests/AGENT_KIT_VALIDATION.md`).

---

## [2.1.0] - 2026-11-17

### Zero Dummy Data & Real Data Integrity System

#### Added
- **Dedicated Real Data Integrity Specification**:
  - `docs/REAL_DATA_INTEGRITY.md`: Comprehensive engineering standard defining the Real Data Only principle, 12 Strict Prohibited Practices, dynamic data pipeline architectures, honest empty states, mock fixture isolation rules, real metrics calculations, and an 8-tier Data Classification Matrix.
- **Dedicated Agent Skill**:
  - `skills/real-data-integrity/SKILL.md`: Self-contained 12-section canonical skill manifest enforcing reactive data flow, honest empty states, and mock isolation (Total: 32 Skills).
- **Dedicated Audit Workflow**:
  - `workflows/real-data-audit/WORKFLOW.md`: 5-phase systematic codebase audit procedure for scanning, classifying, and eliminating hardcoded records, fake dashboard metrics, and test data leaks (Total: 21 Workflows).
- **Reusable Audit Prompt**:
  - `prompts/testing/real-data-integrity-audit.md`: Adheres strictly to the canonical 9-section context specification.

#### Changed
- `core/agent-principles.md` & `core/engineering-standards.md`: Embedded the Real Data Only invariant, 12 Prohibited Practices, and the 8-tier data classification hierarchy.
- Synchronized all agent entry points (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursorrules`, `.github/copilot-instructions.md`) with explicit Real Data Only invariants.
- Upgraded skills (`ui-implementation`, `database-integration`, `api-integration`, `testing`, `debugging`, `production-readiness`) to enforce zero dummy data.
- Upgraded workflows (`feature-development`, `testing-and-qa`, `production-audit`, `existing-project-analysis`) to mandate real data verification.
- Upgraded prompts (`feature-prompt.md`, `code-review-prompt.md`, `final-audit-prompt.md`) to require real dynamic data checks.
- Updated `scripts/PowerShell/validate-kit.ps1` to validate all 32 skills and 21 workflows (94 files checked, 0 failures).

---

## [2.0.0] - 2026-11-17

### Major Architectural Upgrade & Quality Hardening

#### Added
- **Production-Grade Error Handling Suite** (Resolving AUD-001):
  - `skills/error-handling/SKILL.md`: Complete 12-section canonical skill manifest.
  - `rules/error-handling/global-error-handling.md`: Dual global error hooks (`FlutterError.onError` + `PlatformDispatcher.onError`), `ErrorWidget.builder` fallback UI, Sentry/Crashlytics telemetry setup, and PII sanitization.
  - `rules/error-handling/domain-errors.md`: Strongly typed sealed `Failure` hierarchies and functional `Result<T, E>` pattern.
  - `rules/error-handling/recovery-retries.md`: Exponential backoff with randomized jitter and offline cache degradation.
- **5 New Specialized Agent Skills** (Total: 31 Skills):
  - `skills/animations/SKILL.md`: 60/120 FPS implicit, explicit, staggered, and physics-based animations.
  - `skills/custom-painter/SKILL.md`: 2D canvas drawing, gauges, charts, and accessibility semantics.
  - `skills/platform-channels/SKILL.md`: Type-safe Pigeon code generation, MethodChannel, EventChannel, and native C++ runners.
  - `skills/golden-testing/SKILL.md`: Visual regression testing, deterministic viewports, font mocking, and multi-theme baselines.
  - `skills/error-handling/SKILL.md`: Complete error handling lifecycle.
- **9 New Standalone Workflows** (Total: 20 Workflows, Resolving AUD-002):
  - `workflows/product-requirements/WORKFLOW.md`: PRD discovery and functional scoping.
  - `workflows/architecture-planning/WORKFLOW.md`: Architecture selection, package slicing, and technical design.
  - `workflows/design-system/WORKFLOW.md`: Material 3 theme generation and ThemeExtensions.
  - `workflows/database-integration/WORKFLOW.md`: Drift, Isar, and Hive local persistence setup.
  - `workflows/api-integration/WORKFLOW.md`: Dio networking, interceptors, and DTO mappers.
  - `workflows/authentication/WORKFLOW.md`: Secure token storage, queued 401 refresh, and route guards.
  - `workflows/bug-investigation/WORKFLOW.md`: Triage and deterministic reproduction.
  - `workflows/root-cause-analysis/WORKFLOW.md`: 5-Whys diagnostic post-incident analysis.
  - `workflows/windows-desktop/WORKFLOW.md`: End-to-end Windows desktop development and release lifecycle.
- **Architecture & Persistence Expansion**:
  - `rules/state-management/getx.md`: GetX guardrails, controller lifecycles, and memory leak prevention (AUD-004).
  - `rules/architecture/mvvm.md`: Native MVVM using ChangeNotifier and ValueNotifier (AUD-009).
  - `rules/architecture/modular.md`: Multi-package repository slicing and dependency direction rules (AUD-009).
  - Segregated Hive and Isar rules into dedicated `rules/database/hive.md` and `rules/database/isar.md` (AUD-005).
  - `rules/ui-ux/animations.md`, `rules/ui-ux/custom-painter.md`, `rules/platform/platform-channels.md`, `rules/testing/golden-testing.md`.
- **Windows Desktop Enterprise Hardening** (Resolving AUD-011):
  - Win32 single-instance mutex implementation in `windows/runner/main.cpp` to prevent database lock corruption.
  - Per-Monitor V2 DPI awareness configuration (`SetProcessDpiAwarenessContext`) to eliminate blurry rendering across mixed-scaling displays.
- **Standardized 9-Section Prompts Library** (Resolving AUD-003):
  - Standardized all 16 prompt files across all 10 directories in `prompts/` to strictly enforce the 9 canonical sections (`PROJECT CONTEXT`, `OBJECTIVE`, `EXISTING BEHAVIOR`, `REQUIRED INVESTIGATION`, `CONSTRAINTS`, `ACCEPTANCE CRITERIA`, `EDGE CASES`, `TESTING REQUIREMENTS`, `EXPECTED OUTPUT`).
- **Automated Validation Specification & Audit Reports**:
  - `tests/AGENT_KIT_VALIDATION.md`: Automated testing specification and evidence log (AUD-012).
  - `docs/AGENT_KIT_AUDIT.md`: Phase 1 audit report detailing findings AUD-001 through AUD-013.
  - `docs/EXTERNAL_RESEARCH.md`: Verified ecosystem analysis matrix.
  - `docs/FINAL_QUALITY_AUDIT.md`: Final pre-flight certification issuing `[READY FOR PRODUCTION USE]`.

#### Changed
- `core/engineering-standards.md`: Enhanced with Greenfield/Brownfield framework, error handling standards, and state management rules.
- Synchronized all agent entry points (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursorrules`, `.github/copilot-instructions.md`) to single source of truth (AUD-013).
- Updated `docs/SKILLS_CATALOG.md` (31 skills) and `docs/WORKFLOWS.md` (20 workflows).
- Updated validation scripts: `scripts/PowerShell/validate-kit.ps1` and `tests/links/link_validator_test.dart` to support both relative links and `file:///` URIs.

---

## [1.0.0] - 2026-11-16

### Initial Production Release
- Core Engineering System (`core/`).
- Multi-Agent Compatibility (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursorrules`, Copilot).
- 26 Initial Specialized Flutter Skills.
- 40 Domain & Platform Rules.
- Windows Desktop Specialization (system tray, toasts, registry, MSIX).
- 11 Initial Lifecycle Workflows.
- Document Templates and Prompt Library.
