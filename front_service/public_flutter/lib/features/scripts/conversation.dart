import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

Future<void> createConversation(String userId) async {
  String? auth_token = html.window.localStorage["auth_token"];

  final response = await http.post(
    Uri.parse("localhost:80/api/messages/create/$userId"),
    headers: {
      'authorization': 'Bearer $auth_token'
    }
  );
}