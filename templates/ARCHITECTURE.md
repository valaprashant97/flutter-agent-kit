# Architecture Blueprint (ARCHITECTURE.md)

## 1. Architectural Style & Layering
This application implements **Feature-First Clean Architecture**:
- `lib/core/`: App-wide utilities, theme tokens, networking clients, database engine.
- `lib/features/<feature_name>/`:
  - `domain/`: Pure Dart entities and abstract repository contracts.
  - `data/`: DTOs, data sources, and repository implementations.
  - `presentation/`: Widgets, pages, and state controllers.

---

## 2. Technical Stack Selection
- **Framework**: Flutter 3.x (Dart 3.x)
- **State Management**: [flutter_bloc / flutter_riverpod / provider]
- **Routing**: `go_router` (Declarative navigation with redirect guards)
- **Networking**: `dio` (With QueuedInterceptor for token refresh)
- **Local Database**: `drift` (Type-safe SQLite)
- **Secure Storage**: `flutter_secure_storage` (Hardware-backed keystore)
- **Desktop Window Manager**: `window_manager` & `tray_manager` (Windows)

---

## 3. Data Flow Diagram
```text
UI (Widget) 
  ↓ (Dispatches Event / Calls Action)
State Controller (BLoC / Notifier)
  ↓ (Invokes Domain Contract)
Repository Implementation (Data)
  ↓ (Queries Local Cache / Remote API)
Data Sources (Drift SQLite / Dio REST)
```

---

## 4. Platform Integrations
- **Windows Desktop**: Minimize-to-tray lifecycle via `tray_manager`, native Windows toasts via `local_notifier`, and MSIX packaging.
- **Mobile**: Scoped storage, biometric authentication, and local push notifications.
