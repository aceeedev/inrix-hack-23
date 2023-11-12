import 'package:app/pages/find_page.dart';
import 'package:flutter/material.dart';
import 'package:app/styles.dart';
import 'package:app/widgets/gradient_button_widget.dart';

class BeginPage extends StatelessWidget {
  const BeginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/Background.png"),
          fit: BoxFit.fill,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Park, Bus, & Jam',
              style: Styles().largeTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 25.0),
              child: Text(
                'Seamless parking, stress-free transit, and immersion in the concert experience.',
                textAlign: TextAlign.center,
                style: Styles().defaultTextStyle.copyWith(color: Colors.black),
              ),
            ),
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
      ),
    );
  }
}
