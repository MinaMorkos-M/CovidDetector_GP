import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class Preventions extends StatelessWidget {
  final List<String> images = [
    'assets/images/preventions/disinfect_surfaces.jpg',
    'assets/images/preventions/excercise_and_eat_healthy.jpg',
    'assets/images/preventions/maintain_a_safe_distance.jpg',
    'assets/images/preventions/stay_home.jpg',
    'assets/images/preventions/wash_your_hands.jpg',
    'assets/images/preventions/wear_a_mask.jpg'
  ];
  final List<String> imageDescription = [
    'Disinfect surface and keep isolated',
    'Do excercise and eat healthy food',
    'Maintain a safe distance from others at least 1 meter',
    'Stay at home',
    'Wash your hands from time to time',
    'Wear a mask wherever you go'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preventions'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PageIndicatorContainer(
          shape: IndicatorShape.circle(size: 10),
          indicatorColor: Colors.black,
          indicatorSelectorColor: Theme.of(context).primaryColor,
          length: 6,
          child: PageView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
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
