import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:html' as html;

Future<bool> sendMessage(String senderID, String recipientIds, String content, String type, String conversationId) async {
  final url = Uri.parse('http://localhost:80/api/messages/');
  String? authToken = html.window.localStorage["auth_token"];

  final Map<String, dynamic> payload = {
    'senderId': senderID,
    'recipientIds': recipientIds,
    'content': content,
    'type': type,
    'conversationId': conversationId,
  };

  final String jsonPayload = jsonEncode(payload);

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'authorization': '$authToken'
    },
    body: jsonPayload,
  );

  print("Message Status: " + response.statusCode);

  if (response.statusCode == 201) {
    print(response.body);
    return true;
  } 
  else {
    return false;
  }
}
