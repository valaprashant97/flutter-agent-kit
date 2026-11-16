# Reference Repository and Knowledge Base Audit

This document contains a comprehensive, structured audit of all reference materials located in `D:\Flutter\Flutter Agent-Kit\reference`. Every repository, skill suite, MCP integration, and reference document was systematically inspected to identify foundational patterns, eliminate duplicates, verify licenses, and select the highest quality engineering practices for the **Flutter Agent Kit**.

---

## Audit Classification Criteria

Each audited source is categorized into one of five tiers:
- **Essential**: Foundational production-grade source containing canonical rules, architectures, or workflows directly integrated into the core Agent Kit.
- **Recommended**: High-value resource providing specialized implementations, prompt templates, or tool definitions.
- **Optional**: Contextual reference suitable for peripheral tasks or external framework analogies.
- **Outdated / Duplicate**: Redundant, superseded, or identical copy identified during the audit.
- **Not Suitable**: Fails production standards, conflicts with Flutter best practices, or lacks actionable structure.

---

## Summary Matrix of Audited References

| Source Name | Location in Reference | Primary Scope | License | Classification | Integration Recommendation |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Agent Plugins (Flutter Team)** | `agent-plugins-main/` | Official skills & MCP tooling from Flutter team | Open Source (Workspace) | **Essential** | Core Dart/Flutter skills, MCP workflows, static analysis |
| **Flutter Skills Main (1)** | `flutter-skills-main (1)/` | 70+ production-grade Flutter & Dart skills | MIT License | **Essential** | Deep persistence, animations, networking, architecture, security |
| **Flutter AI Rules** | `flutter-ai-rules-main/` | 36 official doc-derived Flutter & Firebase skills | MIT License (documented) | **Essential** | Firebase suite, state management, accessibility, effective Dart |
| **Flutter AI Rules (Duplicate)** | `flutter-ai-rules-main (1)/` | Identical duplicate of `flutter-ai-rules-main` | MIT License | **Outdated / Duplicate** | Ignore (0 byte difference, redundant directory) |
| **CTS Agent Skills (2)** | `flutter-skills-main (2)/` | Chunky Tofu Studios mobile skills | MIT License | **Recommended** | Android emulator control, design polish, widget preview |
| **CTS Agent Skills (3)** | `flutter-skills-main (3)/` | Duplicate copy of CTS skills (missing LICENSE) | Incomplete (No LICENSE) | **Outdated / Duplicate** | Ignore (Superseded by `flutter-skills-main (2)`) |
| **MCP Flutter Toolkit** | `mcp_flutter-main/` | Dart MCP server, DevTools protocol, DTD | MIT License (2025 Anton Malofeev) | **Essential** | MCP architecture, DevTools integration, runtime debugging |
| **Figma to Flutter MCP** | `figma-flutter-mcp-main/` | Figma REST API to Flutter theme/components | MIT License | **Recommended** | UI/UX design tokens, design system generation |
| **Everything Claude Code (ECC)** | `ECC-main/` | Enterprise multi-agent harness & discipline | MIT License / CC-BY-SA 4.0 | **Essential** | Multi-agent conventions, verification gates, token efficiency |
| **Claude Skills Full-Stack** | `claude-skills-main/` | 67 full-stack developer skills | Public Repository | **Optional** | Backend integration patterns, cross-platform concepts |
| **Karpathy Code Guidelines** | `andrej-karpathy-skills-main/` | Disciplined coding, surgical edits, simplicity | Public Repository | **Essential** | Core agent principles, surgical change rules |
| **AI Prompt Library** | `ai-prompt-library-main/` | Prompt templates for architecture, UI, secrets | Public Repository | **Recommended** | Prompt library, secret management, skeleton loading |
| **Flutter Improve Design** | `skills-main/` | Kamran Bekirov UI/UX design polish workflows | Public Repository | **Recommended** | Visual hierarchy, spacing systems, UI redesign workflows |
| **Universal Token-Efficient Prompt** | `# Universal Token-Efficient...pdf` | Token efficiency & minimal correct changes | Educational Document | **Essential** | Core change discipline & verification loop |
| **Important Vibecoding Prompts** | `Important Vibecoding Prompts.pdf` | 20 lifecycle engineering prompts | Educational Document | **Essential** | Lifecycle templates (PRD to Final Audit) |
| **Fix Your Vibe-Coded App** | `prompts.pdf` | 5 tactical prompts for app quality fixes | Educational (Naman Soni) | **Recommended** | Background jobs, N+1 queries, optimistic UI, pagination |
| **Beginner-to-Production Guide** | `Vibe Coding- A Complete...pdf` | 37-step lifecycle & document templates | Educational Document | **Essential** | Templates (PRD, ARCHITECTURE, DESIGN, MEMORY, DECISIONS) |

