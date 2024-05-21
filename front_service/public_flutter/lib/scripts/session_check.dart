//the name of this file may need to be changed
import 'package:http/http.dart' as http;
import 'dart:html' as html;

Future<bool> hasValidSession() async {
  String? token = html.window.localStorage["auth_token"];
  print("Token: $token");

  if (token != null) {
    final response = await http.get(Uri.parse('http://localhost:80/user/token/verify/$token'));
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
  return false;
}