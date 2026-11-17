# Flutter Agent Kit: Automated Validation Specification & Quality Suite

This document defines the automated validation protocols, test matrices, pass/fail thresholds, and continuous quality gates for the **Flutter Agent Kit**.

---

## 1. Validation Philosophy & Zero-Fake-Pass Guarantee

To ensure that AI coding agents produce production-grade engineering without hallucinations or unverified claims:
1. **Zero Fake Pass Invariant**: Never certify or mark a task as completed without executing the relevant CLI command and recording the actual output evidence.
2. **Deterministic Manifest Validation**: Every skill must adhere to the 12 canonical sections with valid YAML frontmatter.
3. **Link Integrity Policy**: Zero broken internal Markdown links (`.md`) across all documentation and rule files.
4. **Zero Warnings Policy**: Code artifacts must pass `flutter analyze` with 0 errors and 0 warnings.

---

## 2. Automated Quality Verification Test Suite

The kit provides four layers of automated verification:

| Suite Name | Script / Test File | Purpose & Verification Scope | Threshold |
| :--- | :--- | :--- | :--- |
| **PowerShell Master Validator** | `scripts/PowerShell/validate-kit.ps1` | Validates file integrity, minimum byte sizes, YAML frontmatter, 34 skills, and 24 workflows | 0 Failures |
| **Dart Structure Validator** | `scripts/validation/validate-structure.dart` | Validates directory layout, core engineering policies, 12 canonical skill sections, and workflows | 0 Errors |
| **Skill Schema Test** | `tests/validation/skill_schema_test.dart` | Validates that all 34 skills have standard YAML frontmatter (`name:`, `description:`) | 34/34 Passed |
| **Directory Completeness Test**| `tests/structure/structure_test.dart` | Validates the existence of all 20 required directories including `rules/error-handling` | 20/20 Passed |
| **Markdown Link Validator** | `tests/links/link_validator_test.dart` | Parses and validates all internal markdown links (`[text](path.md)`) across `docs/` | 0 Broken Links |

---

## 3. Verification Commands & Execution Matrix

### Running the Complete Validation Suite
```powershell
# 1. PowerShell Master Validation Suite
powershell -ExecutionPolicy Bypass -File scripts\PowerShell\validate-kit.ps1

# 2. Dart Structure & Manifest Integrity
dart run scripts/validation/validate-structure.dart

# 3. Skill Frontmatter Test
dart run tests/validation/skill_schema_test.dart

# 4. Directory Structural Completeness Test
dart run tests/structure/structure_test.dart

# 5. Internal Markdown Link Validator
dart run tests/links/link_validator_test.dart
```

---

## 4. Platform Test & QA Verification Matrix

When agents develop or modify Flutter applications using this kit, the following testing commands must be executed and reported:

| Stage | Command | Target Pass Criteria |
| :--- | :--- | :--- |
| **Static Analysis** | `flutter analyze` | 0 issues found |
| **Unit Testing** | `flutter test test/unit/` | 100% assertions satisfied |
| **Widget Testing** | `flutter test test/widgets/` | All 4 UI states render |
| **Golden Regression** | `flutter test --tags=golden` | 0 pixel diff against baselines |
| **Windows Desktop Build** | `flutter build windows --release` | Exit code 0, binary created |
| **MSIX Packaging** | `dart run msix:create` | Signed `.msix` package generated |

---

## 5. Latest Verification Evidence (2026-11-17)

- `scripts/PowerShell/validate-kit.ps1`: **PASSED (102 files checked, 34 skills, 24 workflows, 0 failures)**
- `scripts/validation/validate-structure.dart`: **PASSED (34 skills, 24 workflows, 0 errors)**
- `tests/validation/skill_schema_test.dart`: **PASSED (34 skills conforming to schema)**
- `tests/structure/structure_test.dart`: **PASSED (All required directories verified)**
- `tests/links/link_validator_test.dart`: **PASSED (0 broken links detected)**
