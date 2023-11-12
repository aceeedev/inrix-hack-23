import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/pages/event_page.dart';
import 'package:app/models/event.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:app/styles.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.event, required this.action});
  final Event event;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    const IconData calendar = IconData(0xe122, fontFamily: 'MaterialIcons');
    const IconData info = IconData(0xe33d, fontFamily: 'MaterialIcons');

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EventPage(event: event),
        ),
      ),
      child: TicketWidget(
        color: Styles().borderColor,
        width: 350,
        height: 200,
        padding: const EdgeInsets.all(2.5),
        isCornerRounded: true,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: TicketWidget(
            width: 348,
            height: 198,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(event.name,
                      style: event.name.length >= 30
                          ? Styles().largeTextStyle.copyWith(fontSize: 16.0)
                          : Styles().largeTextStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(calendar),
                        ),
                        Text(DateFormat.yMMMEd().format(event.date))
                      ]),
                ),
                const Spacer(flex: 2),
                Container(
                  decoration: BoxDecoration(
                      color: Styles().mainColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(13),
                          bottomRight: Radius.circular(13))),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    action,
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
