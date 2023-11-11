import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:app/app.dart';
import 'package:app/models/event.dart';

void main() async {
  // Allows for async code in main method
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // register all DB registers of custom objects
  Hive.registerAdapter(EventAdapter());

  runApp(const App());
}
