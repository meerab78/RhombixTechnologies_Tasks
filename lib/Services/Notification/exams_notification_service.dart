import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:college_alert_app/Model/exams_model.dart';

class ExamNotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  // ✅ Initialize notification plugin
  static Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings);
  }

  // ✅ Instant test notification
  static Future<void> instantTest() async {
    await _notifications.show(
      1,
      'Instant Test',
      'Agar ye aya to system OK hai 🎉',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'exam_test_channel',
          'Exam Test Channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  // ✅ Schedule a single notification
  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    if (scheduledDate.isAfter(DateTime.now())) {
      await _notifications.zonedSchedule(
        scheduledDate.millisecondsSinceEpoch ~/ 1000, // unique id
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'exam_channel',
            'Exam Notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  // ✅ Schedule exam notifications: 2 days & 1 hour before
  static Future<void> scheduleExamNotifications(List<Exam> exams) async {
    for (var exam in exams) {
      // Convert exam time string to DateTime
      final timeParts = exam.time.split(RegExp(r'[: ]'));
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);
      final isPM = timeParts[2].toUpperCase() == 'PM';
      if (isPM && hour != 12) hour += 12;
      if (!isPM && hour == 12) hour = 0;

      final examDateTime =
          DateTime(exam.date.year, exam.date.month, exam.date.day, hour, minute);

      // ⏰ 2 days before
      final twoDaysBefore = examDateTime.subtract(const Duration(days: 2));
      await scheduleNotification(
        title: 'Upcoming Exam: ${exam.subject}',
        body: '${exam.description}\nLocation: ${exam.location}\nExam in 2 days!',
        scheduledDate: twoDaysBefore,
      );

      // ⏰ 1 hour before
      final oneHourBefore = examDateTime.subtract(const Duration(hours: 1));
      await scheduleNotification(
        title: 'Exam Soon: ${exam.subject}',
        body: '${exam.description}\nLocation: ${exam.location}\nExam in 1 hour!',
        scheduledDate: oneHourBefore,
      );
    }
  }
}

// ✅ Request notification permission
Future<void> requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}
