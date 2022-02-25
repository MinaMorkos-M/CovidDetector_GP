import 'package:covid_19_detector/screens/preventions.dart';
import 'package:covid_19_detector/screens/symptoms.dart';
import 'package:covid_19_detector/screens/who_questions.dart';
import 'package:covid_19_detector/widgets/statistic_circle.dart';
import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatisticCircle('1000', 'New Infected'),
              StatisticCircle('500', 'Recovered'),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatisticCircle('2500', 'Total Infected'),
              StatisticCircle('200', 'Dead'),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
            children: [
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
            ],
          ),
        ),
      ],
    );
  }
}
