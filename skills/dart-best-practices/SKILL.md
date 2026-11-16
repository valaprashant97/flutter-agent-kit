---
name: dart-best-practices
description: Idiomatic Dart 3.x programming standards, pattern matching, records, sealed types, and null safety.
---

# dart-best-practices

## 1. Skill Name
`dart-best-practices`

## 2. Purpose
Ensures that all Dart code authored or refactored by AI agents adheres to modern Dart 3.x capabilities: exhaustive pattern matching, switch expressions, records, sealed class state hierarchies, sound null safety, and clean functional programming idioms.

## 3. When to Use
- When writing any Dart function, class, model, or algorithm.
- When refactoring legacy Dart 2.x patterns (e.g., nested `if-else` cascades, raw `dynamic` maps) to modern Dart 3 idioms.
- During code review to identify non-idiomatic Dart patterns.

## 4. When Not to Use
- When targeting an older Dart SDK (<3.0) specified in `pubspec.yaml` where modern features like records and switch expressions are unsupported.

## 5. Required Project Context
- `pubspec.yaml` (verify `sdk: ^3.x.y`)
- `analysis_options.yaml`

## 6. Step-by-Step Workflow
1. **Verify SDK Version**: Check `pubspec.yaml` to confirm Dart 3+ compatibility.
2. **Model State Hierarchies**: Use `sealed class` for domain states to guarantee exhaustive handling.
3. **Replace Nested Conditionals**: Refactor branching logic to switch expressions with pattern matching.
4. **Use Records for Multiple Returns**: Replace ad-hoc tuple classes or loose arrays with typed records `(TypeA, TypeB)`.
5. **Audit Null Safety**: Eliminate unhandled `!` operators and replace with null-coalescing (`??`, `??=`) or guarded patterns.
6. **Apply Const Optimization**: Mark immutable values and literals with `const`.

## 7. Engineering Rules
- **Sound Types Only**: Avoid `dynamic`. Use `Object?` if type is unknown, or parse immediately into a strongly typed record or class.
- **Never Force-Unwrap Without Guard**: `value!` is forbidden unless preceded by an explicit null check or invariant assertion.
- **Exhaustive Patterns**: When switching over enums or sealed classes, do not add a default `_` wildcard unless you genuinely intend to treat all future variants identically.

## 8. Code Examples
```dart
// Sealed class state modeling
sealed class PaymentResult {
  const PaymentResult();
}
final class PaymentSuccess extends PaymentResult {
  final String transactionId;
  const PaymentSuccess(this.transactionId);
}
final class PaymentDeclined extends PaymentResult {
  final String reason;
  const PaymentDeclined(this.reason);
}

// Exhaustive switch expression
String describeResult(PaymentResult result) => switch (result) {
  PaymentSuccess(:final transactionId) => 'Approved: $transactionId',
  PaymentDeclined(:final reason) => 'Declined: $reason',
};
```

## 9. Common Mistakes
- Writing legacy `switch` statements with `break;` instead of clean switch expressions.
- Creating single-use helper classes when a lightweight record `(double lat, double lng)` is cleaner.
- Using `late` to defer null checks rather than using constructor injection.

## 10. Testing and Verification
- Run `dart analyze` to verify that switch expressions are exhaustive and type checks pass.
- Run `dart test` to verify logic correctness.

## 11. Completion Criteria
- Code uses modern Dart 3 syntax.
- Zero `dynamic` or unsafe `!` force-unwraps introduced.
- Passes static analysis with 0 warnings.

## 12. Related Skills
- `flutter-architecture`
- `code-review`
- `debugging`
