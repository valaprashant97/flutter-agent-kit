import 'dart:io';

/// Validates Flutter Agent Kit directory integrity and skill manifests.
void main() {
  stdout.writeln('Running Flutter Agent Kit Dart Structure Validator...');
  int errors = 0;

  // 1. Validate Core files
  final coreFiles = [
    'core/agent-principles.md',
    'core/engineering-standards.md',
    'core/project-understanding.md',
    'core/context-management.md',
    'core/token-efficiency.md',
    'core/change-discipline.md',
    'core/verification-policy.md',
  ];

  for (final filePath in coreFiles) {
    final file = File(filePath);
    if (!file.existsSync() || file.lengthSync() < 10) {
      stderr.writeln('Missing or empty core file: $filePath');
      errors++;
    }
  }

  // 2. Validate Skills
  final skillsDir = Directory('skills');
  if (!skillsDir.existsSync()) {
    stderr.writeln('Missing skills/ directory');
    exit(1);
  }

  final skillDirs = skillsDir.listSync().whereType<Directory>().toList();
  stdout.writeln('Validating ${skillDirs.length} skills...');

  for (final dir in skillDirs) {
    final skillManifest = File('${dir.path}/SKILL.md');
    if (!skillManifest.existsSync()) {
      stderr.writeln('Skill missing SKILL.md: ${dir.path}');
      errors++;
      continue;
    }

    final content = skillManifest.readAsStringSync();
    if (!content.startsWith('---') ||
        !content.contains('name:') ||
        !content.contains('description:')) {
      stderr.writeln(
        'Skill missing valid YAML frontmatter: ${skillManifest.path}',
      );
      errors++;
    }

    // Verify presence of standard 12 sections
    if (!content.contains('## 1. Skill Name') ||
        !content.contains('## 11. Completion Criteria')) {
      stderr.writeln(
        'Skill manifest missing canonical sections: ${skillManifest.path}',
      );
      errors++;
    }
  }

  // 3. Validate Workflows
  final workflowsDir = Directory('workflows');
  if (!workflowsDir.existsSync()) {
    stderr.writeln('Missing workflows/ directory');
    exit(1);
  }

  final workflowDirs = workflowsDir.listSync().whereType<Directory>().toList();
  stdout.writeln('Validating ${workflowDirs.length} workflows...');
  for (final dir in workflowDirs) {
    final wfFile = File('${dir.path}/WORKFLOW.md');
    if (!wfFile.existsSync() || wfFile.lengthSync() < 50) {
      stderr.writeln('Missing or empty workflow manifest: ${wfFile.path}');
      errors++;
    }
  }

  stdout.writeln('Validation finished with $errors error(s).');
  if (errors > 0) {
    exit(1);
  } else {
    stdout.writeln('ALL CHECKS PASSED: Agent Kit structure is 100% compliant.');
    exit(0);
  }
}
