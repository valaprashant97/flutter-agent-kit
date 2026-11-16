import 'dart:io';

void main() {
  stdout.writeln('Testing repository structural completeness...');
  final requiredDirs = [
    'core',
    'rules',
    'rules/dart',
    'rules/flutter',
    'rules/architecture',
    'rules/ui-ux',
    'rules/state-management',
    'rules/database',
    'rules/networking',
    'rules/error-handling',
    'rules/security',
    'rules/testing',
    'rules/performance',
    'rules/platform/windows',
    'skills',
    'workflows',
    'prompts',
    'templates',
    'mcp',
    'docs',
  ];

  for (final dir in requiredDirs) {
    if (!Directory(dir).existsSync()) {
      stderr.writeln('TEST FAILED: Missing required directory $dir');
      exit(1);
    }
  }
  stdout.writeln('TEST PASSED: All required directories exist.');
}
