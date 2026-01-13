import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:college_alert_app/Model/event_model.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  // ✅ Initialize
  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings);
  }

  // ✅ Instant test
  static Future<void> instantTest() async {
    await _notifications.show(
      1,
      'Instant Test',
      'System testing 🎉',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  // ✅ Schedule notification (SAFE)
  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    final tzDate = tz.TZDateTime.from(scheduledDate, tz.local);

    // 🔴 PAST CHECK (CRASH FIX)
    if (tzDate.isBefore(tz.TZDateTime.now(tz.local))) {
      return;
    }

    await _notifications.zonedSchedule(
      0,
      title,
      body,
      tzDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'event_channel',
          'Event Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // ✅ Schedule all events (SAFE)
  static Future<void> scheduleEventNotifications(List<Event> events) async {
    final now = DateTime.now();

    for (var ev in events) {
      // Convert time like "7:10 PM"
      final parts = ev.time.split(RegExp(r'[: ]'));
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      bool isPM = parts[2] == 'PM';

      if (isPM && hour != 12) hour += 12;
      if (!isPM && hour == 12) hour = 0;

      final eventDateTime = DateTime(
        ev.date.year,
        ev.date.month,
        ev.date.day,
        hour,
        minute,
      );

      if (eventDateTime.isBefore(now)) continue;

      await scheduleNotification(
        title: ev.title,
        body: '${ev.description}\nLocation: ${ev.location}',
        scheduledDate: eventDateTime,
      );
    }
  }
}

// ✅ Permission
Future<void> requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}
