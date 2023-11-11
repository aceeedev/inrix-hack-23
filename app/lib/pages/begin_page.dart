import 'package:app/pages/home_page.dart';
import 'package:app/pages/map_page.dart';
import 'package:app/widgets/gradient_button_widget.dart';
import 'package:flutter/material.dart';

class BeginPage extends StatelessWidget {
  const BeginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image(image: )
          Text(
            'App Name',
          ),
          Text('App description'),
          GradientButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MapPage(title:"title"),
                    ),
                  ),
              child: Text('Begin'))
        ],
      ),
    ));
  }
}