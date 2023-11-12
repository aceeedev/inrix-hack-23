import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:app/styles.dart';
import 'package:app/widgets/gradient_button_widget.dart';
import 'package:app/widgets/roads_gradient_widget.dart';
import 'package:app/pages/map_page.dart';
import 'package:app/models/event.dart';

class EventPage extends StatefulWidget {
  EventPage({super.key, required this.event});
  final Event event;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  double _sliderValue = 1610;

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
                    widget.event.imageUrl,
                    fit: BoxFit.cover,
                  )),
            ),
            Text(
              widget.event.name,
              style: Styles().largeTextStyle,
            ),
            Text(widget.event.address),
            Text(DateFormat.yMMMEd().format(widget.event.date)),
            const Spacer(),
            Text('Parking Distance', style: Styles().mediumTextStyle),
            Text('${(_sliderValue / 1609.34).toStringAsFixed(2)} miles',
                style: Styles().defaultTextStyle),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Slider(
                value: _sliderValue,
                max: 2500,
                min: 805, // ~half a mile in meters
                divisions: 100,
                onChanged: (double value) =>
                    setState(() => _sliderValue = value),
              ),
            ),
            Padding(
              padding: Styles().bottomButtonEdgeInset,
              child: GradientButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MapPage(
                            event: widget.event,
                            parkingRadius: _sliderValue.round(),
                          ))),
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
