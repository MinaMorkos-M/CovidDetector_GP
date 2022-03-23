import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryLoadingInputCard extends StatelessWidget {
  const CountryLoadingInputCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        height: 75,
        padding: EdgeInsets.all(24),
        child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey,
          child: Container(
            width: double.infinity,
            height: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
