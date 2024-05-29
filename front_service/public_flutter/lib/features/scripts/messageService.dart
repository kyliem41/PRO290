import 'dart:convert';
import 'package:frontend/models/chatMessageModel.dart';
import 'package:http/http.dart' as http;

class MessageService {
  static const String baseUrl = 'http://localhost:80/api/messages';

  Future<List<ChatMessage>> getMessages() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => ChatMessage.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<ChatMessage> createMessage(ChatMessage message) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(message.toJson()),
    );

    if (response.statusCode == 201) {
      return ChatMessage.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create message');
    }
  }

  //add methods for update and delete
}