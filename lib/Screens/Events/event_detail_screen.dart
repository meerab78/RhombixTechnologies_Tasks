import 'package:college_alert_app/Model/event_model.dart';
import 'package:college_alert_app/Services/Notification/notification_service.dart';
import 'package:college_alert_app/Widgets/reusable%20_infoTile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      body: Column(
        children: [
          // 🔹 Header with Gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFF8EE),
                  Color(0xFFEADBC8),
                  Color(0xFFC9A36A),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
                const SizedBox(height: 16),
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2C1C),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ReusableInfoTile(
                    icon: Icons.calendar_today,
                    title: "Date",
                    value: DateFormat('dd MMM yyyy').format(event.date),
                  ),
                  ReusableInfoTile(
                    icon: Icons.access_time,
                    title: "Time",
                    value: event.time,
                  ),
                  ReusableInfoTile(
                    icon: Icons.location_on,
                    title: "Location",
                    value: event.location,
                  ),

                  const SizedBox(height: 20),

                  // 🔔 NOTIFY BUTTON
                  // 🔔 NOTIFY BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.notifications_active),
                      label: const Text(
                        "Notify Me",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC9A36A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 4,
                      ),
                      onPressed: () {
                        // 🔹 Parse event time
                        final timeParts = event.time.split(
                          RegExp(r'[: ]'),
                        ); // ["10", "00", "AM"]
                        int hour = int.parse(timeParts[0]);
                        int minute = int.parse(timeParts[1]);
                        String period = timeParts[2]; // AM or PM

                        if (period.toUpperCase() == 'PM' && hour != 12) {
                          hour += 12;
                        } else if (period.toUpperCase() == 'AM' && hour == 12) {
                          hour = 0;
                        }

                        final eventDateTime = DateTime(
                          event.date.year,
                          event.date.month,
                          event.date.day,
                          hour,
                          minute,
                        );

                        // 🔹 Notify 1 hour before
                        // final notifyTime = eventDateTime.subtract(
                        //   const Duration(hours: 1),
                        // );
                        // 🔹 TESTING: 5 seconds later notification
                        final notifyTime = DateTime.now().add(
                          const Duration(seconds: 5),
                        );

                        // 🔹 Schedule notification
                        NotificationService.scheduleNotification(
                          title: 'Reminder: ${event.title}',
                          body: 'Your event starts at ${event.time}',
                          scheduledDate: notifyTime.isBefore(DateTime.now())
                              ? DateTime.now().add(
                                  const Duration(seconds: 5),
                                ) // fallback
                              : notifyTime,
                        );

                        // 🔹 Confirmation SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "🔔 Notification scheduled! You will be reminded 1 hour before the event.",
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Description Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E2C1C),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            event.description,
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
