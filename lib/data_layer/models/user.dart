
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

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.infected,
    required this.lat,
    required this.lng,
    required this.uid

  });


  // receiving data from server
  factory User.fromMap(map) {
    return User(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        id: 1 ,
      infected: false ,
      lat: 2 ,
      lng: 3 ,
      phone: "" ,
      username: "",
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'password' : password,
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