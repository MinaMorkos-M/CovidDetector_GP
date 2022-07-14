import 'package:covid_19_detector/data_layer/models/user.dart';

class Dummy {
  static List<User> users = [
    User(
        //shoubra
        country: "",
        state: "",
        city: "",
        password: "",
        id: 1,
        name: "Mina",
        username: "mina",
        email: "email1",
        phone: "012",
        infected: true,
        lat: 30.077291,
        lng: 31.242953,
        uid: "123123123"),
    User(
        city: "",
        state: "",
        country: "",
        //alex
        password: "",
        id: 3,
        name: "Omar",
        username: "omar",
        email: "email3",
        phone: "014",
        infected: true,
        lat: 31.242767,
        lng: 30.077209,
        uid: "123123"),
    User(
      //shoubra
      city: "",
      state: "",
      country: "",
      password: "",
      id: 4,
      name: "Mohamed",
      username: "mohamed",
      email: "email4",
      phone: "015",
      infected: true,
      lat: 30.077209,
      lng: 31.242767,
      uid: "312323",
    ),
    User(
      //alex
      city: "",
      state: "",
      country: "",
      password: "",
      id: 5,
      name: "monmon",
      username: "username",
      email: "email",
      phone: "phone",
      infected: true,
      lat: 31.244246,
      lng: 30.075191,
      uid: "23123123",
    ),
    User(
      city: "",
      state: "",
      country: "",
      //alex
      password: "",
      id: 6,
      name: "Mina",
      username: "mina",
      email: "email1",
      phone: "012",
      infected: false,
      lat: 31.210609,
      lng: 30.031123,
      uid: "12312312",
    ),
  ];
}
