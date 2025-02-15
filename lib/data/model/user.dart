// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? idUser;
  String? name;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;

  User({
    this.idUser,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    idUser: json["id_user"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "name": name,
    "email": email,
    "password": password,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
