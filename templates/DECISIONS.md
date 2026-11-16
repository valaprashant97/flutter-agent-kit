# Architecture Decision Records (DECISIONS.md)

This log records major technical and architectural decisions, their context, and trade-offs. Permanent decisions are recorded here to prevent agents from randomly altering established architecture.

---

## ADR-001: Selection of State Management Solution
- **Date**: [YYYY-MM-DD]
- **Status**: Accepted
- **Decision**: Adopt [flutter_bloc / flutter_riverpod / provider] for app-wide state management.
- **Context**: The application requires predictable state transitions, thorough testability, and decoupled business logic.
- **Consequences**: All feature modules must implement controllers using this pattern. Introducing alternative state management libraries requires explicit architectural approval.

---

## ADR-002: Selection of Local Persistence Engine
- **Date**: [YYYY-MM-DD]
- **Status**: Accepted
- **Decision**: Adopt Drift (type-safe SQLite) for structured relational caching and `flutter_secure_storage` for credentials.
- **Context**: The app requires offline-first relational queries and secure storage of JWT authentication tokens.
- **Consequences**: Complex tables must be defined as Drift tables with explicit migrations. Plaintext SharedPreferences must not store auth tokens.

---

## ADR-003: Desktop Window Management & Tray Strategy
- **Date**: [YYYY-MM-DD]
- **Status**: Accepted
- **Decision**: Implement `window_manager` and `tray_manager` on Windows desktop with minimize-to-tray lifecycle.
- **Context**: Users expect the Windows application to run as a persistent utility in the notification tray without cluttering the taskbar.
- **Consequences**: Window close events (`onWindowClose`) intercept termination and minimize to tray; process termination is restricted to explicit tray menu 'Exit'.
