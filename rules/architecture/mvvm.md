# Model-View-ViewModel (MVVM) Architecture in Flutter

This guide outlines the production rules for implementing the **Model-View-ViewModel (MVVM)** pattern in Flutter with minimal or zero external dependencies using native Flutter primitives (`ChangeNotifier`, `ValueNotifier`, and `ListenableBuilder`).

---

## 1. MVVM Architectural Responsibilities

In Flutter MVVM:
- **View (UI Layer)**:
  - `StatelessWidget` or `StatefulWidget` responsible strictly for layout, styling, and user interaction capture.
  - Subscribes to the ViewModel via `ListenableBuilder` or `AnimatedBuilder`.
  - Forwards user events to the ViewModel methods (e.g. `viewModel.onLoginPressed()`).
  - Contains **zero business logic, data transformation, or direct repository access**.
- **ViewModel (Presentation Logic Layer)**:
  - Extends `ChangeNotifier` or manages `ValueNotifier` instances.
  - Interacts with domain use cases or repositories to fetch and update data.
  - Transforms raw model data into UI-ready formatted properties.
  - Contains **no UI code and no `BuildContext` references**.
- **Model (Domain & Data Layer)**:
  - Immutable domain entities, data transfer objects (DTOs), and repository interfaces.

---

## 2. Canonical Implementation Pattern

### The ViewModel
```dart
import 'package:flutter/foundation.dart';

class UserProfileViewModel extends ChangeNotifier {
  final UserRepository _repository;

  UserProfileViewModel({required UserRepository repository}) : _repository = repository;

  UserProfileState _state = const UserProfileInitial();
  UserProfileState get state => _state;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadProfile(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _repository.getUser(userId);
      _state = UserProfileLoaded(user);
    } catch (e) {
      _state = UserProfileError(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

### The View
```dart
import 'package:flutter/material.dart';

class UserProfileView extends StatelessWidget {
  final UserProfileViewModel viewModel;

  const UserProfileView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return switch (viewModel.state) {
            UserProfileInitial() => const Center(child: Text('Press load to begin')),
            UserProfileLoaded(:final user) => ProfileDetails(user: user),
            UserProfileError(:final message) => ErrorView(
                message: message,
                onRetry: () => viewModel.loadProfile('current_user'),
              ),
          };
        },
      ),
    );
  }
}
```

---

## 3. Core MVVM Rules & Invariants

1. **No `BuildContext` in ViewModel**: Never pass `BuildContext` into a ViewModel constructor or method. Navigation, dialogs, and snackbars must be handled via callbacks or event streams in the View layer.
2. **Selective Rebuilds**: Use `ListenableBuilder` scoped to the exact subtree needing updates rather than wrapping the entire `Scaffold`.
3. **Disposal Hygiene**: If the ViewModel is instantiated inside a `StatefulWidget`, it must be disposed in `dispose()`:
   ```dart
   @override
   void dispose() {
     _viewModel.dispose();
     super.dispose();
   }
   ```
4. **Unit Testability**: Because ViewModels do not reference Flutter UI widgets, test them using standard `test()` suites with mocked repositories:
   ```dart
   test('loadProfile updates state to loaded on success', () async {
     when(() => mockRepo.getUser('1')).thenAnswer((_) async => mockUser);
     await viewModel.loadProfile('1');
     expect(viewModel.state, isA<UserProfileLoaded>());
   });
   ```
