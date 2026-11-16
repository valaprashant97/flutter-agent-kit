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

