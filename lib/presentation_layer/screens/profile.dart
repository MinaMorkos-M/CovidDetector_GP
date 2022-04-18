
import 'package:covid_19_detector/presentation_layer/screens/about.dart';
import 'package:covid_19_detector/presentation_layer/screens/preventions.dart';
import 'package:covid_19_detector/presentation_layer/screens/settings.dart';
import 'package:covid_19_detector/presentation_layer/screens/symptoms.dart';
import 'package:covid_19_detector/presentation_layer/screens/who_questions.dart';
import 'package:covid_19_detector/presentation_layer/widgets/profile_data.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.red,
    elevation: 5,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
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
                child: ProfileData('Mina Morkos', 'Cairo', 'Egypt'),
              ),
              ListTile(
                title: Text(
                  'Symptoms',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Symptoms(),
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
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Preventions(),
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
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WhoQuestions(),
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
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Settings(),
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
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
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
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
