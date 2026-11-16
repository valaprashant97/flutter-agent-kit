# API Specification & Endpoint Contracts (API.md)

## 1. Base Configuration
- **Base URL**: Injected via `--dart-define=API_BASE_URL=https://api.example.com`
- **Transport**: HTTPS (TLS 1.3 enforced)
- **Timeouts**: Connect: 15s, Receive: 15s
- **Authentication**: Bearer JWT in `Authorization` header

---

## 2. Endpoints Matrix

### Authentication
- `POST /auth/login`: Authenticate with email/password → Returns `{ access_token, refresh_token, user }`
- `POST /auth/refresh`: Exchange refresh token for new access token → Returns `{ access_token }`
- `POST /auth/logout`: Invalidate session on server

### Items Resource
- `GET /items`: Fetch paginated items list (`?page=1&limit=20`)
- `POST /items`: Create a new item (Requires idempotency key)
- `GET /items/{id}`: Fetch item details
- `PUT /items/{id}`: Update item properties
- `DELETE /items/{id}`: Delete item

---

## 3. Standard Error Response Format
```json
{
  "error": {
    "code": "INVALID_CREDENTIALS",
    "message": "The email or password entered is incorrect.",
    "details": []
  }
}
```
All HTTP exceptions map to typed domain `NetworkFailure` classes.
