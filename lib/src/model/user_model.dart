class User {
  final int id;
  final String name;
  final String token;

  User({this.id, this.name, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      token: json['token'],
    );
  }
}
