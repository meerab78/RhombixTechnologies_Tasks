import 'package:college_alert_app/Model/event_model.dart' show Event;
import 'package:college_alert_app/Screens/Events/event_detail_screen.dart';
import 'package:college_alert_app/Screens/Events/event_list_screen.dart';
import 'package:flutter/material.dart';

class HorizontalCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final List<Event> events; // callback

  const HorizontalCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 30,
        itemBuilder: (context, index) {
          DateTime date = DateTime.now().add(Duration(days: index));
          bool isSelected =
              date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          // Dot only if event exists
          bool hasEvent = events.any((ev) {
            DateTime eventDate = ev.date;
            return eventDate.day == date.day &&
                eventDate.month == date.month &&
                eventDate.year == date.year;
          });

          return GestureDetector(
            onTap: () {
              onDateSelected(date); // sirf update selected date
            },

            child: Container(
              width: 60,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    [
                      'Sun',
                      'Mon',
                      'Tue',
                      'Wed',
                      'Thu',
                      'Fri',
                      'Sat',
                    ][date.weekday % 7],
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF3E2C1C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF3E2C1C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                      color: hasEvent ? Colors.red : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
