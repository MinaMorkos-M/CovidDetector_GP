import 'package:covid_19_detector/business_logic_layer/constants.dart';
import 'package:covid_19_detector/presentation_layer/screens/country.dart';
import 'package:covid_19_detector/presentation_layer/screens/global.dart';
import 'package:covid_19_detector/presentation_layer/screens/navigation_option.dart';

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
        children: [
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
                    : CountryState(),
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
