import 'package:app/pages/find_page.dart';
import 'package:flutter/material.dart';
import 'package:app/styles.dart';
import 'package:app/widgets/gradient_button_widget.dart';

class BeginPage extends StatelessWidget {
  const BeginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.asset(
              'assets/images/roads.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
            'Drive, Park, and Ride',
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
            padding: const EdgeInsets.only(bottom: 50.0),
            child: GradientButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const FindPage(),
                      ),
                    ),
                child: Text(
                  'Start riding and gliding',
                  style: Styles().mediumTextStyle.copyWith(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
