# Data Sanitization & Injection Prevention Rules

These rules protect Flutter applications from SQL injection, Cross-Site Scripting (XSS), and malicious deep link manipulation.

---

## 1. SQL Injection Defense in Drift & SQLite

Never concatenate unsanitized user strings directly into raw SQL query strings:

```dart
// VULNERABLE - SQL Injection
final query = "SELECT * FROM users WHERE username = '${userInput}'";
await customSelect(query).get();

// SECURE - Parameterized Binding
await customSelect(
  'SELECT * FROM users WHERE username = ?',
  variables: [Variable.withString(userInput)],
).get();

// BEST - Type-Safe Drift Query Builder
(select(users)..where((u) => u.username.equals(userInput))).get();
```

---

## 2. WebView & JavaScript Execution Security

When rendering HTML or embedding web views via `webview_flutter`:
1. **Disable JavaScript Unless Explicitly Required**: Default `JavaScriptMode.disabled`.
2. **Restrict Navigation**: Implement `NavigationDelegate.onNavigationRequest` to prevent unauthorized domain redirections:
   ```dart
   NavigationDelegate(
     onNavigationRequest: (NavigationRequest request) {
       final uri = Uri.parse(request.url);
       if (uri.host == 'trusted.example.com') {
         return NavigationDecision.navigate;
       }
       return NavigationDecision.prevent; // Block untrusted external redirects
     },
   )
   ```
3. **Never Inject Untrusted User Input into `runJavaScript`**: Malicious strings can execute arbitrary script in the web view context.

---

## 3. Deep Link & URL Parameter Validation

Deep links received from `app_links` or `go_router` must be strictly validated before triggering navigation:
- Validate URL schemes (ensure only registered `https` or custom schemes are parsed).
- Sanitize and validate route parameters (e.g., ensure `userId` matches UUID or integer regex).
- Never automatically trigger state-mutating actions (such as initiating payments or deleting records) solely from a deep link GET parameter without explicit in-app confirmation.
