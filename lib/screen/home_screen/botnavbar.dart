import 'package:flutter/material.dart';
import 'package:manga_time/screen/category_screen/tab_controller_category.dart';
import 'package:manga_time/screen/favorite_screen/favorite_screen.dart';
import 'package:manga_time/screen/home_screen/home_screen.dart';
import 'package:manga_time/screen/report_screen/report_screen.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({Key? key}) : super(key: key);

  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> screens = [
    const HomeScreen(),
    const TabContollerCategory(),
    const FavoriteScreen(),
    const ReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Report',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.red,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
