import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class Symptoms extends StatefulWidget {
  final List<String> url;
  final List<String> titles;
  Symptoms({required this.url, required this.titles});
  @override
  _SymptomsState createState() => _SymptomsState();
}

class _SymptomsState extends State<Symptoms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('Symptoms'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PageIndicatorContainer(
          indicatorColor: Colors.black,
          indicatorSelectorColor: Colors.green,
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
                    child: Image.network(widget.url[index]),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.titles[index],
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
