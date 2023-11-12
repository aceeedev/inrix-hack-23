import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/models/event.dart';

String apiUrl = 'http://172.31.151.109:5000';

Future<List<Event>> findEvents() async {
  String endpoint = '/tickets';
  var response = await http.Client().get(Uri.parse('$apiUrl$endpoint'));

  if (response.statusCode == 200) {
    List<dynamic> json = jsonDecode(response.body);

    List<Event> events = json
        .map((e) => Event(
              name: e['name'],
              address: e['location'],
              date: DateTime.parse(e['eventDate']),
              url: e['eventURL'],
              imageUrl: e['imagelist'],
              latitude: double.parse(e['lat']),
              longitude: double.parse(e['long']),
            ))
        .toList();

    return events;
  } else {
    throw Exception('Error, code ${response.statusCode}');
  }
}
