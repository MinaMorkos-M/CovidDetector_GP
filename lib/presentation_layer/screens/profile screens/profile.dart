import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19_detector/business_logic_layer/helpers/storageservices.dart';
import 'package:covid_19_detector/presentation_layer/screens/profile%20screens/about.dart';
import 'package:covid_19_detector/presentation_layer/screens/login%20&%20signup/login_screen.dart';
import 'package:covid_19_detector/presentation_layer/screens/profile%20screens/preventions.dart';
import 'package:covid_19_detector/presentation_layer/screens/profile%20screens/settings.dart'
    as settings_screen;
import 'package:covid_19_detector/presentation_layer/screens/profile%20screens/symptoms.dart';
import 'package:covid_19_detector/presentation_layer/screens/profile%20screens/who_questions.dart';
import 'package:covid_19_detector/presentation_layer/widgets/profile_data.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import '../../../data_layer/models/user.dart';

class Profile extends StatefulWidget {
  int numberOfSymptoms = 0;
  int numberOfPreventions = 0;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final storageService = StorageServices();

  Future<List<String>> getSymptomsURL() async {
    List<String> urls = [];
    var url;
    for (int i = 1; i < widget.numberOfSymptoms + 1; i++) {
      url = await storageService.downloadURL('symptoms/$i.jpg');
      urls.add(url);
    }
    return urls;
  }

  Future<List<String>> getPreventionsURL() async {
    List<String> urls = [];
    var url;
    for (int i = 1; i < widget.numberOfPreventions + 1; i++) {
      url = await storageService.downloadURL('preventions/$i.jpg');
      urls.add(url);
    }

    return urls;
  }

  Future<List<String>> getSymptomsTitles() async {
    List<String> titles = [];
    var title;
    await FirebaseFirestore.instance
        .collection("symptoms")
        .doc("titles")
        .get()
        .then((value) async {
      var result = value.data();
      widget.numberOfSymptoms = result!['number'];
      for (int i = 1; i < result['number'] + 1; i++) {
        title = result['symp$i'];
        titles.add(title);
      }
    });
    return titles;
  }

  Future<List<String>> getPreventionsTitles() async {
    List<String> titles = [];
    var title;
    await FirebaseFirestore.instance
        .collection("preventions")
        .doc("titles")
        .get()
        .then((value) async {
      var result = value.data();
      widget.numberOfPreventions = result!['number'];
      for (int i = 1; i < result['number'] + 1; i++) {
        title = result['prevention$i'];
        titles.add(title);
      }
    });
    return titles;
  }

  Future<List<String>> getQuestions() async {
    List<String> titles = [];
    var title;
    await FirebaseFirestore.instance
        .collection("who")
        .doc("titles")
        .get()
        .then((value) async {
      var result = value.data();
      widget.numberOfPreventions = result!['number'];
      for (int i = 1; i < result['number'] + 1; i++) {
        title = result['who$i'];
        titles.add(title);
      }
    });
    return titles;
  }

  auth.User? user = auth.FirebaseAuth.instance.currentUser;
  User loggedInUser = User(
      city: "",
      state: "",
      country: "",
      password: "",
      username: "",
      phone: " ",
      lng: 0,
      lat: 0,
      infected: false,
      id: 0,
      name: "",
      uid: " ",
      email: "");
  final _auth = auth.FirebaseAuth.instance;

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.green,
    elevation: 5,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  double getLongitude() {
    return this.loggedInUser.lng;
  }

  double getLatitude() {
    return this.loggedInUser.lat;
  }

  bool getInfected() {
    return this.loggedInUser.infected;
  }

  @override
  void initState() {
    super.initState();
    print("here");
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = User.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            children: [
              Card(
                elevation: 0,
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.025,
                ),
                child: ProfileData(
                  loggedInUser.name!,
                  loggedInUser.city,
                  loggedInUser.country,
                ),
              ),
              ListTile(
                title: Text(
                  'Symptoms',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_sharp,
                  color: Colors.green,
                ),
                onTap: () async {
                  List<String> titles = await getSymptomsTitles();
                  List<String> url = await getSymptomsURL();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Symptoms(url: url, titles: titles),
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Preventions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_sharp,
                  color: Colors.green,
                ),
                onTap: () async {
                  List<String> titles = await getPreventionsTitles();
                  List<String> url = await getPreventionsURL();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Preventions(url: url, titles: titles),
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'WHO Questions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_sharp,
                  color: Colors.green,
                ),
                onTap: () async {
                  List<String> questions = await getQuestions();
                  print(loggedInUser.lng);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WhoQuestions(
                        questions: questions,
                      ),
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_sharp,
                  color: Colors.green,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => settings_screen.Settings(
                        infectedValue: this.loggedInUser.infected,
                        name: this.loggedInUser.name!,
                        country: this.loggedInUser.country,
                        city: this.loggedInUser.city,
                        state: this.loggedInUser.state,
                      ),
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_sharp,
                  color: Colors.green,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => About(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          width: 100,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.05,
          ),
          child: ElevatedButton(
            style: raisedButtonStyle,
            child: Text(
              'Log Out',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              _auth.signOut();
              Navigator.pushAndRemoveUntil(
                  (context),
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            },
          ),
        )
      ],
    );
  }
}
