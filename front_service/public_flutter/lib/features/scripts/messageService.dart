import 'dart:convert';
import 'package:frontend/models/chatMessageModel.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class MessageService {
  final url = Uri.parse('http://localhost:80/api/messages/');
  String? authToken = html.window.localStorage["auth_token"];

  Future<List<ChatMessage>> getMessages() async {
    final response = await http.get(
      Uri.parse('$url'),
      headers: {
        'Authorization': '$authToken',
        'Access-Control-Allow-Origin': '*',
        "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
        "Access-Control-Allow-Headers":
            "Origin, X-Requested-With, Content-Type, Accept",
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => ChatMessage.fromJson(item)).toList();
    } else {
      print('Auth token: $authToken');
      print(
          'Failed to load messages: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to load messages');
    }
  }

  Future<ChatMessage> createMessage(ChatMessage message) async {
    final response = await http.post(
      Uri.parse('$url'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$authToken',
        'Access-Control-Allow-Origin': '*',
        "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
        "Access-Control-Allow-Headers":
            "Origin, X-Requested-With, Content-Type, Accept",
      },
      body: jsonEncode(message.toJson()),
    );

    if (response.statusCode == 201) {
      print('Message created: ${response.statusCode}, ${response.body}');
      return ChatMessage.fromJson(jsonDecode(response.body));
    } else {
      print('Auth token: $authToken');
      throw Exception('Failed to create message');
    }
  }

  Future<ChatMessage> getConversationId() async {
    final response = await http.get(Uri.parse('$url/get/conversationId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return ChatMessage.fromJson(json);
    } else {
      throw Exception('Failed to get conversationId');
    }
  }

  //add methods for update and delete
}
