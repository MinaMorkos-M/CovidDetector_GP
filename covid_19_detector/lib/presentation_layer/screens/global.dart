import 'package:covid_19_detector/data_layer/models/global.dart';
import 'package:covid_19_detector/business_logic_layer/helpers/statistics_handler.dart';
import 'package:covid_19_detector/presentation_layer/screens/global_loading.dart';
import 'package:covid_19_detector/presentation_layer/screens/global_statistics.dart';
import 'package:covid_19_detector/presentation_layer/widgets/error_card.dart';
import 'package:flutter/material.dart';

CovidHandler covidHandler = CovidHandler();

class Global extends StatefulWidget {
  const Global({Key? key}) : super(key: key);

  @override
  State<Global> createState() => _GlobalState();
}

class _GlobalState extends State<Global> {
  Future<GlobalSummaryModel>? summary;
  @override
  void initState() {
    super.initState();
    summary = covidHandler.getGlobalSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Global Cases',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    summary = covidHandler.getGlobalSummary();
                  });
                },
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: summary,
          builder: (context, snapshot) {
            if (snapshot.hasError) return ErrorCard();
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return GlobalLoading();
              default:
                return !snapshot.hasData
                    ? Center(
                        child: Text("Empty"),
                      )
                    : GlobalStatistics(
                        summary: (snapshot.data as GlobalSummaryModel),
                      );
            }
          },
        ),
      ],
    );
  }
}
