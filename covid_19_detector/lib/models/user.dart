
class User {
  int? id;
  String? name;
  String? username;
  String? email;
  String? password;
  String? phone;
  double lng;
  double lat;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.lat,
    required this.lng,
  });

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
