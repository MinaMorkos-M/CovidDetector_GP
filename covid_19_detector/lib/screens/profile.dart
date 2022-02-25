import 'package:covid_19_detector/screens/about.dart';
import 'package:covid_19_detector/screens/messages.dart';
import 'package:covid_19_detector/screens/settings.dart';
import 'package:covid_19_detector/widgets/profile_data.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.025,
                ),
                child: ProfileData('Mina Morkos', 'Cairo', 'Egypt'),
              ),
              ListTile(
                title: Text(
                  'Messages',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Messages(),
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
          child: RaisedButton(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.red,
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
