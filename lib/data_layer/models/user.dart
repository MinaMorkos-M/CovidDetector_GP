class User {
  int? id;

  String? name;
  String? username;
  String? email;
  String? password;
  String? phone;
  bool infected;
  double lng;
  double lat;
  String uid;
  String country;
  String state;
  String city;

  User(
      {required this.password,
      required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.phone,
      required this.infected,
      required this.lat,
      required this.lng,
      required this.uid,
      required this.country,
      required this.state,
      required this.city});

  // receiving data from server
  factory User.fromMap(map) {
    return User(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      infected: map['infected'],
      lat: map['latitude'],
      lng: map['longitude'],
      password: map['password'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
      id: 1,
      phone: "",
      username: "",
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'password': password,
      'infected': infected,
      'longitude': lng,
      'latitude': lat,
      'country': country,
      'city': city,
      'state': state,
    };

    /*.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;

    data['phone'] = this.phone;

    return data;
  }*/
  }
}
