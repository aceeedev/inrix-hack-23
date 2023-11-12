import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:app/styles.dart';
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
          Padding(
            padding: const EdgeInsets.all(24),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(event.imageUrl)),
          ),
          Text(
            event.name,
            style: Styles().largeTextStyle,
          ),
          Text(event.address),
          Text(DateFormat.yMMMEd().format(event.date)),
          GradientButton(onPressed: () {}, child: const Text('Route me'))
        ],
      ),
    ));
  }
}
