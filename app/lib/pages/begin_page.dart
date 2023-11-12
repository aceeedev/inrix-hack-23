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
            padding: const EdgeInsets.fromLTRB(12.0, 30.0, 12.0, 12.0),
            child: Text(
              'Seamless parking, stress-free transit, and immersion in the concert experience.',
              textAlign: TextAlign.center,
<<<<<<< HEAD
              style: Styles().defaultTextStyle.copyWith(color: Colors.black),
=======
              style: Styles().defaultTextStyle,
>>>>>>> parent of 794efa4 (Merge branch 'main' into main2)
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
