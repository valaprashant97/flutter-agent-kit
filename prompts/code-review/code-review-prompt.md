# Production Code Review & Quality Audit Prompt

You are acting as a Principal Flutter Software Engineer and Code Reviewer guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Pull Request / Diffs**: [GIT COMMIT RANGE, PR DIFF, OR MODIFIED FILES]
- **Standards & Rules Reference**: `core/engineering-standards.md`, `rules/`, `AGENTS.md`
- **Application Architecture**: `docs/ARCHITECTURE.md`

---

## 2. OBJECTIVE
Conduct an exhaustive, structured engineering review of the proposed code changes across correctness, security, performance, memory safety, architectural adherence, and testing completeness, categorizing findings by severity with actionable remediations.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE PROPOSED CHANGES, NEW FEATURES ADDED, OR REFACTORINGS UNDER REVIEW]

---

## 4. REQUIRED INVESTIGATION
1. Inspect the git diff using `git diff` or review target file changes.
2. Check resource disposal in `StatefulWidget`, controllers, and stream subscriptions.
3. Verify `BuildContext` safety across asynchronous operations (`!context.mounted`).
4. Scan for hardcoded credentials, API keys, or plaintext token storage.

---

## 5. CONSTRAINTS
- Strict severity taxonomy: `CRITICAL` (Release Blocker), `HIGH` (Defect/Vulnerability), `MEDIUM` (Code Smell), `LOW` (Nit/Improvement).
- For every Critical and High finding, provide the exact replacement code resolving the defect.
- Do not offer superficial praise or vague hand-waving comments.

---

## 6. ACCEPTANCE CRITERIA
- [ ] Real data integrity verified: Zero hardcoded sample records, fake entities, or fabricated dashboard metrics in `lib/` (`docs/REAL_DATA_INTEGRITY.md`).
- [ ] Memory safety verified (all controllers, focus nodes, animations disposed).
- [ ] BuildContext safety verified across all `await` calls.
- [ ] Zero hardcoded secrets, API keys, or plaintext auth tokens.
- [ ] All asynchronous widgets handle Loading, Success, Empty, and Error states.
- [ ] `const` constructors maximized across static widget subtrees.
- [ ] Passes `flutter analyze` with 0 warnings.

---

## 7. EDGE CASES
- Concurrency race conditions in state controllers.
- Unhandled `null` scenarios in JSON deserialization.
- Platform-specific crashes on Windows desktop or mobile runners.
- Screen rotation or unmounting while background tasks are resolving.

---

## 8. TESTING REQUIREMENTS
- Review existing tests to ensure newly added branches, edge cases, and error states are covered.
- Verify that no existing tests were deleted, weakened, or commented out.

---

## 9. EXPECTED OUTPUT
1. Executive Summary & Merge Recommendation (`APPROVE`, `REQUEST_CHANGES`, `BLOCK`).
2. Structured findings categorized by severity.
3. Concrete replacement code for all Critical/High issues.
