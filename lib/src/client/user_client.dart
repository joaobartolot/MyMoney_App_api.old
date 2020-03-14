import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mymoney_app/src/client/endpoint/endpoint.dart';

class User {
  final int id;
  final String name;

  User({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Token {
  final String username;
  final String password;

  Token({this.username, this.password});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      username: json['username'],
      password: json['password'],
    );
  }
}

Future<User> fetchUser(String username, String password) async {
  Map<String, dynamic> token = {
    'username': username,
    'password': password,
  };

  http.Response response = await http.post(
    token_url,
    body: token,
  );

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  }
}
