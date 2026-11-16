# Feature-First Architecture Rules

These rules define the feature-first architectural pattern for scalable Flutter codebases.

---

## 1. Directory Structure

In feature-first architecture, code is grouped primarily by **business domain / feature**, and secondarily by technical layer:

```text
lib/
├── app.dart                    # Root MaterialApp and router setup
├── main.dart                   # Application bootstrap
│
├── core/                       # Shared code used across MULTIPLE features
│   ├── network/                # HTTP/Dio client, base interceptors
│   ├── database/               # Local database setup (Drift, Hive)
│   ├── theme/                  # Theme tokens, colors, typography
│   ├── utils/                  # Formatters, extension methods
│   └── widgets/                # Generic reusable UI (buttons, dialogs)
│
└── features/                   # Business domain modules
    ├── auth/                   # Authentication feature
    │   ├── data/               # Models, DTOs, data sources, repository implementations
    │   ├── domain/             # Entities, repository interfaces, use cases
    │   └── presentation/       # Widgets, screens, BLoCs / Riverpod providers
    │
    ├── dashboard/              # Dashboard feature
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    └── settings/               # Settings & preferences feature
        ├── data/
        ├── domain/
        └── presentation/
```

---

## 2. Invariants & Dependency Rules

1. **Features Must Not Depend Directly on Other Features' Presentation Layers**:
   - Feature `A` should never directly import widgets or state stores from Feature `B`.
   - Cross-feature communication must occur through:
     - Shared domain entities or repository contracts in `core/`.
     - Route parameters or navigation payloads.
     - Global reactive stores or stream buses.
2. **Feature Isolation**: A feature should be largely deletable or relocatable without causing compilation failures across unrelated modules.
3. **Data Layer Hides Behind Domain Interfaces**: The presentation layer talks only to domain abstractions (e.g., `AuthRepository`), never directly to raw remote data sources (`AuthRemoteDataSource`) or HTTP response bodies.
