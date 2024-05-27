import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:frontend/models/postModel.dart';
import 'package:frontend/features/scripts/user.dart';
import 'package:frontend/models/userModel.dart';

class PostService {
  static const String apiUrl = 'http://localhost:80/api/posts';
  static const String secret = 'idkmanwhatdoyouwantfromme';

  static Future<void> createPost(String content) async {
    try {
      // String? token = html.window.localStorage["auth_token"];
      // if (token == null) {
      //   return;
      // }
      String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6ImI3Yjg4NDkzLTIxYjctNDRmYS1hYTIxLTQyMjdmMGY5NTM5ZSIsImV4cCI6MTcxNjY1NzA0N30.eCPM6AItasHg4J8MM6g2--XyY93VQGKRx7LhaIMugk0";

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      Map<String, dynamic> map = position.toJson();

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'userId': await _getUserId(),
          'content': content,
          'position': map,
          'token': token,
        }),
      );

      if (response.statusCode == 201) {
        print('Post created successfully');
      } else {
        print('Request failed with status: ${response.statusCode} + $content');
        print(position.toJson());
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  static FutureOr<String> _getUserId() async {

    Users user = await UserService.getUserFromJWT();
    return user.id;
  }

  static Future<List<Post>> getAllPosts() async {

    // String? token = html.window.localStorage["auth_token"];
    // if (token == null) {
    //   return Future.error('No token found');
    // }
    String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6ImI3Yjg4NDkzLTIxYjctNDRmYS1hYTIxLTQyMjdmMGY5NTM5ZSIsImV4cCI6MTcxNjY1NzA0N30.eCPM6AItasHg4J8MM6g2--XyY93VQGKRx7LhaIMugk0";
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Post.fromListJson(jsonData);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return Future.error('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      return Future.error('Error: $error');
    }
  }

  static Future<List<Post>> getPostByUserId(String userId) async {

  String? token = html.window.localStorage["auth_token"];


    try {
      final response = await http.get(
        Uri.parse('$apiUrl/userId/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Post.fromListJson(jsonData);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return Future.error('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      return Future.error('Error: $error');
    }
  }
}