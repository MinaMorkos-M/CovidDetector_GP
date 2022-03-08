import 'package:covid_19_detector/models/country.dart';
import 'package:covid_19_detector/models/country_summary.dart';
import 'package:covid_19_detector/models/statistics_handler.dart';
import 'package:covid_19_detector/screens/country_loading.dart';
import 'package:covid_19_detector/screens/country_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart'
    show TextFieldConfiguration, TypeAheadFormField;

CovidHandler covidHandler = CovidHandler();

class CountryState extends StatefulWidget {
  @override
  State<CountryState> createState() => _CountryState();
}

class _CountryState extends State<CountryState> {
  final TextEditingController _typeAheadController = TextEditingController();
  late Future<List<Country>> countryList;
  late Future<List<CountrySummary>> summaryList;

  @override
  void initState() {
    super.initState();
    countryList = covidHandler.getCountryList();
    summaryList = covidHandler.getCountrySummary("egypt");
    this._typeAheadController.text = "Egypt";
  }

  List<String> _getSuggestions(List<Country> list, String query) {
    List<String> matches = [];
    for (var item in list) {
      matches.add(item.country);
    }
    matches.retainWhere(
        (element) => element.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Country>>(
      future: countryList,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text("Error"),
          );
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CountryLoading(inputTextLoading: true);
          default:
            return !snapshot.hasData
                ? Center(
                    child: Text("empty"),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 6,
                        ),
                        child: Text(
                          'Type the country name',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _typeAheadController,
                          decoration: InputDecoration(
                            hintText: "Type here country name",
                            hintStyle: TextStyle(fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.all(20),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 24, right: 16),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        onSuggestionSelected: (suggestion) {
                          this._typeAheadController.text =
                              suggestion.toString();
                          setState(() {
                            //summaryList = covidHandler.getCountrySummary((snapshot.data as String));
                            summaryList = covidHandler.getCountrySummary(
                                snapshot.data!
                                    .firstWhere((element) =>
                                        element.country == suggestion)
                                    .slug);
                          });
                        },
                        transitionBuilder:
                            (context, suggestionBox, controller) {
                          return suggestionBox;
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion.toString()),
                          );
                        },
                        suggestionsCallback: (pattern) {
                          return _getSuggestions(
                              (snapshot.data as List<Country>), pattern);
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FutureBuilder(
                        future: summaryList,
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Center(
                              child: Text("Error"),
                            );
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return CountryLoading(inputTextLoading: false);
                            default:
                              return !snapshot.hasData
                                  ? Center(
                                      child: Text('empty'),
                                    )
                                  : CountryStatistics(
                                      summaryList: (snapshot.data
                                          as List<CountrySummary>),
                                    );
                          }
                        },
                      ),
                    ],
                  );
        }
      },
    );
  }
}
