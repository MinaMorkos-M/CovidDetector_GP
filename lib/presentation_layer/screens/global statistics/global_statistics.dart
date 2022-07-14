import 'package:covid_19_detector/business_logic_layer/constants.dart';
import 'package:covid_19_detector/data_layer/models/global.dart';
import 'package:covid_19_detector/presentation_layer/widgets/global%20statistics/global_build_card.dart';
import 'package:flutter/material.dart';

class GlobalStatistics extends StatelessWidget {
  final GlobalSummaryModel summary;

  GlobalStatistics({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              GlobalBuildCard(
                title: "CONFIRMED",
                totalCount: summary.totalConfirmed,
                todayCount: summary.newConfirmed,
                color: kConfirmedColor,
              ),
              GlobalBuildCard(
                title: "ACTIVE",
                totalCount: summary.totalConfirmed -
                    summary.totalRecovered -
                    summary.totalDeaths,
                todayCount: summary.newConfirmed -
                    summary.newRecovered -
                    summary.newDeaths,
                color: kActiveColor,
              ),
              GlobalBuildCard(
                title: "RECOVERED",
                totalCount: summary.totalRecovered,
                todayCount: summary.newRecovered,
                color: kRecoveredColor,
              ),
              GlobalBuildCard(
                title: "DEATH",
                totalCount: summary.totalDeaths,
                todayCount: summary.newDeaths,
                color: kDeathColor,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Text(
                  "Statistics updated due to covidtracking.com",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
