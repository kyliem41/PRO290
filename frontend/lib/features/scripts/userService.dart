import 'dart:convert';
import 'package:frontend/models/chatMessageModel.dart';
import 'package:frontend/models/chatUsersModel.dart';
import 'package:frontend/models/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class UserService {
  static const String baseUrl = 'http://userservice:8500/api/user';
  static const String apiUrl = 'http://localhost:80/user/';
  static const String secret = '';

  Future<List<ChatUsers>> getUsers() async {
    final response = await http.get(Uri.parse('$apiUrl'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => ChatUsers.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<Users> getUserFromJWT() async {
    try {
      String? token = html.window.localStorage["auth_token"];
      if (token == null) {
        return Future.error('Token not found');
      }
      // String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6ImI3Yjg4NDkzLTIxYjctNDRmYS1hYTIxLTQyMjdmMGY5NTM5ZSIsImV4cCI6MTcxNjY1NzA0N30.eCPM6AItasHg4J8MM6g2--XyY93VQGKRx7LhaIMugk0";

      final response = await http.get(
        Uri.parse('$apiUrl/get/$token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Users.fromJson(jsonData);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return Future.error('Request failed with status: ${response.statusCode}');
      }


    }
    catch (error) {
      print('Error: $error');
      return Future.error('Error: $error');
    }
    
  }

  Future<ChatUsers> createUser(ChatUsers user) async {
    final response = await http.post(
      Uri.parse('$apiUrl'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return ChatUsers.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<ChatUsers> getSender() async {
    final response = await http.get(Uri.parse('$apiUrl/get/id/sender'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return ChatUsers.fromJson(json);
    } else {
      throw Exception('Failed to get sender');
    }
  }

  Future<List<ChatUsers>> getRecipients() async {
    final response = await http.get(Uri.parse('$baseUrl/get/id/recipient'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => ChatUsers.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get sender');
    }
  }

  //add methods for update and delete
  
}
