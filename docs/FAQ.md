# Frequently Asked Questions (FAQ)

Answers to common questions regarding the **Flutter Agent Kit**.

---

### Q1: How does the Flutter Agent Kit differ from typical AI prompts or coding rules?
**A:** Traditional prompts are ephemeral, passive snippets that easily get forgotten or overridden as conversations grow. The Flutter Agent Kit is a complete, modular **engineering system**. It combines:
1. Foundational behavioral rules (`core/`) that enforce surgical modifications and prevent hallucinated rewrites.
2. 26 specialized skills (`skills/`) structured with strict triggers, inputs, and completion criteria.
3. 11 end-to-end development workflows (`workflows/`) covering the full software lifecycle.
4. Production-tested templates (`templates/`) for project documentation (PRD, Architecture, Decisions, Memory).

---

### Q2: Does the Agent Kit force a specific architecture or state management package?
**A:** No. The Agent Kit follows a **project-first inspection model**. Before writing or modifying code, the agent inspects `pubspec.yaml` and `lib/` to identify the existing architecture and state management solution (BLoC, Riverpod, Provider, GetX, or ChangeNotifier). It then writes idiomatic code consistent with that existing architecture. If starting a new project, it recommends proven, scalable architectures (such as feature-first layered Clean Architecture with BLoC or Riverpod) but adapts to user constraints.

---

### Q3: Why is Windows Desktop development prioritized so heavily?
**A:** Cross-platform Flutter literature and AI tools are heavily biased toward mobile (Android/iOS). Desktop environments—especially Windows—have unique architectural requirements:
- Window lifecycle vs process lifecycle (closing a window does not necessarily terminate the process).
- Desktop ergonomics (keyboard shortcuts, mouse hover states, resizable windows, minimum dimensions).
- OS integrations (System tray, Windows Toast notifications via WinRT, registry startup keys).
- Production distribution (MSIX packaging, code signing, and Microsoft Store certification).
The Flutter Agent Kit provides first-class, verified Windows engineering capabilities.

---

### Q4: What must an AI agent do when `flutter analyze` or `flutter test` fails?
**A:** The agent must adhere to `core/verification-policy.md`:
1. **Never fake success**: Never report a task as complete if an analyzer warning or test failure exists.
2. **Never weaken or delete tests**: Do not comment out, delete, or artificially relax assertions to make tests pass.
3. **Isolate the root cause**: Inspect the failure trace, identify whether the issue is a syntax error, type mismatch, or logic flaw, and apply a surgical fix.
4. **Re-verify**: Re-run the verification command until it passes cleanly with code 0.

---

### Q5: How does the Agent Kit prevent context window exhaustion and high token bills?
**A:** The kit implements strict token efficiency guidelines (`core/token-efficiency.md`):
- Agents are forbidden from scanning entire repositories or repeatedly reading unchanged files.
- Investigation starts with the smallest relevant scope (e.g., direct dependencies, single feature directory) and expands only when information is genuinely missing.
- Rule loading is modular: Cursor loads rules via targeted glob patterns, while Claude Code and Codex load skills on demand.

---

### Q6: Can the Agent Kit be used without any MCP (Model Context Protocol) servers?
**A:** Yes, 100%. MCP servers (such as the Dart MCP server or Figma MCP) are purely optional enhancements. If no MCP server is configured, the Agent Kit operates with complete autonomy using standard Flutter and Dart CLI commands (`flutter analyze`, `flutter test`, `flutter build`).

---

### Q7: How does the Agent Kit handle database migrations without data loss?
**A:** Under `skills/database-integration/` and `rules/database/`, the kit enforces strict database safety rules:
- Schema changes in SQLite/Drift require incremental migration steps (`MigrationStrategy.onUpgrade`).
- Destructive operations (dropping tables, deleting columns, or purging data) are strictly prohibited without explicit user approval.
- Agents are required to provide backup/recovery considerations before applying schema transformations.
