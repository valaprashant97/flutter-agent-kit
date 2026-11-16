# Flutter Web Platform Rules & Invariants

These rules govern Flutter Web applications, rendering engines, and browser integration.

---

## 1. Web Renderers: CanvasKit vs. HTML vs. WASM

In modern Flutter (Flutter 3.22+), WebAssembly (WASM) is available alongside CanvasKit and HTML:

| Renderer | Performance Profile | Bundle Size | Best Used For |
| :--- | :--- | :--- | :--- |
| **WASM (WebAssembly)** | Near-native speed, ultra-smooth frame rates | ~2.5 MB | High-performance dashboard & enterprise web apps |
| **CanvasKit** | Consistent Skia pixel rendering, identical to mobile | ~2.0 MB | Graphic-rich apps, precise custom painters |
| **HTML (Legacy)** | Smaller initial payload, faster initial load | ~1.0 MB | Simple text-heavy content websites |

### Compilation Commands:
```bash
# Build with WASM support (requires modern browser headers)
flutter build web --wasm

# Build standard CanvasKit production bundle
flutter build web --release
```

---

## 2. Web Invariants & CORS
1. **Never Import `dart:io` on Web**:
   - `dart:io` (File, Directory, Socket, Platform) is unsupported in the browser and will throw compilation/runtime errors.
   - Use `kIsWeb` guards or conditional imports (`if (dart.library.html) ...` / `if (dart.library.io) ...`).
2. **Handle CORS (Cross-Origin Resource Sharing)**:
   - Web browsers strictly enforce CORS headers on HTTP requests.
   - Configure the backend to return appropriate `Access-Control-Allow-Origin` headers. Do not attempt client-side hacks to bypass browser CORS enforcement.
3. **Browser History & URL Strategy**:
   - Use `usePathUrlStrategy()` from `flutter_web_plugins/url_strategy.dart` to remove the `#` hash from web URLs.
