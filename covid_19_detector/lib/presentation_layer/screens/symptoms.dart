import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class Symptoms extends StatelessWidget {
  final List<String> images = [
    'assets/images/symptoms/weakness.jpg',
    'assets/images/symptoms/cough.jpg',
    'assets/images/symptoms/fatigue.jpg',
    'assets/images/symptoms/fever.jpg',
    'assets/images/symptoms/stuffy_nose.jpg',
    'assets/images/symptoms/shortness_of_breath.jpg'
  ];
  final List<String> imageDescription = [
    'Weakness and drowsiness',
    'Cough',
    'Fatigue',
    'Fever',
    'Runny nose',
    'Shortness of breath'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptoms'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PageIndicatorContainer(
          indicatorColor: Colors.black,
          indicatorSelectorColor: Theme.of(context).primaryColor,
          shape: IndicatorShape.circle(size: 10),
          length: 6,
          child: PageView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        imageDescription[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
