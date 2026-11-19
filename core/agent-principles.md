# Core Agent Principles

This document defines the non-negotiable mental model and decision hierarchy that every AI coding agent must follow when operating on Flutter and Dart codebases.

---

## 1. The Universal Decision Hierarchy

Whenever trade-offs arise between speed, brevity, refactoring, and stability, the agent must strictly apply the following priority ranking:

$$\mathbf{Correctness} > \mathbf{Requirement\ Compliance} > \mathbf{Existing\ Consistency} > \mathbf{Security\ \&\ Reliability} > \mathbf{Maintainability} > \mathbf{Token\ Efficiency} > \mathbf{Minimal\ Output}$$

- **Correctness**: The code must compile cleanly, execute without runtime exceptions, handle edge cases, and pass all automated tests.
- **Requirement Compliance**: Implement exactly what was requested. Do not omit critical requirements; do not invent unrequested capabilities.
- **Existing Consistency**: Adhere to the project's existing folder structure, naming conventions, state management approach, and architectural patterns.
- **Security & Reliability**: Never expose credentials, weaken input validation, or bypass sandboxing.
- **Maintainability**: Write clear, idiomatic Dart code with clean separation of concerns.
- **Token Efficiency**: Optimize context and output without sacrificing any higher priority.

---

## 2. The Four First Principles (Karpathy Guidelines)

### I. Think Before Coding
- **Never assume silently**: If an ambiguous requirement has multiple valid technical interpretations, state the options and tradeoffs concisely.
- **Surface constraints upfront**: If a requested feature requires a native platform capability (e.g., Windows background execution) that behaves differently from mobile, explain the constraint before coding.
- **Identify prerequisites**: Verify dependencies and SDK versions in `pubspec.yaml` before writing code that requires modern Dart features.

### II. Simplicity First
- **Smallest correct solution**: Write the minimum code required to solve the problem cleanly.
- **Zero speculative abstraction**: Never introduce generic wrappers, abstract interfaces, or design patterns for single-use implementations.
- **No unnecessary configurability**: Build for the immediate, explicit requirement—not for hypothetical future demands.
- **Anti-bloat rule**: If a clean 50-line widget achieves the goal, do not write a 200-line multi-class hierarchy.

### III. Surgical Changes
- **Touch only what you must**: Modify only the files, classes, and lines directly related to the task.
- **Respect adjacent code**: Do not reformat, reorganize, or "improve" adjacent, functioning code.
- **Clean up your own orphans**: If your change renders an import, variable, or method unused, remove it. Do not delete unrelated dead code unless requested.
- **Match existing style**: Follow the project's established formatting, even if you would personally format it differently.

### IV. Goal-Driven Verification
- **Proof over claims**: Never tell the user that an implementation is complete until you have executed real verification commands (`flutter analyze`, `flutter test`, or release builds).
- **Inspect failures honestly**: If a verification command fails, diagnose the real root cause. Never suppress errors or delete tests to fabricate a passing result.

---

## 3. The Real Data Integrity Invariant

- **Real Data Only**: Agents must never introduce fake, dummy, static, or fabricated application data and present it as real user data. All data must come from real user input, databases, verified APIs, or legitimate derived calculations.
- **Honest Empty States**: If real data does not exist, render an honest empty state with an actionable call-to-action (e.g. "Create your first habit"). Never insert fake records to make an interface look populated.
- **Real Metrics Only**: Dashboard statistics, progress bars, and charts must be mathematically derived from actual records. If data is insufficient, show an honest "Insufficient data" state. Never fabricate numbers or use random generators.
- **Honest Failure Handling**: When an API or database fails, display an honest error state with retry capability. Never return fake success responses or silent mock data fallbacks.
- **Isolate Mocks**: Confine test fixtures and mock repositories exclusively to `test/`. Never import test fixtures into `lib/` or register mocks in production dependency injection.
- **Reference**: See `docs/REAL_DATA_INTEGRITY.md` and `skills/real-data-integrity/SKILL.md`.

---

## 4. The Global Design Consistency Invariant

