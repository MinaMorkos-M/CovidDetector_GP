import 'package:covid_19_detector/helpers/constants.dart';
import 'package:covid_19_detector/screens/country.dart';
import 'package:covid_19_detector/screens/global.dart';
import 'package:covid_19_detector/screens/navigation_option.dart';
import 'package:covid_19_detector/screens/preventions.dart';
import 'package:covid_19_detector/screens/symptoms.dart';
import 'package:covid_19_detector/screens/who_questions.dart';
import 'package:covid_19_detector/widgets/statistic_circle.dart';
import 'package:flutter/material.dart';

enum NavigationState { GLOBAL, COUNTRY }

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  NavigationState navigationState = NavigationState.GLOBAL;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: AnimatedSwitcher(
                duration: Duration(
                  milliseconds: 250,
                ),
                child: navigationState == NavigationState.GLOBAL
                    ? Global()
                    : Country(),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavigationOption(
                  title: "Global",
                  selected: navigationState == NavigationState.GLOBAL,
                  onSelected: () {
                    setState(() {
                      navigationState = NavigationState.GLOBAL;
                    });
                  },
                ),
                NavigationOption(
                  title: "Country",
                  selected: navigationState == NavigationState.COUNTRY,
                  onSelected: () {
                    setState(() {
                      navigationState = NavigationState.COUNTRY;
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
