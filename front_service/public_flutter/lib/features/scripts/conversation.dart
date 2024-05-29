import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:frontend/models/conversation.dart';

Future<Conversation?> createConversation(Conversation conversation) async {
  String? authToken = html.window.localStorage["auth_token"];

  final response = await http.post(
    Uri.parse("http://localhost:80/api/messages/create/"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
      'Access-Control-Allow-Origin': '*',
      "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
      "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
    },
    body: jsonEncode(conversation.toJson()),
  );

  if (response.statusCode == 201) {
    Map<String, dynamic> responseBody = jsonDecode(response.body);    
    Conversation conversation = Conversation.fromJson(responseBody);
    
    return conversation;
  }

  return null;
}

Future<List<dynamic>> getConversations() async {
  String? auth_token = html.window.localStorage["auth_token"];

  final response = await http.get(
    Uri.parse("http://localhost:80/api/messages/conversations"),
    headers: {
      'authorization': '$auth_token'
    }
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonConversations = json.decode(response.body);

    print("This: $jsonConversations");

    return jsonConversations;
  } 
  else {
    throw Exception('Failed to load conversations: ${response.statusCode}');
  }
}
