import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/models/event.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.event});
  final Event event;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Text(event.name),
        Text(event.address),
        Text(DateFormat.yMMMEd().format(event.date)),
      ],
    ));
  }
}