import 'package:college_alert_app/Model/annoucement_model.dart';
import 'package:flutter/material.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementDetailScreen({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),

      appBar: AppBar(
        title: const Text(
          'Announcement',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF8EE),
        foregroundColor: const Color(0xFF3E2C1C),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 HEADER SECTION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 26),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFF8EE),
                    Color(0xFFEADBC8),
                    Color(0xFFC9A36A),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.campaign_rounded,
                    size: 50,
                    color: Color(0xFF3E2C1C),
                  ),
                  const SizedBox(height: 14),

                  Text(
                    announcement.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E2C1C),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: Color(0xFF6D4C41)),
                      const SizedBox(width: 6),
                      Text(
                        announcement.postedBy,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6D4C41),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Icon(Icons.calendar_today, size: 14, color: Color(0xFF6D4C41)),
                      const SizedBox(width: 6),
                      Text(
                        '${announcement.date.day}-${announcement.date.month}-${announcement.date.year}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6D4C41),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 🔹 CONTENT CARD
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Announcement Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2C1C),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      announcement.description,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.7,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 26),

                    // 🔔 ACTION BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.done_all),
                        label: const Text(
                          "Got it",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC9A36A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 3,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
