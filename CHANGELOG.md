# Changelog

All notable changes to the **Flutter Agent Kit** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
