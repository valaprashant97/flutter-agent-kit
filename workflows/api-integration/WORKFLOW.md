# Workflow: API Integration & Remote Networking

This workflow guides an AI coding agent through architecting, implementing, securing, and testing REST/GraphQL networking in Flutter using Dio.

---

## 1. Entry Conditions
- Remote API endpoints, OpenAPI/Swagger specifications, or Postman collections are available.
- Target feature requires fetching remote resources or submitting mutations.

---

## 2. Step-by-Step Procedure

### Phase 1: API Contract Documentation
1. Create or update `docs/API.md` using `templates/API.md`.
2. Define base URLs, environment endpoints (Development, Staging, Production), authentication schemes, headers, request bodies, and expected response payloads.

### Phase 2: HTTP Client Configuration (Dio Singleton)
1. Configure `Dio` instance with:
   - Base URL and default headers (`Accept: application/json`, `Content-Type: application/json`).
   - Strict connection and receive timeouts:
     ```dart
     BaseOptions(
       baseUrl: ApiConfig.baseUrl,
       connectTimeout: const Duration(seconds: 10),
       receiveTimeout: const Duration(seconds: 15),
       sendTimeout: const Duration(seconds: 10),
     )
     ```
2. Register Interceptors:
   - **Auth Interceptor**: Attaches `Bearer <token>` to protected endpoints; triggers automatic token refresh on 401.
   - **Logging Interceptor**: Logs requests/responses in debug mode only; scrubs Authorization headers and sensitive passwords.
   - **Error Interceptor**: Catches `DioException` and transforms it into typed domain failures.

### Phase 3: DTO Modeling & Serialization
1. Author Data Transfer Objects (DTOs) with sound null safety.
2. Implement JSON serialization via `json_serializable` or `@freezed`.
3. Implement `toDomain()` mapper method to convert DTOs into clean domain entities.

### Phase 4: Remote Data Source & Repository Implementation
1. Create `RemoteDataSource` interface and implementation.
2. Return functional `Result<T, Failure>` from repository methods (`rules/error-handling/domain-errors.md`).
3. Apply exponential backoff with jitter on transient network calls (`rules/error-handling/recovery-retries.md`).

### Phase 5: Testing & Mocking
1. Author unit tests mocking the HTTP client via `mocktail` or `http_mock_adapter`.
2. Test happy paths (200 OK), client errors (400, 404), unauthorized sessions (401), and network timeouts.

---

## 3. Exit Criteria & Quality Gates
- [ ] `docs/API.md` documents all consumed endpoints.
- [ ] Strict connection and receive timeouts are enforced.
- [ ] Sensitive headers and tokens are scrubbed from telemetry/logs.
- [ ] All network calls map low-level exceptions to sealed `Failure` instances.
- [ ] Unit tests pass with 100% assertions satisfied using mock network adapters.

---

## 4. Related Skills & Rules
- `skills/api-integration/`
- `skills/error-handling/`
- `rules/networking/dio.md`
- `rules/networking/error-handling.md`
- `rules/networking/caching-offline.md`
