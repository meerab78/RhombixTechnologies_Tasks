// import 'package:college_alert_app/Widgets/exams_card.dart';
// import 'package:flutter/material.dart';
// import 'exams_detail_screen.dart';
// import 'package:college_alert_app/Model/exams_model.dart';
// import 'package:intl/intl.dart';

// class ExamListScreen extends StatelessWidget {
//   ExamListScreen({super.key});

//   final List<Exam> exams = [
//     Exam(
//       subject: 'Data Structures',
//       date: DateTime.now().add(const Duration(days: 2)),
//       time: '9:00 AM',
//       location: 'Room 203',
//       description: 'Midterm exam',
//     ),
//     Exam(
//       subject: 'Software Engineering',
//       date: DateTime.now().add(const Duration(days: 5)),
//       time: '11:00 AM',
//       location: 'Room 105',
//       description: 'Final term exam',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F6F1),

//       appBar: AppBar(
//         title: const Text(
//           "Examination Schedule",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFFFFF8EE),
//         elevation: 0,
//       ),

//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFFFFF8EE), Color(0xFFEADBC8), Color(0xFFC9A36A)],
//           ),
//         ),

//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(16),

//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // HEADER TEXT
//                 Text(
//                   "Upcoming Exams",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF3E2C1C),
//                   ),
//                 ),

//                 const SizedBox(height: 6),

//                 Text(
//                   "Stay prepared for your academic assessments",
//                   style: TextStyle(fontSize: 14, color: Color(0xFF6D4C41)),
//                 ),

//                 const SizedBox(height: 20),

//                 // EXAMS LIST
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: exams.length,
//                     itemBuilder: (context, index) {
//                       final exam = exams[index];

//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: ExamCard(
//                           exam: exam,
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => ExamDetailScreen(exam: exam),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:college_alert_app/Services/Notification/exams_notification_service.dart';
import 'package:college_alert_app/Widgets/exams_card.dart';
import 'package:flutter/material.dart';
import 'exams_detail_screen.dart';
import 'package:college_alert_app/Model/exams_model.dart';
import 'package:intl/intl.dart';

class ExamListScreen extends StatefulWidget {
  ExamListScreen({super.key});

  @override
  State<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends State<ExamListScreen> {
  late List<Exam> exams;

  @override
  void initState() {
    super.initState();
    // ✅ Sample exams for testing (5 and 10 seconds later)
    exams = [
      Exam(
        subject: 'Data Structures',
        date: DateTime.now(),
        time: '12:00 PM', // just placeholder, actual time adjusted below
        location: 'Room 203',
        description: 'Midterm exam',
      ),
      Exam(
        subject: 'Software Engineering',
        date: DateTime.now(),
        time: '12:00 PM', // placeholder
        location: 'Room 105',
        description: 'Final term exam',
      ),
    ];

    // Schedule notifications for testing
    scheduleTestNotifications();
  }

  // ✅ Schedule notifications 5 and 10 seconds later for testing
  void scheduleTestNotifications() async {
    await ExamNotificationService.init();
    await requestNotificationPermission();

    for (int i = 0; i < exams.length; i++) {
      final scheduledDate = DateTime.now().add(Duration(seconds: (i + 1) * 5));
      await ExamNotificationService.scheduleNotification(
        title: exams[i].subject,
        body: '${exams[i].description}\nLocation: ${exams[i].location}',
        scheduledDate: scheduledDate,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      appBar: AppBar(
        title: const Text(
          "Examination Schedule",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF8EE),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: () async {
              // Instant test notification
              await ExamNotificationService.instantTest();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Test notification sent!')),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upcoming Exams",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2C1C),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Stay prepared for your academic assessments",
                  style: TextStyle(fontSize: 14, color: Color(0xFF6D4C41)),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: exams.length,
                    itemBuilder: (context, index) {
                      final exam = exams[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ExamCard(
                          exam: exam,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ExamDetailScreen(exam: exam),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
