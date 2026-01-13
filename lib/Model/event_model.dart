class Event {
  final String title;
  final DateTime date;
  final String time;
  final String location;
  final String description;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
  });
 String get status {
    final today = DateTime.now();
    final onlyToday = DateTime(today.year, today.month, today.day);
    final onlyEventDate = DateTime(date.year, date.month, date.day);

    if (onlyEventDate == onlyToday) {
      return 'today';
    } else if (onlyEventDate.isBefore(onlyToday)) {
      return 'past';
    } else {
      return 'upcoming';
    }
  }
}
