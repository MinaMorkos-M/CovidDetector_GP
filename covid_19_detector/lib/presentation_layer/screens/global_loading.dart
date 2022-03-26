import 'package:covid_19_detector/presentation_layer/widgets/global_loading_card.dart';
import 'package:covid_19_detector/presentation_layer/widgets/global_loading_label.dart';
import 'package:flutter/material.dart';

class GlobalLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalLoadingCard(),
        GlobalLoadingCard(),
        GlobalLoadingCard(),
        GlobalLoadingCard(),
        LoadingLabel(),
      ],
    );
  }
}
