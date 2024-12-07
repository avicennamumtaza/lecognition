import 'package:flutter/material.dart';
import 'package:lecognition/presentation/diagnozer/pages/diagnozer.dart';
import 'package:lecognition/presentation/home/pages/home.dart';
import 'package:lecognition/presentation/profile/pages/profile.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, this.index});
  final int? index;

  @override
  State<TabsScreen> createState() => _TabsScreenState(index);
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  _TabsScreenState(int? index) {
    _selectedScreenIndex = index ?? 0;
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const HomeScreen();
    var activeScreenTitle = "Beranda";
    if (_selectedScreenIndex == 1) {
      activeScreen = const DiagnozerScreen();
      activeScreenTitle = "Diagnosis";
    } else if (_selectedScreenIndex == 2) {
      activeScreen = ProfileScreen();
      activeScreenTitle = "Profil";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      backgroundColor: (_selectedScreenIndex == 0) ? Theme.of(context).colorScheme.primary : Colors.white,
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        onTap: _selectScreen,
        currentIndex: _selectedScreenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner,
            ),
            label: "Diagnosis",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profil",
          ),
        ],
      ),

    );
  }
}
