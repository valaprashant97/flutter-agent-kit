---
name: localization
description: Internationalization (i18n) and localization (l10n) setup using Flutter gen-l10n, ARB files, and RTL support.
---

# localization

## 1. Skill Name
`localization`

## 2. Purpose
Provides production standards for internationalizing Flutter applications: configuring Flutter's official `gen-l10n` tool, managing `.arb` translation files, handling pluralization and placeholders, supporting Right-to-Left (RTL) languages (Arabic, Hebrew), and dynamic in-app locale switching.

## 3. When to Use
- When adding multi-language support to an application.
- When creating or modifying `.arb` translation files.
- When ensuring layouts properly mirror for RTL writing systems.

## 4. When Not to Use
- For hardcoded single-language internal utilities that will never be translated.

## 5. Required Project Context
- `pubspec.yaml` (`flutter_localizations`, `intl`, `generate: true`)
- `l10n.yaml` configuration file

## 6. Step-by-Step Workflow
1. **Enable Code Generation**: Set `generate: true` under `flutter:` in `pubspec.yaml`.
2. **Configure `l10n.yaml`**: Define ARB file directory, template file, and output class name:
   ```yaml
   arb-dir: lib/l10n
   template-arb-file: app_en.arb
   output-localization-file: app_localizations.dart
   ```
3. **Author Template ARB**: Create `lib/l10n/app_en.arb` with typed placeholders and descriptions:
   ```json
   {
     "@@locale": "en",
     "appTitle": "Enterprise Manager",
     "welcomeMessage": "Welcome back, {userName}!",
     "@welcomeMessage": {
       "description": "Greeting on dashboard",
       "placeholders": {
         "userName": {
           "type": "String",
           "example": "Sarah"
         }
       }
     }
   }
   ```
4. **Generate Dart Localization Code**: Run `flutter gen-l10n` to generate `AppLocalizations`.
5. **Configure `MaterialApp`**: Register `AppLocalizations.localizationsDelegates` and `supportedLocales`.
6. **Support RTL Layouts**: Use `Directionality` and start/end directional alignments (`AlignmentDirectional.centerStart`, `EdgeInsetsDirectional.only(start: 16)`).

## 7. Engineering Rules
- **No Hardcoded User-Facing Strings**: All labels, messages, titles, and validation errors must be referenced via `AppLocalizations.of(context)!.someString`.
- **Use Directional Insets**: Always use `EdgeInsetsDirectional` rather than `EdgeInsets.only(left: ...)` when designing layouts that support both LTR and RTL locales.

## 8. Code Examples
```dart
// Consuming Localized Strings in Widgets
class WelcomeBanner extends StatelessWidget {
  final String userName;
  const WelcomeBanner({required this.userName, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsetsDirectional.all(16),
      child: Text(
        l10n.welcomeMessage(userName),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
```

## 9. Common Mistakes
- Hardcoding left/right padding, causing broken, inverted layouts when running in RTL locales.
- Editing generated `app_localizations.dart` directly instead of modifying `.arb` source files.
- Omitting descriptions and examples in ARB template files, confusing professional translation teams.

## 10. Testing and Verification
- Run `flutter gen-l10n` and verify zero syntax errors in ARB files.
- Write a widget test verifying that switching the locale changes the rendered text strings.

## 11. Completion Criteria
- `l10n.yaml` properly configured.
- Translations generate without warnings.
- Layouts adapt cleanly to both LTR and RTL directions.

## 12. Related Skills
- `ui-implementation`
- `design-system`
- `testing`
