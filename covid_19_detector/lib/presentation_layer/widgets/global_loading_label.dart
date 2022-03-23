import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GlobalLoadingLabel extends StatelessWidget {
  const GlobalLoadingLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.blue,
        highlightColor: Colors.blue,
        child: Column(
          children: [
            Container(
              width: 200,
              height: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
