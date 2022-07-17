import 'package:covid_19_detector/presentation_layer/screens/home_screen.dart';
import 'package:covid_19_detector/presentation_layer/widgets/settings_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';

class Settings extends StatefulWidget {
  bool infectedValue;
  String name;
  String country;
  String state;
  String city;
  Settings({
    required this.infectedValue,
    required this.name,
    required this.city,
    required this.state,
    required this.country,
  });
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _auth = auth.FirebaseAuth.instance;

  @override
  void initState() {
    print(widget.infectedValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.green[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false);
          },
        ),
      ),
      body: Column(
        children: [
          SettingsText('General Settings'),
          ListTile(
            title: Text('Infected mode'),
            trailing: Switch(
              activeTrackColor: Colors.green[800],
              value: this.widget.infectedValue,
              onChanged: (bool value) async {
                setState(() {
                  this.widget.infectedValue = value;
                });
                auth.User? user = _auth.currentUser;
                FirebaseFirestore firebaseFirestore =
                    FirebaseFirestore.instance;
                await firebaseFirestore
                    .collection("users")
                    .doc(user!.uid)
                    .update({'infected': value});
              },
            ),
          ),
          Divider(),
          SettingsText('Account Information'),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 34,
              ),
            ),

            title: Text('Name'),
            subtitle: Text(widget.name),
            //onTap: () => ,
          ),
          Divider(
            height: 5,
            endIndent: 20,
            indent: 20,
            color: Colors.green,
            thickness: 1,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.map,
                color: Colors.black,
                size: 34,
              ),
            ),

            title: Text('Country'),
            subtitle: Text(widget.country),
            //onTap: () => ,
          ),
          Divider(
            height: 5,
            endIndent: 20,
            indent: 20,
            color: Colors.green,
            thickness: 1,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.location_city,
                color: Colors.black,
                size: 34,
              ),
            ),

            title: Text('state'),
            subtitle: Text(widget.state),
            //onTap: () => ,
          ),
          Divider(
            height: 5,
            endIndent: 20,
            indent: 20,
            color: Colors.green,
            thickness: 1,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.maps_home_work_sharp,
                color: Colors.black,
                size: 34,
              ),
            ),

            title: Text('City'),
            subtitle: Text(widget.city),
            //onTap: () => ,
          ),
        ],
      ),
    );
  }
}