- **One Coherent Design Language**: Every application must maintain a single, cohesive visual identity. Different screens may serve different purposes, but they must feel like natural parts of the same product.
- **Design System First**: Before implementing multiple UI screens, inspect or establish the design tokens (colors, typography, 4pt/8pt spacing, corner radii, elevation, iconography) in `docs/DESIGN.md`. Never independently invent new styles on isolated screens.
- **Native Theming Priority**: Consume Flutter's native theming architecture (`ThemeData`, `ColorScheme`, `TextTheme`, `ThemeExtension`). Hardcoding raw hex colors (`Color(0xFF...)`) or arbitrary paddings inside widget files is strictly prohibited.
- **Component Reuse Over Duplication**: Inspect `lib/core/presentation/widgets/` for existing buttons, cards, text fields, and feedback views before creating new ones.
- **Light & Dark Theme Parity**: Every screen must provide accessible contrast (WCAG AA $\ge 4.5:1$) and appropriate surface hierarchy in both Light and Dark themes. Never make light-only or dark-only color assumptions.
- **Honest Visual Verification**: When visual tooling (screenshot, emulator, or preview) is available, inspect rendered widgets. Never claim visual verification if no visual inspection took place.
- **Reference**: See `docs/DESIGN_SYSTEM_STANDARDS.md`, `skills/design-system/SKILL.md`, and `workflows/design-consistency-audit/WORKFLOW.md`.

---

## 5. The Navigation Clarity & Action Discoverability Invariant

- **Clear Purpose & No Guesswork**: Every navigation destination, button, and interactive icon must communicate its purpose clearly. Users must never have to guess what an icon does or experiment with taps to discover basic functionality.
- **No Unnecessary Icon-Only Controls**: Ambiguous or domain-specific actions must feature visible text labels (`FilledButton.icon`, `OutlinedButton.icon`) or descriptive menu items. Standalone icon-only buttons are reserved strictly for universal conventions (Search, Close, Back, Settings, More).
- **The 3–5 Navigation Rule**: Mobile bottom navigation bars (`NavigationBar`) must contain between 3 and 5 essential, frequently used destinations with visible labels. Secondary actions belong in accessible menus or sidebars.
- **Action-Descriptive Accessibility Semantics**: Every interactive icon must provide an accessibility label/tooltip that describes the resulting action (e.g. `"Search invoice history"`), never the icon graphic name (e.g. `"search icon"`).
- **Destructive Action Confirmation**: Delete, reset, or purge operations must never be triggered by an unconfirmed ambiguous button. A confirmation modal with explicit warnings is mandatory.
- **Reference**: See `docs/NAVIGATION_AND_ICON_STANDARDS.md`, `skills/navigation-clarity/SKILL.md`, and `workflows/navigation-usability-audit/WORKFLOW.md`.

---

## 6. The Performance Engineering & Algorithmic Efficiency Invariant

- **Priority Hierarchy**: Apply $\text{Correctness} > \text{Reliability} > \text{Maintainability} > \text{Measured Performance} > \text{Premature Optimization}$. Select the simplest implementation that satisfies performance budgets. Never micro-optimize small bounded collections ($n \le 50$) at the expense of readability.
- **Big-O Complexity & Data Structures**: Understand Time Complexity and Auxiliary Space Complexity (strictly distinguishing temporary working memory from input/output storage). Use `Map` and `Set` for repeated lookups, `StringBuffer` inside loops, and single-pass lazy `Iterable` evaluations. Never promise $O(1)$ when unachievable.
- **Pure Build Methods & Scoped Rebuilds**: Keep Flutter widget `build()` methods pure, predictable, and free of I/O, sorting, or heavy math. Maximize `const` constructor usage. Use granular selectors (`select()`, `BlocSelector`, `ValueListenableBuilder`) to isolate rebuilds.
- **Resource Lifecycle Hygiene**: Explicitly dispose all owned controllers (`TextEditingController`, `AnimationController`, `ScrollController`, `FocusNode`), timers, and stream subscriptions in `dispose()`. Constrain image memory with `cacheWidth` and `cacheHeight` factoring in the device pixel ratio.
- **Isolate Offloading**: Keep CPU-intensive work off the UI isolate via `Isolate.run()` only when payload and compute duration ($> 8\,\text{ms}$) justify serialization overhead.
- **Proof-of-Performance**: Profile in profile/release mode using DevTools. Never claim 60/120 FPS without measurement. Include a standardized **Performance Analysis** block (Time, Auxiliary Space, considerations, bottlenecks) for algorithmic and meaningful code.
- **Reference**: See `docs/PERFORMANCE_ENGINEERING_STANDARDS.md`, `skills/performance-engineering/SKILL.md`, and `workflows/performance-audit/WORKFLOW.md`.

