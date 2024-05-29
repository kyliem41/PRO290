import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Users {
  String id;
  String username;
  String email;
  String password;
  String dob;
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

  factory Users.fromJson(Map<String, dynamic>? json) {
    return Users(
      id: json?['id'] ?? '',
      username: json?['username'] ?? '',
      email: json?['email'] ?? '',
      password: json?['password'] ?? '',
      dob: json?['dob'] ?? '',
      bio: json?['bio'] ?? '',
      pfp: json?['pfp'] ?? '',
      followers: List<String>.from(json?['followers'] ?? []),
      following: List<String>.from(json?['following'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'dob': dob,
      'bio': bio,
      'pfp': pfp,
      'followers': followers,
      'followiAng': following,
    };
  }

  @override
  String toString() {
    return 'Users{id: $id, username: $username, email: $email, password: $password, dob: $dob, bio: $bio, pfp: $pfp, followers: ${followers.length}, following: ${following.length}}';
  }
}