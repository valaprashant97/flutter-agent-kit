# Dependency Injection & Service Locator Rules

These rules govern dependency injection (DI) patterns, service locators (`get_it`), and provider-based scoping in Flutter.

---

## 1. Principles of Dependency Injection
1. **Decouple Construction from Usage**: Classes should receive their collaborators (repositories, clients, services) via their constructor, rather than instantiating them internally (`new ApiClient()`).
2. **Enable Easy Mocking**: Constructor injection allows passing mocked dependencies during unit testing without monkey-patching.

---

## 2. Using `get_it` Service Locator

When using `get_it` for global service registration:

### Setup in `lib/core/di/injection_container.dart`:
```dart
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // 1. External / Core
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: 'https://api.example.com')));

  // 2. Data Sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(dio: sl()),
  );

  // 3. Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );

  // 4. Blocs / Controllers (Factory = new instance per request)
  sl.registerFactory<UserBloc>(() => UserBloc(repository: sl()));
}
```

### DI Registration Rules:
- **`registerLazySingleton`**: Use for stateless or long-lived shared services (HTTP clients, database helpers, repositories, session stores). Created only when first requested.
- **`registerFactory`**: Use for stateful components that should not share state across different screens (BLoCs, ChangeNotifiers, transient form controllers).
- **Never Call `sl()` Inside Widgets Directly**: In Flutter UI, prefer resolving dependencies at the route level or injecting via `BlocProvider(create: (_) => sl<UserBloc>())` rather than calling `sl<UserBloc>()` inside build methods.

---

## 3. Provider / Riverpod Scoped DI
If the project uses Riverpod or Provider instead of `get_it`:
- Keep providers top-level `final` variables.
- Use scoped providers for screen-specific dependencies that should be automatically disposed when the route pops.