---

## Detailed Source Audits

### 1. Flutter Agent Plugins (`agent-plugins-main`)
- **Location**: `D:\Flutter\Flutter Agent-Kit\reference\agent-plugins-main\agent-plugins-main`
- **Owner / Author**: Flutter & Dart Team (Google)
- **License**: BSD/MIT-style open-source workspace
- **Main Capabilities**:
  - Official skills authored by the Flutter framework maintainers.
  - Integration with Dart static analysis (`dart analyze`), Checks package (`package:checks`), FFI generation (`ffigen`), and pattern matching.
  - Widget preview standards, responsive layout builders, declarative routing (`go_router`), and HTTP integration.
- **Strengths**:
  - Ground truth on how the Flutter team envisions agent skills.
  - Standardized directory layout (`SKILL.md`, `references/`, `examples/`).
  - Zero hallucination of APIs; strictly adheres to modern Dart 3.x patterns.
- **Limitations**:
  - Small number of skills (12 skills total); lacks desktop and Windows-specific coverage.
- **Classification**: **Essential**
- **Kit Integration**: Adopted as the structural standard for skill packaging and primary authority on Dart 3 & Flutter core conventions.

---

### 2. Flutter Skills Comprehensive Suite (`flutter-skills-main (1)`)
- **Location**: `D:\Flutter\Flutter Agent-Kit\reference\flutter-skills-main (1)\flutter-skills-main`
- **Owner / Author**: Community Open Source Initiative
- **License**: MIT License
- **Main Capabilities**:
  - Over 70 specialized skills addressing real-world Flutter engineering challenges.
  - State persistence: Drift (SQLite ORM), Hive, Secure Storage, Shared Preferences.
  - Advanced networking: Dio caching interceptors, retry interceptors, offline-first sync.
  - Performance & diagnostics: Memory leak detection, jank profiling, frame rendering, concurrency with isolates and Squadron.
  - Security & hardening: App hardening, reverse-engineering defense, biometric authentication, encrypted preferences.
  - Platform integrations: Local notifications, deep links (`app_links`), camera scanners, permission handling.
- **Strengths**:
  - Production-tested implementations with clear "When to use", "When not to use", and "Failure modes".
  - Covers advanced production libraries (`drift`, `dio`, `freezed`, `sentry`, `skeletonizer`, `go_router`).
- **Limitations**:
  - Lacks dedicated Windows desktop specialization (MSIX packaging, Windows notification architecture, system tray).
- **Classification**: **Essential**
- **Kit Integration**: Primary knowledge source for persistence, networking, performance, security, and advanced Flutter widget engineering.

---

### 3. Flutter AI Rules & Skills (`flutter-ai-rules-main`)
- **Location**: `D:\Flutter\Flutter Agent-Kit\reference\flutter-ai-rules-main\flutter-ai-rules-main`
- **Owner / Author**: Community documented repository
- **License**: MIT License (documented in `ATTRIBUTION.md`)
- **Main Capabilities**:
  - 36 skills directly extracted from official documentation.
  - Comprehensive Firebase suite: Auth, Firestore, Crashlytics, Messaging, Remote Config, App Check, Cloud Functions, Data Connect.
  - State management breakdowns: BLoC, Riverpod, Provider, ChangeNotifier.
  - Testing frameworks: `mockito`, `mocktail`, `patrol` (E2E testing).
  - Accessibility and inclusive design principles.
