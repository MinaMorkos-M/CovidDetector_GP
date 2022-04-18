import 'dart:convert';
import 'package:covid_19_detector/data_layer/models/global.dart';

import '../../data_layer/models/country_summary.dart';
import '../../data_layer/models/country.dart';
import 'package:http/http.dart' as http;

class CovidHandler {
  Future<GlobalSummaryModel> getGlobalSummary() async {
    final data = await http.Client()
        .get(Uri.parse("https://api.covid19api.com/summary"));

    if (data.statusCode != 200) throw Exception();

    GlobalSummaryModel summary =
        new GlobalSummaryModel.fromJson(json.decode(data.body));

    return summary;
  }

  Future<List<CountrySummary>> getCountrySummary(String slug) async {
    final data = await http.Client().get(
        Uri.parse("https://api.covid19api.com/total/dayone/country/$slug"));

    if (data.statusCode != 200) throw Exception();

    List<CountrySummary> summaryList = (json.decode(data.body) as List)
        .map((item) => new CountrySummary.fromJson(item))
        .toList();

    return summaryList;
  }

  Future<List<Country>> getCountryList() async {
    final data = await http.Client()
        .get(Uri.parse("https://api.covid19api.com/countries"));

    if (data.statusCode != 200) throw Exception();

    List<Country> countries = (json.decode(data.body) as List)
        .map((item) => new Country.fromJson(item))
        .toList();

    return countries;
  }
}
