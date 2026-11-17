import 'dart:io';

String _pathForValidation(String targetPath) {
  if (!targetPath.startsWith('file:///')) {
    return targetPath;
  }

  final uri = Uri.parse(targetPath);
  final segments = uri.pathSegments;
  final repositoryName = Directory.current.uri.pathSegments
      .where((segment) => segment.isNotEmpty)
      .last;
  final repositoryIndex = segments.indexOf(repositoryName);

  if (repositoryIndex >= 0 && repositoryIndex + 1 < segments.length) {
    return segments.skip(repositoryIndex + 1).join(Platform.pathSeparator);
  }

  return uri.toFilePath();
}

void main() {
  stdout.writeln('Validating internal markdown file links...');
  final docsDir = Directory('docs');
  int brokenLinks = 0;

  final mdFiles = docsDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.md'));

  for (final file in mdFiles) {
    final lines = file.readAsLinesSync();
    for (final line in lines) {
      final matches = RegExp(r'\[.+?\]\((.+?\.md)\)').allMatches(line);
      for (final match in matches) {
        final targetPath = match.group(1);
        if (targetPath != null &&
            !targetPath.startsWith('http') &&
            !targetPath.startsWith('#')) {
          String pathToCheck = targetPath;
          if (pathToCheck.startsWith('file:///')) {
            try {
              pathToCheck = _pathForValidation(pathToCheck);
            } catch (_) {
              pathToCheck = targetPath.replaceFirst('file:///', '');
            }
          }

          // Resolve relative path or root path
          final resolvedFile = File('${file.parent.path}/$pathToCheck');
          final rootResolved = File(pathToCheck);
          if (!resolvedFile.existsSync() && !rootResolved.existsSync()) {
            stderr.writeln(
              'Potential broken link in ${file.path}: $targetPath',
            );
            brokenLinks++;
          }
        }
      }
    }
  }

  stdout.writeln('Link validation complete. Broken link count: $brokenLinks');
  if (brokenLinks > 0) {
    stderr.writeln('TEST FAILED: Broken internal links detected.');
    exit(1);
  }
  stdout.writeln('TEST PASSED: All internal markdown links are verified.');
}
