import 'package:flutter/material.dart';
import 'package:college_alert_app/Model/exams_model.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  final VoidCallback onTap;

  const ExamCard({super.key, required this.exam, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.school, color: Color(0xFFC9A36A)),
        title: Text(exam.subject),
        subtitle: Text(
          '${exam.date.day}-${exam.date.month}-${exam.date.year} • ${exam.time}\n${exam.location}',
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
