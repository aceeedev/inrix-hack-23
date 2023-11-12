import 'package:app/pages/find_page.dart';
import 'package:flutter/material.dart';
import 'package:app/styles.dart';
import 'package:app/widgets/gradient_button_widget.dart';
import 'package:app/widgets/roads_gradient_widget.dart';

class BeginPage extends StatelessWidget {
  const BeginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const RoadsGradient(),
          Text(
            'Park, Bus, & Jam',
            style: Styles().largeTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus pellentesque, sapien quis malesuada varius, erat odio auctor nunc, eget aliquam felis mi eget elit. ',
              textAlign: TextAlign.center,
              style: Styles().defaultTextStyle,
            ),
          ),
          const Spacer(),
          Padding(
            padding: Styles().bottomButtonEdgeInset,
            child: GradientButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const FindPage(),
                ),
              ),
              child: Text(
                'Begin',
                style: Styles().mediumTextStyle.copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
