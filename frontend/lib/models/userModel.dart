import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Users {
  String username;
  String email;
  String bio;
  String imagePath;

  Users(
      {required this.username,
      required this.email,
      required this.bio,
      required this.imagePath});
}

// class Users {
//   int Id;
//   String username;
//   String email;
//   String password;
//   DateTime dob;
//   String bio;
//   String pfp;
//   int followers;
//   int following;

//   Users(
//       {required this.Id,
//       required this.username,
//       required this.email,
//       required this.password,
//       required this.dob,
//       required this.bio,
//       required this.pfp,
//       required this.followers,
//       required this.following});
// }
