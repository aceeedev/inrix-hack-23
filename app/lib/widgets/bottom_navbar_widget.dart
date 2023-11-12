import 'package:app/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:app/styles.dart';
import 'package:app/pages/find_page.dart';
import 'package:app/pages/saved_tickets_page.dart';

/// Add this to every page that needs a bottom navbar.
///
/// selectedIndex depends on page:
/// 0: find events
/// 1: saved tickets
/// 2: nav
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.search), label: 'Saved Tickets'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark), label: 'Saved Tickets'),
      ],
      backgroundColor: Styles().mainColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: (int newPageIndex) => _onNavBarTap(context, newPageIndex),
    );
  }

  void _onNavBarTap(BuildContext context, int newIndex) async {
    if (selectedIndex == newIndex) return;

    const List<Widget> pages = [FindPage(), SavedTicketsPage()];

    // run page specific code, if needed
    switch (newIndex) {
      case 0:
        break;
    }

    // send user to new page
    Navigator.of(context).pushReplacement(
      // MaterialPageRoute(
      //   builder: (context) => pages[newIndex],
      // ),
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => pages[newIndex],
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
