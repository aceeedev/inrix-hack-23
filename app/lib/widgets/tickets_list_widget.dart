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
            padding: const EdgeInsets.all(12.0),
            child: TicketCard(
              event: event,
              action: widget.findPage == true
                  ? IconButton(
                      onPressed: () async {
                        await DB.instance.saveEvent(event);
                      },
                      icon: const Icon(
                        Icons.bookmark_outline,
                        color: Colors.white,
                      ))
                  : IconButton(
                      onPressed: () async {
                        await DB.instance.deleteEvent(event.name);
                        setState(() {
                          widget.events.removeAt(index);
                        });
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      )),
            ));
      },
    );
  }
}
