# Modular Architecture & Package Slicing Rules

This guide outlines the architectural rules and structuring standards for building enterprise, multi-package, or modular Flutter applications.

---

## 1. Modular Principles & Directory Layout

As applications scale beyond 20+ screens, monolithic codebases suffer from slow compile times, tangled dependencies, and regression risk. A modular architecture splits the application into decoupled, independently testable packages or self-contained modules.

### Recommended Workspace Layout
```text
my_app/
├── apps/
│   └── mobile_app/         # Entry point: main.dart, app theme, router config
├── packages/
│   ├── core/
│   │   ├── core_network/   # Dio client, interceptors, error mapping
│   │   ├── core_database/  # Drift/Isar database instances & migrations
│   │   ├── core_ui/        # Design system, atomic widgets, colors, typography
│   │   └── core_analytics/ # Logging, crash reporting, telemetry
│   └── features/
│       ├── feature_auth/   # Login, registration, token refresh
│       ├── feature_profile/# User profile view, avatar upload
│       └── feature_billing/# In-app purchases, stripe integration
└── melos.yaml              # Monorepo workspace configuration
```

---

## 2. Dependency Invariants & Graph Rules

1. **Strict Directional Dependencies**:
   - `apps/*` depends on `features/*` and `core/*`.
   - `features/*` depends on `core/*`.
   - **Feature modules must NEVER depend directly on sibling feature modules** (e.g., `feature_profile` must NOT depend on `feature_billing`).
2. **Preventing Circular Dependencies**:
   - If `feature_auth` needs to navigate to `feature_profile`, it must use an abstracted route contract, deep link URL, or an application-level coordinator registered in `apps/mobile_app`.
3. **Public API Surface (`lib/<package_name>.dart`)**:
   - Every module must expose an explicit public barrel file:
   ```dart
   // packages/features/feature_auth/lib/feature_auth.dart
   export 'src/presentation/login_screen.dart';
   export 'src/domain/auth_state.dart';
   // Do NOT export internal DTOs, network interceptors, or private widgets
   ```

---

## 3. Communication Between Modules

### Abstracted Route Navigation
Instead of importing concrete view widgets across modules, navigate via route paths or interface contracts:
```dart
// Inside feature_auth:
Navigator.of(context).pushNamed('/profile'); // Decoupled navigation

// Or with GoRouter:
context.go('/profile');
```

### Event Bus / Shared Reactive State
When features need to share state updates (e.g., user logs out in `feature_profile` and all features must reset), use:
- Application-level state container in `core` (e.g. `AuthStateProvider`).
- An event stream or message bus exposed via `core_analytics` or `core_foundation`.

---

## 4. Testing & CI in Modular Repositories

- **Isolated Unit Testing**: Feature packages must have their own `test/` directory and run independently:
  ```bash
  cd packages/features/feature_auth && flutter test
  ```
- **Fast CI Execution**: In CI workflows (e.g. GitHub Actions), use tools like Melos to run tests only on packages changed in the current PR:
  ```bash
  melos exec --dir-exists=test -- flutter test
  ```
