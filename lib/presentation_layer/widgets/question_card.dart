import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  QuestionCard(this.question);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.025,
      ).add(
        EdgeInsets.only(
          bottom: 20,
        ),
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          topLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      color: Colors.black,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            question,
            maxLines: 8,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
