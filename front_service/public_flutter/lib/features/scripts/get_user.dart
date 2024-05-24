import 'package:frontend/models/userModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

Future<Users?> getUser() async {
  String? auth_token = html.window.localStorage["auth_token"];
  if (auth_token != null) {
    final response = await http.get(Uri.parse('http://localhost:80/user/get/$auth_token'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print("got user");
      print(jsonResponse);
      return Users.fromJson(jsonResponse);
    }
  }

  return null;
}