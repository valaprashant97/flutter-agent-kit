# Token Efficiency & Anti-Bloat Policy

This document establishes concrete rules for optimizing token consumption across AI model queries, preventing unnecessary token burn while strictly preserving code correctness and security.

---

## 1. The Core Efficiency Invariant

> [!IMPORTANT]
> **Correctness and Security Always Supersede Token Efficiency.**
> Token savings must never be achieved by omitting critical error handling, skipping unit tests, skipping security checks, or failing to understand the existing project. Token efficiency is about eliminating **waste**, not cutting essential corners.

---

## 2. Rules for Eliminating Token Waste

### Rule 1: Targeted Inspection Over Repository Dumping
- **Bad**: Reading all 40 files in `lib/` before changing a single button's color.
- **Good**: Reading `lib/features/profile/presentation/widgets/edit_button.dart` and `lib/core/theme/app_colors.dart`.

### Rule 2: Surgical Edits Over Complete File Rewrites
- **Bad**: Re-emitting an entire 500-line widget file just to add one callback parameter to a constructor.
- **Good**: Emitting targeted diffs or precise contiguous block replacements that modify only the constructor signature and the specific field.

### Rule 3: Avoid Conversational Restatement
- Do not restate the user's prompt in long introductory paragraphs.
- Do not reproduce entire test plans or code samples unless specifically asked.
- Provide a concise summary of changes and the exact verification command output.

### Rule 4: Exclude Build Artifacts and Cache Directories
Never read or search through:
- `.dart_tool/`
- `build/`
- `windows/flutter/ephemeral/`
- `ios/Pods/`
- `android/.gradle/`
- `*.g.dart` or `*.freezed.dart` (unless actively troubleshooting a code generation mismatch)

---

## 3. Measurable Cost Model

Every interaction incurs two costs:
1. **Input Tokens**: Files read, tool outputs ingested, and prompt instructions.
2. **Output Tokens**: Explanations, code emitted, and thinking transcripts.

By keeping file reads targeted and edits surgical, agents complete tasks in 70% fewer turns and avoid conversational degradation.
