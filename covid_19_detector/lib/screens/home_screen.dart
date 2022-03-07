import 'package:covid_19_detector/screens/map_screen.dart';
import 'package:covid_19_detector/screens/profile.dart';
import 'package:covid_19_detector/screens/statistics.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    Profile(),
    MapScreen(),
    Statistics(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Covid Detector',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 35,
            ),
            label: 'profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on_outlined,
              size: 35,
            ),
            label: 'currentLocation',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.stacked_bar_chart,
              size: 35,
            ),
            label: 'statistics',
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
