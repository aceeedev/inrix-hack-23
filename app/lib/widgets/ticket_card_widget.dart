import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/backend/db_manager.dart';
import 'package:app/pages/event_page.dart';
import 'package:app/models/event.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Text(event.name),
        Text(event.address),
        Text(DateFormat.yMMMEd().format(event.date)),
        TextButton(
            onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EventPage(event: event),
                  ),
                ),
            child: const Text('Event Info')),
        TextButton(
            onPressed: () async => DB.instance.saveEvent(event),
            child: const Text('Save ticket')),
        TextButton(
            onPressed: () async => DB.instance.deleteEvent(event.name),
            child: const Text('Delete ticket'))
      ],
    ));
  }
}
