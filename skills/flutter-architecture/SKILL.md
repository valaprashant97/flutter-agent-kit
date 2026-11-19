---
name: flutter-architecture
description: Architecture design and structuring for production Flutter applications using Feature-First and Clean Architecture principles.
---

# flutter-architecture

## 1. Skill Name
`flutter-architecture`

## 2. Purpose
Enforces scalable, testable separation of concerns in Flutter applications. Guides agents in implementing feature-first modularization, Clean Architecture layering (Presentation, Domain, Data), dependency injection, and repository patterns.

## 3. When to Use
- When designing the structural layout of a new Flutter application.
- When organizing a new feature module into Data, Domain, and Presentation layers.
- When refactoring tightly coupled spaghetti code into decoupled, testable components.

## 4. When Not to Use
- For simple one-off demo scripts or single-file test utilities.
- When an existing project already has an established, working architecture (respect the existing style instead of forcing a full rewrite).

## 5. Required Project Context
- `pubspec.yaml`
- Target feature requirements (user stories or PRD)
- Existing shared utilities in `lib/core/`

## 6. Step-by-Step Workflow
1. **Identify Boundaries**: Define the business boundary for the feature (e.g., `lib/features/auth/`).
2. **Define Domain Entities & Contracts**:
   - Create immutable domain models in `domain/entities/`.
   - Create abstract repository interfaces in `domain/repositories/`.
3. **Implement Data Layer**:
   - Create API DTOs with JSON serialization in `data/models/`.
   - Implement data sources (remote HTTP / local database) in `data/datasources/`.
   - Implement the repository interface in `data/repositories/`.
4. **Implement Presentation Layer**:
   - Create state management controller/BLoC in `presentation/controllers/` or `presentation/bloc/`.
   - Build UI widgets and screens in `presentation/widgets/` and `presentation/pages/`.
5. **Register Dependencies**: Wire the data source, repository, and state controller in the dependency injection container (`get_it` or Riverpod).

## 7. Engineering Rules
- **Dependency Rule**: Dependencies must point inward toward the Domain layer. Domain must have zero dependencies on Flutter UI, Dio, or database drivers.
- **No Direct Remote Calls from UI**: Presentation widgets must never execute direct HTTP requests or raw database queries. All data access must pass through repository abstractions.
- **Feature Encapsulation**: A feature must not import the presentation widgets of another feature directly.

## 8. Code Examples
```dart
// Domain Repository Contract (lib/features/cart/domain/repositories/cart_repository.dart)
abstract interface class CartRepository {
  Future<List<CartItemEntity>> getCartItems();
  Future<void> addItem(CartItemEntity item);
}

// Data Implementation (lib/features/cart/data/repositories/cart_repository_impl.dart)
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataSource localDataSource;

  const CartRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    final dtos = await remoteDataSource.fetchItems();
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<void> addItem(CartItemEntity item) async {
    await remoteDataSource.uploadItem(CartItemDto.fromEntity(item));
    await localDataSource.cacheItem(CartItemDto.fromEntity(item));
  }
}
```

## 9. Common Mistakes
- Importing `package:flutter` or UI classes inside the Domain layer.
- Creating an unnecessary UseCase class for every single 1-line repository pass-through method in small applications.
- Leaving data layer DTOs exposed directly to the UI layer instead of mapping to domain entities.

## 10. Testing and Verification
- Verify domain models and repository implementations with isolated unit tests.
- Run `flutter analyze` to verify no illegal cross-layer import dependencies exist.

## 11. Completion Criteria
- Feature files are placed in their proper `data/`, `domain/`, and `presentation/` directories.
- Dependencies are registered in the DI container.
- Code compiles cleanly with zero warnings.

## 12. Related Skills
- `coding-standards` — 8-step AI workflow and 12 coding standard areas (read first)
- `project-analysis` — Non-destructive codebase audit before architecture changes
- `state-management` — BLoC / Riverpod / Provider selection and patterns
- `api-integration` — Dio, repository implementation, error mapping
- `database-integration` — Drift, Hive, Isar, migrations
