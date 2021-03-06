import 'package:covid_19_detector/presentation_layer/screens/login%20&%20signup/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[800],
        accentColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoginScreen(),
    );
  }
}