- **Strengths**:
  - Grounded directly in verified official documentation.
  - Excellent rule-sets for Cursor, Claude Code, and Codex.
- **Limitations**:
  - Duplicate copy found in `reference/flutter-ai-rules-main (1)`.
- **Classification**: **Essential**
- **Kit Integration**: Primary knowledge base for state management comparisons, Firebase integration, and E2E testing strategies.

---

### 4. Duplicate Copies Identified
- **Reference**: `flutter-ai-rules-main (1)`
  - **Verdict**: Exact 1:1 duplicate of `flutter-ai-rules-main` (0 byte diff across all 110 files).
  - **Classification**: **Outdated / Duplicate** (Ignore).
- **Reference**: `flutter-skills-main (3)`
  - **Verdict**: Incomplete duplicate of `flutter-skills-main (2)`. Missing the `LICENSE` file.
  - **Classification**: **Outdated / Duplicate** (Ignore in favor of `flutter-skills-main (2)`).

---

### 5. Chunky Tofu Studios Agent Skills (`flutter-skills-main (2)`)
- **Location**: `D:\Flutter\Flutter Agent-Kit\reference\flutter-skills-main (2)\flutter-skills-main`
- **Owner / Author**: Chunky Tofu Studios
- **License**: MIT License (2026 Chunky Tofu Studios)
- **Main Capabilities**:
  - Automated Android emulator lifecycle and screenshot inspection.
  - Android stacktrace symbolization.
  - Widget preview rendering and visual design polish procedures.
- **Strengths**:
  - Practical mobile device verification tools and design polish workflows.
- **Limitations**:
  - Focuses only on mobile (specifically Android); no desktop support.
- **Classification**: **Recommended**
- **Kit Integration**: Integrated into mobile verification, UI design polish, and testing skills.

---

### 6. MCP Flutter Toolkit & Dart Server (`mcp_flutter-main`)
- **Location**: `D:\Flutter\Flutter Agent-Kit\reference\mcp_flutter-main\mcp_flutter-main`
- **Owner / Author**: Anton Malofeev (`Arenukvern`)
- **License**: MIT License (2025)
- **Main Capabilities**:
  - Native Model Context Protocol (MCP) server for Dart and Flutter.
  - Exposes Dart Tooling Daemon (DTD) and Dart VM Service capabilities to AI coding agents.
  - Live runtime inspection, widget hierarchy exploration, hot reload, hot restart, and runtime error capture.
  - Automated test execution and boundary auditing.
- **Strengths**:
  - The leading MCP server for real-time Flutter development and automation.
- **Limitations**:
  - Requires active Flutter run session or running VM service for runtime tools; requires careful sandboxing.
- **Classification**: **Essential**
- **Kit Integration**: Primary reference for `mcp/` architecture, configuration guides, and DevTools integration.

---

### 7. Figma to Flutter MCP Server (`figma-flutter-mcp-main`)
- **Location**: `D:\Flutter\Flutter Agent-Kit\reference\figma-flutter-mcp-main\figma-flutter-mcp-main`
- **Owner / Author**: Open Source Community
- **License**: MIT License
- **Main Capabilities**:
  - TypeScript MCP server connecting Figma REST API to Flutter code generation.
  - Extracts color styles, typography hierarchies, layout grids, components, and SVG assets.
  - Generates Flutter `ThemeData`, custom `ThemeExtension`, and modular widget code.
- **Strengths**:
  - Eliminates manual CSS/Figma-to-Flutter translation errors; supports design token extraction.
- **Limitations**:
  - Requires Figma Personal Access Token and Team/File IDs.
- **Classification**: **Recommended**
- **Kit Integration**: Documented in `mcp/setup-guides/figma-mcp.md` and integrated into UI design-system workflows.

---

