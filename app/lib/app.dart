import 'package:flutter/material.dart';
import 'package:app/styles.dart';
import 'package:app/pages/begin_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Styles().mainColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const BeginPage(),
    );
  }
}