---

## 7. The Mandatory 15-Phase SDLC & Task Management Invariant

- **Default 15-Phase Development Lifecycle**: The 15-phase SDLC ($\text{Idea \& Research} \to \text{PRD \& Requirements} \to \text{User Flow} \to \text{Wireframe \& UI/UX} \to \text{Design System} \to \text{Technical Architecture} \to \text{Database \& API Design} \to \text{Task Breakdown} \to \text{Project Setup} \to \text{Development} \to \text{Integration} \to \text{Testing \& QA} \to \text{Security \& Optimization} \to \text{Deployment} \to \text{Monitoring \& Maintenance}$) is the **DEFAULT** development workflow for all new software projects and major product development tasks.
- **Never Implement Large Projects in One Operation**: Never attempt to complete a complex software project in one massive operation. Large or complex requirements must be systematically planned across phases and decomposed into independent, atomic tasks in `tasks/TASKS.md` using the 13-field schema before writing code.
- **Sequential Task Execution Loop**: In Phase 10 (Development), execute strictly one task at a time following the loop: $\text{READ} \to \text{UNDERSTAND} \to \text{PLAN} \to \text{IMPLEMENT} \to \text{TEST} \to \text{REVIEW} \to \text{FIX} \to \text{DOCUMENT} \to \text{VERIFY} \to \text{MARK COMPLETED}$. Never move to dependent tasks before completing their prerequisites.
- **In-Project Documentation Only**: All AI-generated project planning, architecture, user flows, wireframes, and task registries must reside inside `docs/` and `tasks/` in the target project root. Never create global or temporary project documentation.
- **Mandatory GitHub Protection**: Private AI-generated planning documents (`/docs/`, `/tasks/`, `/MEMORY.md`, `/DECISIONS.md`, `/IMPLEMENTATION_PLAN.md`) must be excluded from public Git remotes via `.gitignore`. Public docs (`README.md`, `LICENSE`, `CHANGELOG.md`) remain tracked.
- **12-Point Task Completion Verification**: A task is marked `Completed` only after passing the 12-point checklist, with real test execution and static analysis cleanly passing.
- **Failed Task Recovery Protocol**: If tests fail, stop immediately, diagnose the actual root cause, apply the smallest safe fix, and retest. Never suppress errors or fake passing tests.
- **Reference**: See `docs/TASK_MANAGEMENT_STANDARDS.md`, `skills/task-management/SKILL.md`, and `workflows/task-lifecycle/WORKFLOW.md`.

---

## 8. The Universal GitHub Repository Adaptation Invariant

- **Zero Structural Assumptions**: Never assume a fixed repository name, directory hierarchy, or single-app layout. Search dynamically for `pubspec.yaml` across root and nested subdirectories (`apps/*`, `packages/*`, Melos monorepos).
- **Prompt for Missing URLs**: If an instruction asks to operate on an external or remote repository but omits the GitHub URL, immediately prompt the user for the link. Never guess or hallucinate repository targets.
- **Authorization & Access Gate**: Verify write authorization before attempting changes. Never push commits directly to `main`, `master`, or protected branches. Always execute work on dedicated feature/fix branches.
- **Zero Architectural Churn**: Respect and extend the repository's established architecture (Clean Architecture, Feature-First, Layer-First, or MVC) and state management (BLoC, Riverpod, Provider, GetX, MobX, Signals, or ValueNotifier). Never force unrequested architectural rewrites.
- **Adaptive Standards Integration**: Apply Flutter Agent Kit coding standards (sound null safety, pure `build()` methods, mounted checks, resource disposal in `dispose()`, 4 UI states) in complete harmony with existing project conventions.
- **Isolated Pre-Flight Baseline**: Run diagnostics (`flutter pub get`, `flutter analyze`, `flutter test`) before modifying code to catalogue pre-existing issues and ensure new work introduces zero regressions.
- **Reference**: See `docs/GITHUB_REPOSITORY_STANDARDS.md`, `skills/github-repository/SKILL.md`, and `workflows/github-repository/WORKFLOW.md`.
