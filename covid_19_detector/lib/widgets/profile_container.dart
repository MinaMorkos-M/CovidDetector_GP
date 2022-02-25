import 'package:covid_19_detector/widgets/profile_text.dart';
import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          color: Color.fromRGBO(206, 206, 206, 1),
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.05,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 100,
                ),
                ProfileText('Bruno Steban'),
                ProfileText('Dublin, Ireland'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
