# Effective Dart Style & Conventions

These rules enforce official Effective Dart conventions across style, documentation, usage, and design.

---

## 1. Naming Conventions
- **Types**: `PascalCase` for classes, enums, typedefs, and type parameters (`UserProfile`, `HttpResult<T>`).
- **Files & Libraries**: `snake_case` for all `.dart` file names (`user_profile_view.dart`, `auth_repository.dart`).
- **Identifiers**: `camelCase` for variable names, function names, parameter names, and named constructors (`fetchUserProfile`, `userId`, `User.guest()`).
- **Constants**: `lowerCamelCase` for constants, matching modern Dart conventions (`defaultTimeout`, `maxRetryCount`). Avoid `SCREAMING_CAPS`.
- **Private Identifiers**: Prefix with `_` for library-private members (`_isLoading`, `_handleTap`).

---

## 2. Constructor & Parameter Best Practices
- **Prefer Initializing Formals**:
  ```dart
  // GOOD
  class Point {
    final double x;
    final double y;
    const Point(this.x, this.y);
  }
  ```
- **Use Named Parameters for Multi-Argument Functions**:
  When a constructor or function accepts more than two parameters, convert them to named parameters for clarity at callsites:
  ```dart
  const UserCard({
    required this.name,
    required this.email,
    this.avatarUrl,
    this.onTap,
    super.key,
  });
  ```
- **Use `super.key`**: Modern Dart 2.17+ syntax should always be used for widget keys:
  ```dart
  const MyWidget({super.key});
  ```

---

## 3. Clean Code Rules
- **Prefer `final` for Local Variables**: Declare variables as `final` when their reference does not change after assignment.
- **Do Not Type Annotate Initialized Local Variables**:
  ```dart
  // AVOID
  String greeting = 'Hello';

  // PREFER
  final greeting = 'Hello';
  ```
- **Use Collection-If and Collection-For**:
  ```dart
  final actions = [
    ActionButton(label: 'Save'),
    if (isAdmin) ActionButton(label: 'Delete'),
    for (final item in extraActions) ActionButton(label: item.title),
  ];
  ```
- **Avoid Unnecessary Getters and Setters**: If a property merely gets and sets a private field without logic, expose it as a public `final` field.
