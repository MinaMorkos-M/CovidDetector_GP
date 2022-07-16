import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19_detector/data_layer/models/user.dart';
import 'package:covid_19_detector/presentation_layer/screens/map_screen.dart';
import 'package:covid_19_detector/presentation_layer/screens/profile.dart';
import 'package:covid_19_detector/presentation_layer/screens/statistics.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        getUsersLongitudeAndLatitude();
      }
    });
  }

  void getUsersLongitudeAndLatitude() async {
    int numberOfUsers = 0;
    List<String> uids = [];
    List<User> users = [];
    await FirebaseFirestore.instance
        .collection("users")
        .doc("uid")
        .get()
        .then((value) async {
      var result = value.data();

      numberOfUsers = result!['number'];
      for (int i = 0; i < numberOfUsers; i++) {
        uids.add(result['user${i + 1}']);
      }
      print(uids);
      for (int i = 0; i < uids.length; i++) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uids[i])
            .get()
            .then((value) {
          var result = value.data();
          users.add(User(
              lng: result!['longitude'],
              lat: result['latitude'],
              infected: result['infected'],
              state: "",
              country: "",
              city: " ",
              email: "",
              id: 0,
              phone: "",
              username: "",
              name: "",
              uid: "",
              password: ""));
        });
      }
    });
    for (int i = 0; i < users.length; i++) {
      print(users[i].lng);
    }
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
