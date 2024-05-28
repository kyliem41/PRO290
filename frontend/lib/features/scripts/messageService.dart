import 'dart:convert';
import 'package:frontend/models/chatMessageModel.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class MessageService {
  final url = Uri.parse('http://messageservice:8500/api/messages');
  String? authToken = html.window.localStorage["auth_token"];

  Future<List<ChatMessage>> getMessages() async {
    final response = await http.get(
      Uri.parse('$url'),
      headers: {
        // 'authorization': 'Bearer $authToken',
        'Access-Control-Allow-Origin': '*',
        "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
        "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => ChatMessage.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<ChatMessage> createMessage(ChatMessage message) async {
    final response = await http.post(
      Uri.parse('$url'),
      headers: {
        'Content-Type': 'application/json',
        // 'authorization': 'Bearer $authToken'
        'Access-Control-Allow-Origin': '*',
        "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
        "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
      },
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
