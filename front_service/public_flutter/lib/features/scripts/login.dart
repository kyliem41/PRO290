import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class LoginService {
  Future<bool> login(String username, String password) async {
    try {
      print("Username: $username");
      print("Password $password");
      final response = await http.post(
        Uri.parse('http://localhost:80/user/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        html.window.localStorage["auth_token"] = response.body;
        return true;
      } else {
        print('Failed to login: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> doesEmailExist(String email) async {
    final response = await http.get(Uri.parse('http://localhost:80/user/get/email/$email'));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}