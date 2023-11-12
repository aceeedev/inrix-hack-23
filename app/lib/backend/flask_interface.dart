import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/models/event.dart';

String apiUrl = 'http://127.0.0.1:5000';

Future<List<Event>> findEvents() async {
  // Dummy data
  List<Event> events = [
    Event(
        name: "yourdadshouse",
        address: "111 El Camimo",
        date: DateTime(1),
        url:
            "https://docs.google.com/document/d/1lwh_GXFqQ8O2bEwrHyw_koGDYNGQE4NGFVCEsYzbarU/edit#heading=h.1ak8pstirwpq",
        imageUrl: ""),
    Event(
        name: "yourmomshouse",
        address: "11 El Camino",
        date: DateTime(1),
        url:
            "https://docs.google.com/document/d/1lwh_GXFqQ8O2bEwrHyw_koGDYNGQE4NGFVCEsYzbarU/edit#heading=h.1ak8pstirwpq",
        imageUrl: ""),
    Event(
        name: "mymomshouse",
        address: "121 El Camino",
        date: DateTime(1),
        url:
            "https://docs.google.com/document/d/1lwh_GXFqQ8O2bEwrHyw_koGDYNGQE4NGFVCEsYzbarU/edit#heading=h.1ak8pstirwpq",
        imageUrl: ""),
  ];
  return events;

  // actual code
  String endpoint = '/';
  var response = await http.Client().get(Uri.parse('$apiUrl$endpoint'));

  if (response.statusCode == 200) {
    List<dynamic> json = jsonDecode(response.body);

    List<Event> events = json
        .map((e) => Event(
            name: 'name',
            address: 'address',
            date: DateTime.now(),
            url: 'url',
            imageUrl: 'imageUrl'))
        .toList();

    return events;
  } else {
    throw Exception('Error, code ${response.statusCode}');
  }
}
