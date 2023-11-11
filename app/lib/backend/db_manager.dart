import 'package:hive_flutter/hive_flutter.dart';
import 'package:app/models/event.dart';

class DB {
  static final DB instance = DB._init();
  static Box? _box;

  DB._init();

  Future<Box> get box async {
    if (_box != null) return _box!;

    _box = await Hive.openBox('db');
    return _box!;
  }

  Future<void> saveEvent(Event event) async {
    (await box).put(event.name, event);
  }

  Future<void> deleteEvent(String eventName) async {
    (await box).delete(eventName);
  }

  Future<List<Event>> getAllEvents() async {
    return (await box).values.cast<Event>().toList();
  }
}
