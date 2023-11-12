import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/pages/event_page.dart';
import 'package:app/models/event.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.event, required this.action});
  final Event event;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    const IconData location = IconData(0xe3ab, fontFamily: 'MaterialIcons');
    const IconData calendar = IconData(0xe122, fontFamily: 'MaterialIcons');
    const IconData bookmark = IconData(0xe0f4, fontFamily: 'MaterialIcons');
    const IconData info = IconData(0xe33d, fontFamily: 'MaterialIcons');

    return TicketWidget(
      width: 350,
      height: 230,
      isCornerRounded: true,
      child: Card(
        child: Column(
      children: [
        Row(children: [
          const Icon(location),
          Text(event.address),
          const Spacer(flex: 2),
          const Icon(calendar),
          Text(DateFormat.yMMMEd().format(event.date))]),
        const Spacer(flex: 1),
        Text(event.name, style: const TextStyle(fontSize: 30)),
        const Spacer(flex: 2),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF3A2E87),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(13), bottomRight: Radius.circular(13))
          ),
          child: Row( children: [
            const Spacer(flex: 2),
            TextButton(
              onPressed: () {},
              child: const Icon(bookmark)),
            TextButton(
                onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EventPage(event: event),
                      ),
                    ),
                child: const Icon(info))]),
        )],
    )));
  }
}