# GetX Architecture & State Management Rules

This guide provides architectural rules and memory-safe patterns for maintaining and extending Flutter applications that use **GetX**.

---

## 1. Core Principles in Brownfield Applications

When an existing application uses GetX:
- **Respect Existing Architecture**: Do not rewrite GetX code into BLoC or Riverpod unless explicitly instructed.
- **Enforce Separation of Concerns**: Keep business logic, network requests, and persistence inside `GetxController`. Never place business logic directly in UI widgets.
- **Explicit Lifecycle Management**: Prevent memory leaks by properly scoping controllers using `Bindings` and `Get.lazyPut()`.

---

## 2. Controller Design & State Reactivity

### Reactive State (`.obs` & `Obx`)
Use reactive variables (`RxString`, `RxInt`, `RxList`, `.obs`) for fine-grained UI updates:
```dart
class CounterController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
}

// In Widget
class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CounterController>();
    return Scaffold(
      body: Center(
        child: Obx(() => Text('Count: ${controller.count}')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### Simple State (`update()` & `GetBuilder`)
For heavy widgets or low-resource devices, prefer `GetBuilder` over `Obx` to avoid reactive stream subscription overhead:
```dart
class HeavyListController extends GetxController {
  List<Item> items = [];

  void updateItems(List<Item> newItems) {
    items = newItems;
    update(['items_list']); // Targeted update by ID
  }
}

// In Widget
GetBuilder<HeavyListController>(
  id: 'items_list',
  builder: (controller) => ListView.builder(
    itemCount: controller.items.length,
    itemBuilder: (context, i) => ItemTile(item: controller.items[i]),
  ),
);
```

---

## 3. Dependency Injection Hygiene

### Rules for Controller Registration
1. **Never use `Get.put()` globally in `main.dart`** for screen-specific controllers. This keeps controllers in memory forever.
2. **Use `Get.lazyPut()` inside `Bindings`**: Controllers are instantiated only when the route is loaded and automatically disposed when the route is popped.
   ```dart
   class ProfileBinding extends Bindings {
     @override
     void dependencies() {
       Get.lazyPut<ProfileController>(() => ProfileController(repository: Get.find()));
     }
   }
   ```
3. **Use `permanent: false` by default**: Only services inheriting from `GetxService` (like `AuthService` or `StorageService`) should remain in memory across the entire app session.

---

## 4. Preventing Common GetX Pitfalls & Memory Leaks

| Anti-Pattern | Root Cause | Correct Pattern |
| :--- | :--- | :--- |
| **`Get.put()` inside `build()`** | Re-registers controller on every frame or prevents cleanup | Use `Bindings` or register in route definition |
| **Mutating `.obs` list without reassigning** | UI does not update if list reference is unchanged | Use `items.refresh()` or `items.assignAll(newList)` |
| **Using `Get.context` across async gaps** | Context may become detached or null | Use standard `if (!mounted) return;` with widget `BuildContext` |
| **Unclosed stream subscriptions in Controller** | Memory leak when route is popped | Cancel `StreamSubscription` in `onClose()` |
| **Overusing `Get.snackbar` and `Get.dialog`** | Bypasses Navigator key and breaks widget tests | Use `ScaffoldMessenger.of(context)` or explicit `showDialog` |

---

## 5. Testing GetX Controllers

GetX controllers can be unit tested without Flutter UI bindings:
```dart
void main() {
  late CounterController controller;

  setUp(() {
    controller = CounterController();
  });

  tearDown(() {
    controller.onClose();
  });

  test('increment increases count by 1', () {
    expect(controller.count.value, 0);
    controller.increment();
    expect(controller.count.value, 1);
  });
}
```
