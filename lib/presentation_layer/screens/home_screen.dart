import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19_detector/data_layer/models/user.dart';
import 'package:covid_19_detector/presentation_layer/screens/map_screen.dart';
import 'package:covid_19_detector/presentation_layer/screens/profile%20screens/profile.dart';
import 'package:covid_19_detector/presentation_layer/screens/statistics.dart';
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

  @override
  initState() {
    super.initState();
    //getUsersLongitudeAndLatitude();
  }

  static List<Widget> _pages = [
    Profile(),
    MapScreen(),
    Statistics(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
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
        backgroundColor: Colors.green[800],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 35,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on_outlined,
              size: 35,
            ),
            label: 'Current Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.stacked_bar_chart,
              size: 35,
            ),
            label: 'Statistics',
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
