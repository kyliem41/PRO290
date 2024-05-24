import 'dart:convert';
import 'package:frontend/models/chatMessageModel.dart';
import 'package:frontend/models/chatUsersModel.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = 'http://userservice:8500/api/user';

  Future<List<ChatUsers>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => ChatUsers.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<ChatUsers> createUser(ChatUsers user) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
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
    final response = await http.get(Uri.parse('$baseUrl/sender'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return ChatUsers.fromJson(json);
    } else {
      throw Exception('Failed to get sender');
    }
  }

  Future<List<ChatUsers>> getRecipients() async {
    final response = await http.get(Uri.parse('$baseUrl/recipient'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => ChatUsers.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get sender');
    }
  }

  //add methods for update and delete
}
