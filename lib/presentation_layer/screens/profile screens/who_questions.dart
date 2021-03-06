import 'package:covid_19_detector/presentation_layer/widgets/question_card.dart';
import 'package:covid_19_detector/presentation_layer/widgets/question_number_card.dart';
import 'package:flutter/material.dart';

class WhoQuestions extends StatefulWidget {
  final List<String> questions;
  WhoQuestions({required this.questions});
  @override
  _WhoQuestionsState createState() => _WhoQuestionsState();
}

class _WhoQuestionsState extends State<WhoQuestions> {
  int yesCounter = 0;
  int questionNumber = 0;

  final ButtonStyle yesButtton = ElevatedButton.styleFrom(
    primary: Colors.green,
    elevation: 5,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  final ButtonStyle noButton = ElevatedButton.styleFrom(
    primary: Colors.red,
    elevation: 5,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  final ButtonStyle againButton = ElevatedButton.styleFrom(
    primary: Colors.grey[500],
    elevation: 5,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WHO Questions'),
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: (questionNumber < widget.questions.length)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: QuestionNumberCard(
                        questionNumber, widget.questions.length),
                  ),
                  QuestionCard(
                    widget.questions[questionNumber],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      style: yesButtton,
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          yesCounter++;
                          questionNumber++;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      style: noButton,
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          questionNumber++;
                        });
                      },
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  (yesCounter >= (widget.questions.length / 2))
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Image.asset('assets/images/unvalid.png'),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Image.asset('assets/images/valid.png'),
                        ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Text(
                      (yesCounter >= (widget.questions.length / 2))
                          ? 'Please go and check with the doctor.'
                          : 'Don\'t worry you are safe.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                    ),
                    child: ElevatedButton(
                      style: againButton,
                      child: Text('Again'),
                      onPressed: () {
                        setState(() {
                          questionNumber = 0;
                          yesCounter = 0;
                        });
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
