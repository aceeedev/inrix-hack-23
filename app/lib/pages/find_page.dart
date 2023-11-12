import 'package:flutter/material.dart';
import 'package:app/backend/flask_interface.dart';
import 'package:app/models/event.dart';
import 'package:app/widgets/tickets_list_widget.dart';
import 'package:app/widgets/bottom_navbar_widget.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Events Near You'),
      ),
      body: FutureBuilder(
        future: findEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('An error has occurred, ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<Event> foundEvents = snapshot.data!;

              return TicketsList(
                events: foundEvents,
                findPage: true,
              );
            }
          }

          return const CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: const BottomNavBar(
        selectedIndex: 0,
      ),
    );
  }
}
