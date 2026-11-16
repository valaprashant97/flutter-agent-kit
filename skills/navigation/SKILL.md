---
name: navigation
description: Declarative routing with go_router, deep linking, nested shell navigation, and authentication guards.
---

# navigation

## 1. Skill Name
`navigation`

## 2. Purpose
Provides production standards for implementing declarative routing using `go_router`. Manages deep linking, URL path parsing, nested navigation (`ShellRoute` / `StatefulShellRoute`), and authentication redirect guards.

## 3. When to Use
- When configuring app-wide routing and screen transitions.
- When supporting web URLs, deep links, or desktop navigation history.
- When protecting routes with authentication or permission guards.

## 4. When Not to Use
- For simple imperative dialogs or transient bottom sheets where `showDialog()` or `showModalBottomSheet()` is standard.

## 5. Required Project Context
- `pubspec.yaml` (`go_router`)
- Screen inventory and authentication state store

## 6. Step-by-Step Workflow
1. **Define Route Enums / Constants**: Create typed route names and paths in `lib/core/routing/app_routes.dart`.
2. **Configure `GoRouter`**: Set up `GoRouter` with `initialLocation`, routes list, and error builder.
3. **Implement Nested Navigation**: Use `StatefulShellRoute.indexedStack` for persistent bottom navigation bars or desktop sidebars.
4. **Implement Redirect Guards**: Add a top-level `redirect` callback that evaluates authentication status and redirects unauthenticated users to `/login`.
5. **Connect Router to App**: Pass `routerConfig: appRouter` into `MaterialApp.router`.

## 7. Engineering Rules
- **Declarative Navigation**: Prefer `context.goNamed(...)` or `context.go(...)` over imperative `Navigator.push()` to maintain synchronized URL state on Web and Desktop.
- **Route Parameter Validation**: Always validate route parameters (`state.pathParameters['id']`) before passing them to domain layers.
- **Listen to Auth State**: Pass an auth `Listenable` (e.g., `refreshListenable: GoRouterRefreshStream(authBloc.stream)`) to `GoRouter` so redirects re-evaluate automatically when auth state changes.

## 8. Code Examples
```dart
final appRouter = GoRouter(
  initialLocation: '/dashboard',
  refreshListenable: authStateListenable,
  redirect: (context, state) {
    final isLoggedIn = authStateListenable.value.isAuthenticated;
    final isGoingToLogin = state.matchedLocation == '/login';

    if (!isLoggedIn && !isGoingToLogin) return '/login';
    if (isLoggedIn && isGoingToLogin) return '/dashboard';
    return null; // No redirection required
  },
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => AppScaffold(shell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              name: 'dashboard',
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
```

## 9. Common Mistakes
- Hardcoding string paths at callsites instead of using named routes.
- Triggering infinite redirect loops by redirecting unauthenticated users to a route that itself requires authentication.

## 10. Testing and Verification
- Write widget tests pumping `MaterialApp.router` with mock routes.
- Test deep link redirection using `appRouter.go('/unauthenticated_route')`.

## 11. Completion Criteria
- Declarative routes configured in a centralized file.
- Redirect guards protect private routes.
- Web URL paths update accurately.

## 12. Related Skills
- `flutter-architecture`
- `authentication`
- `responsive-design`