### 8. Everything Claude Code - ECC (`ECC-main`)
- **Location**: `D:\Flutter\Flutter Agent-Kit\reference\ECC-main\ECC-main`
- **Owner / Author**: Affaan Mustafa, Matt Pocock, and contributors
- **License**: MIT License / CC-BY-SA 4.0
- **Main Capabilities**:
  - Advanced multi-agent operating system and harness orchestration.
  - Cross-agent compatibility across Claude Code, Cursor, Gemini CLI, OpenAI Codex, and OpenCode.
  - Context budget management, token cards, gatekeeping (`gateguard`), verification loops, and architectural decision records.
  - Includes `windows-desktop-e2e` and `dart-flutter-patterns` skills.
- **Strengths**:
  - Industry-leading patterns for token budgeting, change discipline, and agent coordination.
- **Limitations**:
  - Highly vast (4,600+ files) and general-purpose; must be focused specifically on Flutter/Dart.
- **Classification**: **Essential**
- **Kit Integration**: Core source for multi-agent configuration (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursorrules`), token efficiency, and verification gates.

---

### 9. Karpathy-Inspired Coding Guidelines (`andrej-karpathy-skills-main`)
- **Location**: `D:\Flutter\Flutter Agent-Kit\reference\andrej-karpathy-skills-main\andrej-karpathy-skills-main`
- **Owner / Author**: Jiayuan (`multica-ai`)
- **License**: Public Repository
- **Main Capabilities**:
  - Behavioral guidelines designed to eliminate common LLM coding failures.
  - Core tenets: "Think Before Coding", "Simplicity First", "Surgical Changes", "Goal-Driven Execution".
- **Strengths**:
  - Prevents AI hallucinations, unnecessary refactoring, speculative abstraction, and scope creep.
- **Limitations**:
  - High-level behavioral rules; contains no Flutter-specific code.
- **Classification**: **Essential**
- **Kit Integration**: Direct foundation for `core/agent-principles.md` and `core/change-discipline.md`.

---

### 10. AI Prompt Library (`ai-prompt-library-main`)
- **Location**: `D:\Flutter\Flutter Agent-Kit\reference\ai-prompt-library-main\ai-prompt-library-main`
- **Owner / Author**: Community Curated
- **License**: Public Repository
- **Main Capabilities**:
  - Practical prompts for architecture planning, secret protection, performance profiling, responsive design, and skeleton loaders (`shimmer`).
- **Strengths**:
  - Ready-to-use prompts with explicit constraints and output schemas.
- **Limitations**:
  - Generic web and mobile mix; requires Flutter-specific adaptation.
- **Classification**: **Recommended**
- **Kit Integration**: Incorporated into `prompts/` and `skills/ui-implementation/`.

---

### 11. Flutter Improve Design (`skills-main`)
- **Location**: `D:\Flutter\Flutter Agent-Kit\reference\skills-main\skills-main`
- **Owner / Author**: Kamran Bekirov (`FlutterPro.Design`)
- **License**: Public Repository
- **Main Capabilities**:
  - Structured UI redesign skill (`flutter-improve-design`) with `DETAILS.md` and `PLAN-TEMPLATE.md`.
  - Audits visual hierarchy, spacing, contrast, micro-interactions, and typography.
- **Strengths**:
  - Directly counters generic "AI-generated" UI by enforcing refined visual design standards.
- **Limitations**:
  - Covers only UI/UX polishing; does not cover state, backend, or desktop.
- **Classification**: **Recommended**
- **Kit Integration**: Core knowledge source for `skills/ui-implementation/`, `skills/design-system/`, and `workflows/ui-redesign/`.

---

### 12. Reference PDF Documents

#### A. Universal Token-Efficient AI Software Engineering Prompt (`# Universal Token-Efficient...pdf`)
- **Pages**: 4
- **Content**:
  - Strict rule ordering: Understand project → Understand requirement → Smallest change → Implement → Verify → Report.
  - Principles: Correctness > Requirement compliance > Consistency > Security > Maintainability > Token efficiency.
  - Explicit prohibitions against scanning entire repos, duplicate logic, and unverified fixes.
- **Classification**: **Essential**
- **Kit Integration**: Forms the architectural spine of `core/token-efficiency.md` and `core/verification-policy.md`.

#### B. Important Vibecoding Prompts (`Important Vibecoding Prompts.pdf`)
- **Pages**: 14
- **Content**:
  - 20 sequential lifecycle prompts covering: PRD Creation, DESIGN.md, ARCHITECTURE.md, DATABASE.md, API.md, AGENTS.md, Implementation Planning, Project Setup, Feature Development, Database Connection, Authentication, MCP Connection, External APIs, Testing & QA, Root Cause Debugging, Security Audit, Code Review, Deployment, Production Monitoring, and Final Audit.
- **Classification**: **Essential**
- **Kit Integration**: Direct blueprint for `templates/` and `prompts/`.

#### C. Fix Your Vibe-Coded App (`prompts.pdf`)
- **Pages**: 7
- **Content**:
  - 5 high-impact fix prompts: Navigation icon clarity, Optimistic UI for laggy taps, Keyset pagination for heavy data, N+1 query elimination, and Background jobs/isolates.
  - The "Safety-Net Prompt" enforcing pre-change test execution and verified rollbacks.
- **Classification**: **Recommended**
- **Kit Integration**: Integrated into `prompts/debugging/`, `prompts/performance/`, and `rules/performance/`.

#### D. Vibe Coding: A Complete Beginner-to-Production Guide (`Vibe Coding- A Complete...pdf`)
- **Pages**: 37
- **Content**:
  - Complete 37-step engineering journey from Idea to Production.
  - Explicit project documentation system: `PRD.md`, `ARCHITECTURE.md`, `DESIGN.md`, `RULES.md`, `TASKS.md`, `DECISIONS.md`, `MEMORY.md`, `TEST_PLAN.md`, `SECURITY.md`, `.env.example`.
  - Vertical slice development model (Signup → Login → Note Create → Display).
- **Classification**: **Essential**
- **Kit Integration**: Foundation for project lifecycle workflows in `workflows/` and templates in `templates/`.

---

## Gap Analysis & Native Windows Desktop Specialization

While the reference collection provides world-class guidance on mobile Flutter, Dart 3, and Firebase, **desktop Flutter—particularly Windows desktop—is significantly under-represented in the reference repositories**. 

To satisfy the primary objective, the **Flutter Agent Kit** provides native, verified Windows desktop engineering standards:
1. **Process Lifecycle vs. Window State**: Explicit distinction between App Window Closed, Minimized, System Tray Active, Background Service, and Process Terminated.
2. **System Tray Integration**: Native tray management using `tray_manager` and `system_tray` with context menus and click handlers.
3. **Background Execution on Windows**: Implementing headless Flutter runners, Windows Task Scheduler (`schtasks`), and Windows Services (`win32` / C++ runners) rather than assuming mobile workmanager behavior.
4. **Native Windows Notifications**: Implementing Windows Toast notifications via WinRT (`local_notifier` or `windows_notification`).
5. **Startup on Windows Login**: Managing registry keys (`HKCU\Software\Microsoft\Windows\CurrentVersion\Run`) safely.
6. **MSIX Packaging & Microsoft Store**: Complete `msix` packaging configuration, identity manifests, self-signed test certificates, and Store compliance.
7. **Window Management**: Window sizing, minimum/maximum boundaries, titlebar customization, and acrylic/mica effects via `window_manager`.
8. **Desktop Architecture Patterns**: Multi-pane layouts, keyboard navigation/shortcuts (`Shortcuts` & `Actions`), desktop menus, and mouse hover states.

---

## Conclusion & Architectural Decisions

1. **Unified Multi-Agent Compatibility**: Single source of truth in `core/` and `rules/`, referenced cleanly by `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursorrules`, and `.github/copilot-instructions.md`.
2. **Standardized Skill Schema**: Every skill implements the canonical `SKILL.md` format (Name, Purpose, When to use, When not to use, Context, Workflow, Rules, Examples, Mistakes, Verification, Completion, Related).
3. **Zero Placeholder Policy**: No empty folders or placeholder files. Every file contains complete, production-grade instructions.
4. **Token-Efficiency First**: Strict rules preventing agents from reading entire projects blindly.
