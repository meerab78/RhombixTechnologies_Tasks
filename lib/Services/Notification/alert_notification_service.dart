// alert_notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:college_alert_app/Model/alert_model.dart';

class AlertNotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  //  Initialize plugin
  static Future<void> init() async {
    tz.initializeTimeZones(); // Required for scheduled notifications

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings);
  }

  //  Instant test notification
  static Future<void> instantTest() async {
    await _notifications.show(
      1,
      'Instant Test Alert',
      'Agar ye aya to system OK hai 🎉',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alert_test_channel',
          'Alert Test Channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  //  Simple notification
  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    await _notifications.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alert_channel',
          'Alert Channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  //  Schedule notification for a specific date & time
  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await _notifications.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alert_channel',
          'Alert Channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  //  Schedule notifications for all urgent alerts
  static Future<void> scheduleAlertNotifications(List<Alert> alerts) async {
    final now = DateTime.now();

    for (var alert in alerts) {
      if (alert.isUrgent && alert.date.isAfter(now)) {
        // Schedule alert 1 hour before the alert's date
        final scheduledDate = alert.date.subtract(const Duration(hours: 1));

        await scheduleNotification(
          title: alert.title,
          body: alert.message,
          scheduledDate: scheduledDate,
        );
      }
    }
  }
}

//  Request notification permission
Future<void> requestAlertNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}
