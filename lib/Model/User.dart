class User {
  int? id;
  String? username;
  String? email;
  String? token;

  User({this.id, this.username, this.email, this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    token = json['token'];
  }
}
