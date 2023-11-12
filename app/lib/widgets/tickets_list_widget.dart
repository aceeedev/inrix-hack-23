import 'package:flutter/material.dart';
import 'package:app/backend/db_manager.dart';
import 'package:app/models/event.dart';
import 'package:app/widgets/ticket_card_widget.dart';

/// A [ListView] of [TicketCard]s.
///
/// [findPage] is true if list is on findPage and false if on saved tickets page
class TicketsList extends StatefulWidget {
  TicketsList({
    super.key,
    required this.events,
    required this.findPage,
  });

  List<Event> events;
  final bool findPage;
  @override
  State<TicketsList> createState() => _TicketsListState();
}

class _TicketsListState extends State<TicketsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.events.length,
      itemBuilder: (context, index) {
        Event event = widget.events[index];

        return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: TicketCard(
              event: event,
              action: widget.findPage == true
                  ? TextButton(
                      onPressed: () async => await DB.instance.saveEvent(event),
                      child: const Text('Save ticket'))
                  : TextButton(
                      onPressed: () async {
                        await DB.instance.deleteEvent(event.name);
                        setState(() {
                          widget.events.removeAt(index);
                        });
                      },
                      child: const Text('Delete ticket')),
            ));
      },
    );
  }
}
