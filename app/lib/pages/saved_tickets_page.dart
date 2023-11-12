import 'package:flutter/material.dart';
import 'package:app/styles.dart';
import 'package:app/backend/db_manager.dart';
import 'package:app/widgets/bottom_navbar_widget.dart';
import 'package:app/widgets/tickets_list_widget.dart';
import 'package:app/models/event.dart';

class SavedTicketsPage extends StatefulWidget {
  const SavedTicketsPage({super.key});

  @override
  State<SavedTicketsPage> createState() => _SavedTicketsPageState();
}

class _SavedTicketsPageState extends State<SavedTicketsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: DB.instance.getAllEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('An error has occurred, ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<Event> savedEvents = snapshot.data!;

              if (savedEvents.isEmpty) {
                return const Center(
                    child: Text('You haven\'t saved any events yet D:'));
              }

              return TicketsList(
                events: savedEvents,
                findPage: false,
              );
            }
          }

          return const Center(child: CircularProgressIndicator());
        },
      )),
      bottomNavigationBar: const BottomNavBar(
        selectedIndex: 1,
      ),
    );
  }
}
