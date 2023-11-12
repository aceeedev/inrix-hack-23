import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:app/styles.dart';
import 'package:app/widgets/gradient_button_widget.dart';
import 'package:app/widgets/roads_gradient_widget.dart';
import 'package:app/models/event.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(children: [
        const Align(alignment: Alignment.topCenter, child: RoadsGradient()),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.of(context).pop()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    event.imageUrl,
                    fit: BoxFit.cover,
                  )),
            ),
            Text(
              event.name,
              style: Styles().largeTextStyle,
            ),
            Text(event.address),
            Text(DateFormat.yMMMEd().format(event.date)),
            const Spacer(),
            Padding(
              padding: Styles().bottomButtonEdgeInset,
              child: GradientButton(
                  onPressed: () {
                    //TODO: add redirect to map page with routing
                  },
                  child: Padding(
                    padding: Styles().largeButtonEdgeInset,
                    child: Text(
                      'Route me',
                      style: Styles()
                          .mediumTextStyle
                          .copyWith(color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
      ]),
    ));
  }
}
