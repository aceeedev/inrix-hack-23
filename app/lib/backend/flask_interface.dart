import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/models/event.dart';

String apiUrl = '';

Future<List<Event>> getEvents(double lat, double long) async {
  String endpoint = '/';
  var response = await http.Client()
      .get(Uri.parse('$apiUrl$endpoint?lat=$lat&long=$long'));

  if (response.statusCode == 200) {
    List<dynamic> json = jsonDecode(response.body);

    List<Event> events = json
        .map((e) => Event(
            name: 'name', address: 'address', date: DateTime.now(), url: 'url'))
        .toList();

    return events;
  } else {
    throw Exception('Error, code ${response.statusCode}');
  }
}
