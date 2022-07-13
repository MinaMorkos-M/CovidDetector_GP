import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class Preventions extends StatefulWidget {
  final List<String> url;
  final List<String> titles;
  Preventions({required this.url, required this.titles});
  @override
  _PreventionsState createState() => _PreventionsState();
}

class _PreventionsState extends State<Preventions> {
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
