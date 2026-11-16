---
name: notifications
description: Local notifications, Windows native toast alerts, push message handling, and payload routing.
---

# notifications

## 1. Skill Name
`notifications`

## 2. Purpose
Provides production standards for configuring and triggering local notifications, handling background push messages (Firebase Cloud Messaging), displaying native Windows toast notifications, and routing users to target screens based on notification payload clicks.

## 3. When to Use
- When sending scheduled local alerts, reminders, or alarms.
- When handling remote push notifications in foreground, background, and terminated states.
- When displaying native Windows desktop toast notifications.

## 4. When Not to Use
- For simple in-app visual banners (use `SnackBar` or `MaterialBanner` instead).

## 5. Required Project Context
- `pubspec.yaml` (`flutter_local_notifications` or `local_notifier`)
- Notification icon assets and notification channel IDs

## 6. Step-by-Step Workflow
1. **Initialize Notification Plugin**: Configure platform-specific initialization settings (Android channel, iOS authorization, Windows shortcut policy).
2. **Request Permissions**: Request notification permissions at an appropriate user moment (not immediately upon cold app launch).
3. **Configure Notification Channels (Android)**: Create explicit `AndroidNotificationChannel` with appropriate importance, sound, and vibration.
4. **Trigger Local Notification**: Display notification with unique ID, title, body, and JSON payload.
5. **Handle Action & Tap Responses**: Attach an `onDidReceiveNotificationResponse` callback that parses the payload and navigates using `GoRouter`.
6. **Windows Native Integration**: On Windows, initialize `local_notifier` or WinRT toast handlers.

## 7. Engineering Rules
- **Channel Importance**: Use `Importance.high` / `Priority.high` only for time-sensitive notifications (e.g., incoming calls, alarms). Use default for non-critical alerts.
- **Payload Safety**: Never put sensitive personal information (passwords, complete credit card numbers, confidential health data) into raw notification payloads.
- **Process Termination Awareness**: Note that local scheduled notifications continue firing on Android/iOS via the OS AlarmManager/APNs, but on Windows, scheduled notifications after process termination require Windows Task Scheduler.

## 8. Code Examples
```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initNotifications({required Function(String? payload) onNotificationTap}) async {
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (response) {
      onNotificationTap(response.payload);
    },
  );
}

Future<void> showNotification({required int id, required String title, required String body, String? payload}) async {
  const androidDetails = AndroidNotificationDetails(
    'main_channel',
    'General Alerts',
    channelDescription: 'Standard application updates and reminders',
    importance: Importance.high,
    priority: Priority.high,
  );
  const details = NotificationDetails(android: androidDetails, iOS: DarwinNotificationDetails());
  await flutterLocalNotificationsPlugin.show(id, title, body, details, payload: payload);
}
```

## 9. Common Mistakes
- Omitting notification icon assets on Android, causing notifications to crash with `ResourceNotFoundException`.
- Neglecting to handle background notification launch payloads when the app is launched from a cold terminated state.
- Assuming scheduled notifications work on desktop when the app is terminated without an OS-level task runner.

## 10. Testing and Verification
- Verify notification displays on target devices (or emulator/simulator).
- Verify tapping the notification foregrounds the app and navigates to the expected payload route.

## 11. Completion Criteria
- Notification service initialized cleanly.
- Permissions requested with user rationale.
- Tapping notification dispatches payload to router.

## 12. Related Skills
- `windows-development`
- `navigation`
- `background-execution`
