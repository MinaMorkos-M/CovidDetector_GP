import 'package:covid_19_detector/presentation_layer/widgets/country%20statistics/country_loading_card.dart';
import 'package:covid_19_detector/presentation_layer/widgets/country%20statistics/country_loading_input_card.dart';
import 'package:covid_19_detector/presentation_layer/widgets/global%20statistics/global_loading_label.dart';
import 'package:flutter/material.dart';

class CountryLoading extends StatelessWidget {
  final bool inputTextLoading;

  CountryLoading({
    required this.inputTextLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        inputTextLoading ? CountryLoadingInputCard() : Container(),
        CountryLoadingCard(),
        CountryLoadingCard(),
        LoadingLabel(),
      ],
    );
  }
}
