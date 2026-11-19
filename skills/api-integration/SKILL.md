---
name: api-integration
description: REST API and WebSocket integration with Dio, request interceptors, exponential backoff, and error mapping.
---

# api-integration

## 1. Skill Name
`api-integration`

## 2. Purpose
Provides production standards for communicating with external RESTful services, WebSockets, and cloud APIs using Dio. Enforces timeout safety, authentication interceptors, retry mechanisms with exponential backoff, JSON serialization, and typed failure translation.

## 3. When to Use
- When integrating backend REST APIs or third-party web services.
- When implementing token refresh flows and request headers.
- When creating network resilience layers that handle flaky connectivity.

## 4. When Not to Use
- For simple local IPC or communicating between Dart isolates.

## 5. Required Project Context
- `pubspec.yaml` (`dio`)
- API endpoints specification, base URL, and auth requirements

## 6. Step-by-Step Workflow
1. **Instantiate Client**: Configure Dio with explicit `connectTimeout`, `receiveTimeout`, and base headers.
2. **Attach Interceptors**: Add authentication header interceptor, logging interceptor (debug only), and error interceptor.
3. **Implement Data Source**: Create remote data source methods returning typed response DTOs.
4. **Implement Auto-Retry**: Configure retry interceptor for idempotent GET requests with exponential backoff.
5. **Map Exceptions**: Translate `DioException` instances into domain `NetworkFailure` types.

## 7. Engineering Rules
- **No Fake Fallback on Failure**: Repositories must never return fake 200 OK mock data or static fallback lists when an API request fails. Display an honest error state with retry options (`docs/REAL_DATA_INTEGRITY.md`).
- **No Fabricated Success**: Never report an operation as successful unless the backend endpoint confirms completion with a valid 2xx status code.
- **No Hardcoded URLs**: Base URLs must be injected via compile-time `--dart-define` or environment configuration.
- **Idempotency of Retries**: Never automatically retry non-idempotent mutating POST/PATCH requests (e.g., checkout/charges) on timeouts without idempotency keys.
- **Zero Raw Exceptions to UI**: The data layer must catch `DioException` and rethrow domain exceptions (`ServerException`, `NoInternetException`).

## 8. Code Examples
```dart
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;
  const UserRemoteDataSourceImpl(this.dio);

  @override
  Future<UserDto> fetchUserProfile(String userId) async {
    try {
      final response = await dio.get('/users/$userId');
      return UserDto.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
```

## 9. Common Mistakes
- Omitting timeouts, causing the application to hang indefinitely on dead TCP sockets.
- Retrying payments or order placement requests automatically on network timeout, causing duplicate charges.
- Committing API keys directly in interceptor headers.

## 10. Testing and Verification
- Write unit tests mocking HTTP responses using `dio_adapter` or `mocktail`.
- Verify behavior on 401 Unauthorized, 404 Not Found, 500 Server Error, and timeout scenarios.

## 11. Completion Criteria
- Remote data source functions correctly with typed models.
- All network errors map to user-friendly domain failures.
- Unit tests verify happy path and error scenarios.

## 12. Related Skills
- `coding-standards` — Database & API Standards (Section 5) of `docs/FLUTTER_CODING_STANDARDS.md`
- `real-data-integrity`
- `error-handling`
- `flutter-architecture`
- `authentication`
- `database-integration`
- `security-audit`
