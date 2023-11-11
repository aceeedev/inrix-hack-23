import 'package:hive_flutter/hive_flutter.dart';

class DB {
  static final DB instance = DB._init();
  static Box? _box;

  DB._init();

  Future<Box> get box async {
    if (_box != null) return _box!;

    _box = await Hive.openBox('db');
    return _box!;
  }
}
