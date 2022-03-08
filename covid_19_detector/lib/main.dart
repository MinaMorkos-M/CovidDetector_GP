import 'package:covid_19_detector/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    //MultiProvider(
    //  providers: [
    //    ChangeNotifierProvider(
    //      create: (context) => Provider,
    //    ),
    //  ],
    //child:
    MyApp(),
    //),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[700],
        accentColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
