import 'package:app/pages/find_page.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/gradient_button_widget.dart';

class BeginPage extends StatelessWidget {
  const BeginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Drive, Park, and Ride'),
          const Text(''),
          GradientButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const FindPage(),
                    ),
                  ),
              child: const Text('Get Started'))
        ],
      ),
    ));
  }
}
