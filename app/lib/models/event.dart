import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 1)
class Event extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String address;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String imageUrl;
  @HiveField(5)
  final double latitude;
  @HiveField(6)
  final double longitude;

  Event({
    required this.name,
    required this.address,
    required this.date,
    required this.url,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });
}
