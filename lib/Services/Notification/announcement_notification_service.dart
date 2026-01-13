// announcement_notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:college_alert_app/Model/annoucement_model.dart';

class AnnouncementNotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  //  Initialize notification plugin
  static Future<void> init() async {
    tz.initializeTimeZones();

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
      'Announcement Test',
      'If this arrives, notifications are working 🎉',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'announcement_test_channel',
          'Announcement Test Channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  //  Show simple notification
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
          'announcement_channel_id',
          'Announcements',
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
          'announcement_channel_id',
          'Announcements',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  //  Schedule notifications for all upcoming announcements
  static Future<void> scheduleAnnouncementNotifications(
      List<Announcement> announcements) async {
    final now = DateTime.now();

    for (var ann in announcements) {
      // Only future announcements
      if (ann.date.isAfter(now)) {
        // Schedule 1: 1 day before announcement at 9 AM
        final oneDayBefore = DateTime(
          ann.date.year,
          ann.date.month,
          ann.date.day - 1,
          9,
          0,
        );

        if (oneDayBefore.isAfter(now)) {
          await scheduleNotification(
            title: "Upcoming Announcement: ${ann.title}",
            body: ann.description,
            scheduledDate: oneDayBefore,
          );
        }

        // Schedule 2: On the announcement day 1 hour before
        final oneHourBefore = DateTime(
          ann.date.year,
          ann.date.month,
          ann.date.day,
          9, // 9 AM by default, ya tum chaaho to exact time
          0,
        ).subtract(const Duration(hours: 1));

        if (oneHourBefore.isAfter(now)) {
          await scheduleNotification(
            title: "Reminder: ${ann.title}",
            body: ann.description,
            scheduledDate: oneHourBefore,
          );
        }
      }
    }
  }
}

//  Request notification permission
Future<void> requestAnnouncementNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}
