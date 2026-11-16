# Dio HTTP Client & Interceptor Rules

These rules govern the configuration and usage of `dio` as the primary HTTP networking client in Flutter.

---

## 1. Standard Client Configuration

Always configure a dedicated `Dio` instance with explicit timeouts and base options:

```dart
import 'package:dio/dio.dart';

Dio createDioClient({required String baseUrl}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      responseType: ResponseType.json,
    ),
  );

  // Add interceptors
  dio.interceptors.addAll([
    AuthInterceptor(),
    LoggingInterceptor(), // Disabled in production builds
  ]);

  return dio;
}
```

---

## 2. Token Refresh Interceptor Pattern

Handle expired 401 Unauthorized responses with an automatic, thread-safe token refresh interceptor:

```dart
class AuthInterceptor extends QueuedInterceptor {
  final TokenStorage tokenStorage;
  final Dio authDio;

  AuthInterceptor({required this.tokenStorage, required this.authDio});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await tokenStorage.getRefreshToken();
      if (refreshToken != null) {
        try {
          // Perform refresh using separate Dio instance to prevent infinite loop
          final response = await authDio.post('/auth/refresh', data: {'refresh_token': refreshToken});
          final newAccessToken = response.data['access_token'] as String;
          await tokenStorage.saveAccessToken(newAccessToken);

          // Retry the original request with new token
          err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          final cloneReq = await authDio.fetch(err.requestOptions);
          return handler.resolve(cloneReq);
        } catch (e) {
          await tokenStorage.clearTokens();
          // Forward original error to trigger logout
        }
      }
    }
    handler.next(err);
  }
}
```

*Rule*: Use `QueuedInterceptor` instead of `Interceptor` when handling token refreshes. This queues subsequent incoming requests while the refresh is pending, preventing multiple simultaneous refresh calls.
