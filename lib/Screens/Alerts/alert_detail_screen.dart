import 'package:college_alert_app/Model/alert_model.dart';
import 'package:flutter/material.dart';

class AlertDetailScreen extends StatelessWidget {
  final Alert alert;

  const AlertDetailScreen({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),

      appBar: AppBar(
        title: const Text('Alert Details'),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF8EE),
        foregroundColor: const Color(0xFF3E2C1C),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 26),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: alert.isUrgent
                      ? [Colors.red.shade300, Colors.red.shade600]
                      : const [
                          Color(0xFFFFF8EE),
                          Color(0xFFEADBC8),
                          Color(0xFFC9A36A),
                        ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    alert.isUrgent
                        ? Icons.warning_amber_rounded
                        : Icons.notifications_active,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    alert.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${alert.date.day}-${alert.date.month}-${alert.date.year}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            // 🔹 BODY CARD
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (alert.isUrgent)
                      Row(
                        children: const [
                          Icon(Icons.priority_high, color: Colors.red),
                          SizedBox(width: 6),
                          Text(
                            'Urgent Alert',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                    if (alert.isUrgent) const SizedBox(height: 14),

                    Text(
                      alert.message,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 🔔 ACTION BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text(
                          'Mark as Read',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: alert.isUrgent
                              ? Colors.red
                              : const Color(0xFFC9A36A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 3,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('✔ Alert marked as read'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
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
