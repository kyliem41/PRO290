import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// class Users {
//   String username;
//   String pfp;
//   String bio;
//   List<String> followers;
//   List<String> following;

//   Users(
//       {
//         required this.username,
//         required this.pfp,
//         required this.bio,
//         required this.followers,
//         required this.following
//       });
// }

class Users {
  int id;
  String username;
  String email;
  String password;
  DateTime dob;
  String bio;
  String pfp;
  List<String> followers;
  List<String> following;

  Users({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.dob,
    required this.bio,
    required this.pfp,
    required this.followers,
    required this.following,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      dob: DateTime.parse(json['dob']),
      bio: json['bio'],
      pfp: json['pfp'],
      followers: List<String>.from(json['followers']),
      following: List<String>.from(json['following']),
    );
  }
}
