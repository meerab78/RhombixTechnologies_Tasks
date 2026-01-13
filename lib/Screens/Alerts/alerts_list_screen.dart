import 'package:college_alert_app/Model/alert_model.dart';
import 'package:college_alert_app/Services/Notification/alert_notification_service.dart';
import 'package:college_alert_app/Widgets/alert_card.dart';
import 'package:flutter/material.dart';
import 'alert_detail_screen.dart';

class AlertListScreen extends StatefulWidget {
  AlertListScreen({super.key});

  @override
  State<AlertListScreen> createState() => _AlertListScreenState();
}

class _AlertListScreenState extends State<AlertListScreen> {
  final List<Alert> alerts = [
    Alert(
      title: 'Exam Schedule Updated',
      message: 'Mid-term exam schedule has been updated. Please check portal.',
      date: DateTime.now().add(const Duration(minutes: 1)), // test soon
      isUrgent: true,
    ),
    Alert(
      title: 'Class Cancelled',
      message: 'Today’s 2 PM class has been cancelled.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isUrgent: true,
    ),
    Alert(
      title: 'Library Notice',
      message: 'Library will close at 5 PM today.',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Alert(
      title: 'Fee Reminder',
      message: 'Last date for semester fee submission is 20 Jan.',
      date: DateTime.now().add(const Duration(minutes: 2)), // test soon
      isUrgent: true,
    ),
    Alert(
      title: 'Sports Week',
      message: 'Annual sports week will start from next Monday.',
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Alert(
      title: 'System Maintenance',
      message: 'Student portal will be unavailable tonight 12–2 AM.',
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    //  Initialize plugin and request permission
    AlertNotificationService.init();
    requestAlertNotificationPermission();

    //  Schedule notifications for urgent alerts
    AlertNotificationService.scheduleAlertNotifications(alerts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      appBar: AppBar(
        title: const Text(
          'Campus Alerts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF8EE),
        foregroundColor: const Color(0xFF3E2C1C),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: () async {
              await AlertNotificationService.instantTest();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Test notification sent! 🎉')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            final alert = alerts[index];
            return AlertCard(
              alert: alert,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AlertDetailScreen(alert: alert),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
