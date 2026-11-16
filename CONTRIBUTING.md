# Contributing to the Flutter Agent Kit

Thank you for your interest in contributing to the **Flutter Agent Kit**! We welcome contributions that improve AI coding agent reliability, add specialized Flutter skills, enhance Windows desktop integration, or refine existing workflows.

---

## 1. Ground Rules & Quality Standards

1. **Strict SKILL.md Schema**: Every newly authored skill must reside in `skills/<skill-name>/` and contain a valid `SKILL.md` with:
   - Standard YAML frontmatter (`name`, `description`).
   - The 12 canonical sections (Skill Name, Purpose, When to use, When not to use, Required Context, Workflow, Rules, Code Examples, Common Mistakes, Testing, Completion Criteria, Related Skills).
2. **Zero Hallucinated APIs**: Never document imaginary packages, deprecated Flutter APIs, or non-existent platform capabilities. Verify code examples against modern Dart 3.x and official Flutter documentation.
3. **Surgical Precision**: Focus contributions on specific domain capabilities. Do not submit monolithic refactorings across unrelated files.
4. **Validation Must Pass**: Run `./scripts/PowerShell/validate-kit.ps1` locally before submitting a pull request.

---

## 2. Pull Request Process

1. Fork the repository and create your feature branch: `git checkout -b skill/your-skill-name`.
2. Author your changes following the directory conventions in `docs/ARCHITECTURE.md`.
3. Run automated validation:
   ```powershell
   ./scripts/PowerShell/validate-kit.ps1
   ```
4. Commit using conventional commit format: `feat(skill): add audio-playback skill`.
5. Submit your PR with a clear summary of what the new skill or workflow teaches the AI coding agent.
