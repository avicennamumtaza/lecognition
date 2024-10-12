import 'package:flutter/material.dart';
import 'package:lecognition/screens/diagnozer.dart';
import 'package:lecognition/screens/home.dart';
import 'package:lecognition/screens/profile.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const HomeScreen();
    var activeScreenTitle = "Home";
    if (_selectedScreenIndex == 1) {
      activeScreen = const DiagnozerScreen();
      activeScreenTitle = "Diagnozer";
    } else if (_selectedScreenIndex == 2) {
      activeScreen = const ProfileScreen();
      activeScreenTitle = "Profile";
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(activeScreenTitle),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        body: activeScreen,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectScreen,
          currentIndex: _selectedScreenIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code_scanner,
              ),
              label: "Diagnozer",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
