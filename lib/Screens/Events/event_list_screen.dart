import 'package:college_alert_app/Model/event_model.dart';
import 'package:college_alert_app/Screens/Calender/horizontal_calender.dart';
import 'package:college_alert_app/Screens/Events/event_detail_screen.dart';
import 'package:college_alert_app/Screens/Events/selected_event_card.dart';
import 'package:college_alert_app/Services/Notification/notification_service.dart';
import 'package:college_alert_app/Widgets/header_section.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventListScreen extends StatefulWidget {
  EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

// ✅ Global events list
List<Event> events = [
  Event(
    title: 'AI Seminar',
    date: DateTime(2026, 1, 12),
    time: '7:10 PM',
    location: 'Main Auditorium',
    description: 'AI awareness seminar',
  ),
  Event(
    title: 'Flutter Workshop',
    date: DateTime(2026, 1, 9),
    time: '11:00 AM',
    location: 'Lab 2',
    description: 'Flutter basics workshop',
  ),
  Event(
    title: 'Tech Talk',
    date: DateTime.now().add(const Duration(seconds: 10)), // testing
    time: '2:00 PM',
    location: 'Conference Room',
    description: 'Tech talk on AI and ML',
  ),
  Event(
    title: 'Hackathon',
    date: DateTime.now().add(const Duration(days: 3)),
    time: '9:00 AM',
    location: 'Lab 1',
    description: '24-hour coding challenge',
  ),
  Event(
    title: 'Past Event Example',
    date: DateTime.now().subtract(const Duration(days: 5)),
    time: '1:00 PM',
    location: 'Room 101',
    description: 'Already happened',
  ),
];

// ✅ Helper functions
Event? getEventForDate(DateTime date) {
  try {
    return events.firstWhere(
      (ev) =>
          ev.date.day == date.day &&
          ev.date.month == date.month &&
          ev.date.year == date.year,
    );
  } catch (_) {
    return null;
  }
}

List<Event> upcomingEvents() {
  final today = DateTime.now();
  final onlyToday = DateTime(today.year, today.month, today.day);
  return events.where((ev) {
    final evDate = DateTime(ev.date.year, ev.date.month, ev.date.day);
    return evDate.isAfter(onlyToday);
  }).toList();
}

class _EventListScreenState extends State<EventListScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    scheduleAllNotifications(); // ✅ Schedule notifications on screen load
  }

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void scheduleAllNotifications() {
  final now = DateTime.now();

  for (var ev in upcomingEvents()) {
    // Date + time combine
    DateTime eventDateTime = DateTime(
      ev.date.year,
      ev.date.month,
      ev.date.day,
      int.parse(ev.time.split(':')[0]),
      int.parse(ev.time.split(':')[1].split(' ')[0]),
    );

    // AM / PM adjust
    if (ev.time.contains('PM') && !ev.time.startsWith('12')) {
      eventDateTime = eventDateTime.add(const Duration(hours: 12));
    }

    // ❗❗❗ MOST IMPORTANT FIX
    if (eventDateTime.isBefore(now)) {
      debugPrint('⏭ Skipping past event: ${ev.title}');
      continue;
    }

    NotificationService.scheduleNotification(
      title: ev.title,
      body: '${ev.description} at ${ev.location}',
      scheduledDate: eventDateTime,
    );
  }
}

  @override
  Widget build(BuildContext context) {
    Event? todayEvent = getEventForDate(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Campus Events',
          style: TextStyle(
            color: Colors.brown[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF8EE),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: () async {
              await NotificationService.instantTest();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Test notification in 5 seconds'),
                ),
              );
            },
          ),
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
                HeaderSection(),
                const SizedBox(height: 20),
                HorizontalCalendar(
                  selectedDate: selectedDate,
                  events: events,
                  onDateSelected: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                    Event? tappedEvent = getEventForDate(date);
                    if (tappedEvent != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              EventDetailScreen(event: tappedEvent),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Today Event',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                todayEvent != null
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EventDetailScreen(event: todayEvent),
                            ),
                          );
                        },
                        child: SelectedEventCard(event: todayEvent),
                      )
                    : const Text(
                        'No event today',
                        style: TextStyle(color: Colors.grey),
                      ),
                const SizedBox(height: 16),
                const Text(
                  'Upcoming Events',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: upcomingEvents().length,
                    itemBuilder: (context, index) {
                      Event ev = upcomingEvents()[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EventDetailScreen(event: ev),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const Icon(
                              Icons.calendar_today,
                              color: Color(0xFFC9A36A),
                            ),
                            title: Text(ev.title),
                            subtitle: Text(
                              '${ev.date.day}-${ev.date.month}-${ev.date.year} • ${ev.time}\n${ev.location}',
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
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
