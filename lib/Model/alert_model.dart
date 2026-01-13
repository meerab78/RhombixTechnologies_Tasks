class Alert {
  final String title;
  final String message;
  final DateTime date;
  final bool isUrgent;

  Alert({
    required this.title,
    required this.message,
    required this.date,
    this.isUrgent = false,
  });
}
