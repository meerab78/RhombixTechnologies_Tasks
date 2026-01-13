import 'package:college_alert_app/Model/annoucement_model.dart';
import 'package:college_alert_app/Screens/Annoucements/annoucement_detail_screen.dart';
import 'package:college_alert_app/Widgets/annoucemet_card.dart';
import 'package:flutter/material.dart';
import 'package:college_alert_app/Services/Notification/announcement_notification_service.dart';

class AnnouncementListScreen extends StatefulWidget {
  AnnouncementListScreen({super.key});

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  final List<Announcement> announcements = [
    Announcement(
      title: 'Semester Fee Deadline',
      description: 'Please submit your semester fee before 20th January.',
      date: DateTime.now().add(const Duration(days: 2)),
      postedBy: 'Admin Office',
    ),
    Announcement(
      title: 'Holiday Notice',
      description:
          'University will remain closed on Friday due to maintenance.',
      date: DateTime.now().add(const Duration(days: 3)),
      postedBy: 'Administration',
    ),
    Announcement(
      title: 'Midterm Exams Schedule',
      description: 'Midterm exams schedule has been uploaded on the portal.',
      date: DateTime.now().add(const Duration(days: 4)),
      postedBy: 'Examination Dept',
    ),
    Announcement(
      title: 'Library Timing Update',
      description: 'Library will remain open till 8:00 PM from next week.',
      date: DateTime.now().add(const Duration(days: 5)),
      postedBy: 'Library Staff',
    ),
  ];

  @override
  void initState() {
    super.initState();
    //  Initialize Notification Plugin
    AnnouncementNotificationService.init();
    requestAnnouncementNotificationPermission();
    //  Schedule notifications for announcements
    AnnouncementNotificationService.scheduleAnnouncementNotifications(announcements);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      appBar: AppBar(
        title: const Text(
          'Announcements',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFFFF8EE),
        foregroundColor: const Color(0xFF3E2C1C),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: () async {
              // ✅ Test Notification
              await AnnouncementNotificationService.instantTest();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Test announcement notification sent!'),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFF8EE), Color(0xFFEADBC8), Color(0xFFC9A36A)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final ann = announcements[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AnnouncementCard(
                    announcement: ann,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AnnouncementDetailScreen(announcement: ann),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
