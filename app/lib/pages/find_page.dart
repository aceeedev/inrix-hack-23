import 'package:flutter/material.dart';
import 'package:app/models/event.dart';
import 'package:app/widgets/ticket_card_widget.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  // Dummy data
  final List<Event> events = [
    Event(
          name: "yourmomshouse",
          address: "111 El Camino",
          date: DateTime(1),
          url: "https://docs.google.com/document/d/1lwh_GXFqQ8O2bEwrHyw_koGDYNGQE4NGFVCEsYzbarU/edit#heading=h.1ak8pstirwpq"
          imageurl: 
        ),
    Event(
          name: "yourmomshouse",
          address: "111 El Camino",
          date: DateTime(1),
          url: "https://docs.google.com/document/d/1lwh_GXFqQ8O2bEwrHyw_koGDYNGQE4NGFVCEsYzbarU/edit#heading=h.1ak8pstirwpq"
        ),
    Event(
          name: "yourmomshouse",
          address: "111 El Camino",
          date: DateTime(1),
          url:"https://docs.google.com/document/d/1lwh_GXFqQ8O2bEwrHyw_koGDYNGQE4NGFVCEsYzbarU/edit#heading=h.1ak8pstirwpq"
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Title'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return TicketCard(event: events[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
