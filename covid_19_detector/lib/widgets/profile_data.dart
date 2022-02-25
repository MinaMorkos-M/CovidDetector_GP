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
      leading: Padding(
        padding: EdgeInsets.all(3.0),
        child: CircleAvatar(
          radius: 25,
        ),
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
