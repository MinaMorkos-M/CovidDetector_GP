import 'package:flutter/material.dart';

class QuestionNumberCard extends StatelessWidget {
  final int questionNumber;
  final int numberOfQuestions;
  QuestionNumberCard(this.questionNumber, this.numberOfQuestions);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.025,
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          '${questionNumber + 1}/$numberOfQuestions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
