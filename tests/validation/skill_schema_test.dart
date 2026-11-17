import 'dart:io';

void main() {
  stdout.writeln(
    'Testing all skill manifests against standard Agent Skill schema...',
  );
  final skillsDir = Directory('skills');
  final skills = skillsDir.listSync().whereType<Directory>().toList();

  for (final skill in skills) {
    final skillFile = File('${skill.path}/SKILL.md');
    if (!skillFile.existsSync()) {
      stderr.writeln('TEST FAILED: ${skill.path} is missing SKILL.md');
      exit(1);
    }

    final content = skillFile.readAsStringSync();
    if (!content.startsWith('---') ||
        !content.contains('name:') ||
        !content.contains('description:')) {
      stderr.writeln('TEST FAILED: Invalid frontmatter in ${skillFile.path}');
      exit(1);
    }
  }

  stdout.writeln(
    'TEST PASSED: All ${skills.length} skills conform to standard schema.',
  );
}
