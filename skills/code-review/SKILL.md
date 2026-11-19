---
name: code-review
description: Rigorous production code review with severity-tiered issue triage (Critical, High, Medium, Low).
---

# code-review

## 1. Skill Name
`code-review`

## 2. Purpose
Provides a senior engineering review protocol for Flutter codebases. Evaluates pull requests, newly authored features, and refactored code against architectural integrity, memory hygiene, performance, security, null safety, and tests. Classifies findings into a structured severity hierarchy.

## 3. When to Use
- Before merging a feature branch into main.
- When an engineer or user asks: "Review this implementation" or "Audit these changes".
- Prior to releasing an app to staging or production.

## 4. When Not to Use
- When actively brainstorming initial conceptual ideas before any code exists.

## 5. Required Project Context
- Git diff or files modified
- `docs/ARCHITECTURE.md` and `docs/PRD.md`

## 6. Step-by-Step Workflow
1. **Analyze the Diff**: Inspect only the modified and added files.
2. **Evaluate Architecture Compliance**: Verify whether dependencies point in the correct direction (Presentation → Domain ← Data).
3. **Audit Lifecycle & Memory Safety**: Check that all controllers, streams, and animations are cleanly disposed in `dispose()`.
4. **Audit BuildContext Safety**: Verify that no `BuildContext` is accessed after an `await` without `if (!context.mounted) return;`.
5. **Inspect Performance & Algorithmic Complexity**:
   - Provide the mandatory 4-line `**Performance Analysis**` block (Time, Auxiliary Space, considerations, bottlenecks) for newly generated or reviewed algorithmic routines (`docs/PERFORMANCE_ENGINEERING_STANDARDS.md`).
   - Check for pure build methods, const subtrees, lazy viewport lists, and resource disposal in `dispose()`.
6. **Classify Findings by Severity**:
   - **Critical (Blocker)**: Crashes, memory leaks, security vulnerabilities, secret leaks.
   - **High (Bug / Defect)**: Logic errors, missing error states, broken edge cases.
   - **Medium (Code Smell)**: Architectural violations, missing const constructors, duplicate logic.
   - **Low / Suggestion**: Minor style naming inconsistencies, documentation improvements.

## 7. Engineering Rules
- **No Style Nitpicking on Unrelated Code**: Limit feedback strictly to the diff. Do not complain about preexisting styles in untouched files.
- **Actionable Suggestions**: For every issue raised, provide the exact code replacement or refactoring snippet.
- **Zero-Tolerance for False Passes**: If an issue breaks compilation or introduces a crash, flag it as Critical immediately.
- **Complexity Assessment Invariant**: Include the standard `**Performance Analysis**` block for meaningful algorithmic code blocks.

## 8. Code Examples
```text
### Review Finding Example:
[CRITICAL] Unchecked BuildContext usage across async gap in lib/features/auth/presentation/login_screen.dart:45

Problem:
Navigator.of(context).pushReplacementNamed('/dashboard') is invoked after awaiting authService.login() without checking if the widget is still mounted. If the user navigates away or closes the screen during login, this throws a FlutterError.

Recommended Fix:
await authService.login();
if (!context.mounted) return;
Navigator.of(context).pushReplacementNamed('/dashboard');
```

## 9. Common Mistakes
- Marking style preferences (e.g., single quotes vs double quotes) as Critical blockers.
- Overlooking memory leaks from undisposed `TextEditingController` instances.
- Forgetting to check whether new features added corresponding automated tests.

## 10. Testing and Verification
- Run `flutter analyze` on the reviewed branch.
- Run `flutter test` to ensure existing and new tests pass.

## 11. Completion Criteria
- Structured review report generated with findings categorized by Critical, High, Medium, and Low severity.
- Clear, actionable code fixes provided for all identified issues.

## 12. Related Skills
- `coding-standards` — Primary standards reference for code-review criteria (`docs/FLUTTER_CODING_STANDARDS.md`)
- `navigation-clarity`
- `performance-engineering`
- `security-audit`
- `performance`
- `testing`
- `flutter-architecture`
