import 'package:flutter/material.dart';

class ProfileText extends StatelessWidget {
  final String text;
  ProfileText(this.text);
  
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        text,
        style: TextStyle(fontSize: 25, color: Color.fromRGBO(91, 78, 78, 1)),
      ),
    );
  }
}
