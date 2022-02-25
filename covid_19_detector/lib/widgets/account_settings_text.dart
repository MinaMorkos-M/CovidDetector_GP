import 'package:flutter/material.dart';

class AccountSettingsText extends StatelessWidget {
  const AccountSettingsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: 15,
          top: 15,
        ),
        child: Text(
          'Account Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
