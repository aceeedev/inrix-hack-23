import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/pages/event_page.dart';
import 'package:app/models/event.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.event, required this.action});
  final Event event;
  final Widget action;

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
        action,
      ],
    ));
  }
}
