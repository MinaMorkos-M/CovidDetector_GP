import 'package:covid_19_detector/data_layer/models/user.dart';

class Dummy {
  static List<User> users = [
    User(
      //shoubra
      id: 1,
      name: "Mina",
      username: "mina",
      email: "email1",
      phone: "012",
      infected: true,
      lat: 30.077291,
      lng: 31.242953,
    ),
    User(
      //alex
      id: 3,
      name: "Omar",
      username: "omar",
      email: "email3",
      phone: "014",
      infected: true,
      lat: 31.242767,
      lng: 30.077209,
    ),
    User(
      //shoubra
      id: 4,
      name: "Mohamed",
      username: "mohamed",
      email: "email4",
      phone: "015",
      infected: true,
      lat: 30.077209,
      lng: 31.242767,
    ),
    User(
      //alex
      id: 5,
      name: "monmon",
      username: "username",
      email: "email",
      phone: "phone",
      infected: true,
      lat: 31.244246,
      lng: 30.075191,
    ),
    User(
      //alex
      id: 6,
      name: "Mina",
      username: "mina",
      email: "email1",
      phone: "012",
      infected: false,
      lat: 31.210609,
      lng: 30.031123,
    ),
  ];
}