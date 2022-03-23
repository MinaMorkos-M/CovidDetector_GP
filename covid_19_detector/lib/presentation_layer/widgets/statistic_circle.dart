import 'package:flutter/material.dart';

class StatisticCircle extends StatelessWidget {
  final String number;
  final text;
  StatisticCircle(this.number,this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 52,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: FittedBox(
              child: Text(
                number,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10,),
          child: Text(
            this.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}
