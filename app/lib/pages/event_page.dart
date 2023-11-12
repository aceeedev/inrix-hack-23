import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/gradient_button_widget.dart';
import 'package:app/models/event.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(event.imageUrl),
          Text(event.name),
          Text(event.address),
          Text(DateFormat.yMMMEd().format(event.date)),
          GradientButton(onPressed: () {}, child: const Text('Route me'))
        ],
      ),
    ));
  }
}
