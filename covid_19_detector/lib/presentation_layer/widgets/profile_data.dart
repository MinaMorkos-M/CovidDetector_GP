import 'package:flutter/material.dart';

class ProfileData extends StatelessWidget {
  final String name, city, country;

  ProfileData(
    this.name,
    this.city,
    this.country,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.account_circle,
        size: 50,
        color: Colors.black,
      ),
      title: Text(
        '$name',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        '$city, $country',
      ),
    );
  }
}
