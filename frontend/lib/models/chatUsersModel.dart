import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatUsers {
  int userId;
  String username;
  String email;
  String password;
  DateTime dob;
  String bio;
  String pfp;
  int followers;
  int following;

  ChatUsers(
      {required this.userId,
      required this.username,
      required this.email,
      required this.password,
      required this.dob,
      required this.bio,
      required this.pfp,
      required this.followers,
      required this.following});

  factory ChatUsers.fromJson(Map<String, dynamic> json) {
    return ChatUsers(
      userId: json['userId'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      dob: DateTime.parse(json['dob']),
      bio: json['bio'],
      pfp: json['pfp'],
      followers: json['followers'],
      following: json['following'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'password': password,
      'dob': dob.toIso8601String(),
      'bio': bio,
      'pfp': pfp,
      'followers': followers,
      'following': following,
    };
  }
}
