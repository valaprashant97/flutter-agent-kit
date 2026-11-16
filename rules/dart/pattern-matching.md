# Dart Pattern Matching & Modern Features

These rules establish patterns, records, and sealed classes as standard idioms in Dart 3.x.

---

## 1. Exhaustive Switch Expressions
Prefer switch expressions over `switch` statements or chained `if-else` blocks when mapping states to values or widgets:
```dart
// Recommended
final statusLabel = switch (order.status) {
  OrderStatus.pending => 'Pending Approval',
  OrderStatus.processing => 'In Fulfillment',
  OrderStatus.shipped => 'Dispatched',
  OrderStatus.delivered => 'Completed',
  OrderStatus.cancelled => 'Cancelled by User',
};
```
*Rule*: Avoid using a `_` default wildcard when switching over enums or sealed classes unless truly intentional. Exhaustiveness ensures compile-time errors when new enum values or subclasses are added.

---

## 2. Object & Record Destructuring
Use pattern matching to extract fields directly in variable declarations and conditions:

### Destructuring JSON Maps
```dart
final json = {'id': '101', 'name': 'Alpha', 'score': 95.5};

if (json case {'id': String id, 'name': String name, 'score': num score}) {
  print('User $name ($id) scored $score');
} else {
  throw FormatException('Invalid JSON payload');
}
```

### Typed Record Multi-Returns
```dart
(int count, double average) computeStats(List<double> numbers) {
  if (numbers.isEmpty) return (0, 0.0);
  final sum = numbers.reduce((a, b) => a + b);
  return (numbers.length, sum / numbers.length);
}

// Destructuring at callsite
final (count, avg) = computeStats([10, 20, 30]);
```

---

## 3. Sealed Class State Modeling
Model all domain events and states with `sealed` classes:
```dart
sealed class DataState<T> {
  const DataState();
}

class DataInitial<T> extends DataState<T> {
  const DataInitial();
}

class DataLoading<T> extends DataState<T> {
  const DataLoading();
}

class DataSuccess<T> extends DataState<T> {
  final T value;
  const DataSuccess(this.value);
}

class DataFailure<T> extends DataState<T> {
  final Exception error;
  const DataFailure(this.error);
}
```
This guarantees exhaustive pattern matching in UI builders without runtime fallthrough bugs.
