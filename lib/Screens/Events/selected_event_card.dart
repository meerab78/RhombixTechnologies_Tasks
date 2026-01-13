import 'package:college_alert_app/Model/event_model.dart';
import 'package:college_alert_app/Screens/Events/event_detail_screen.dart';
import 'package:flutter/material.dart';

class SelectedEventCard extends StatelessWidget {
  final Event? event;

  const SelectedEventCard({super.key, this.event});

  @override
  Widget build(BuildContext context) {
    if (event == null) {
      return Text('No event today', style: TextStyle(fontSize: 16));
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.event, color: Color(0xFFC9A36A)),
        title: Text(event!.title),
        subtitle: Text('${event!.time}\n${event!.location}'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to detail screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailScreen(event: event!),
            ),
          );
        },
      ),
    );
  }
}
