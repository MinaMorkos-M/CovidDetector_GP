import 'package:covid_19_detector/business_logic_layer/constants.dart';
import 'package:covid_19_detector/data_layer/models/country_summary.dart';
import 'package:covid_19_detector/presentation_layer/widgets/country_build_card.dart';
import 'package:flutter/material.dart';

class CountryStatistics extends StatelessWidget {
  final List<CountrySummary> summaryList;
  CountryStatistics({
    required this.summaryList,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Column(
            children: [
              CountryBuildCard(
                leftColor: kConfirmedColor,
                leftTitle: "CONFIRMED",
                leftValue: '${summaryList[summaryList.length - 1].confirmed}',
                rightColor: kActiveColor,
                rightTitle: "ACTIVE",
                rightValue: '${summaryList[summaryList.length - 1].active}',
              ),
              CountryBuildCard(
                leftColor: kRecoveredColor,
                leftTitle: "RECOVERED",
                leftValue: '${summaryList[summaryList.length - 1].recovered}',
                rightColor: kDeathColor,
                rightTitle: "DEATH",
                rightValue: '${summaryList[summaryList.length - 1].death}',
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
