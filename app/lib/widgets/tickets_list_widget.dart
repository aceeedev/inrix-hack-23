import 'package:flutter/material.dart';
import 'package:app/models/event.dart';
import 'package:app/widgets/ticket_card_widget.dart';

class TicketsList extends StatelessWidget {
  const TicketsList({super.key, required this.events});
  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TicketCard(event: events[index]),
            ));
  }
}
