import 'package:frontend/models/userModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'dart:typed_data';

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

Future<Uint8List?> getPfp() async {
  String? authToken = html.window.localStorage["auth_token"];
  if (authToken == null) {
    print('No auth token found in local storage');
    return null;
  }

  try {
    final response = await http.get(Uri.parse('http://localhost:80/user/pfp/$authToken'));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      print('Failed to fetch profile picture: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching profile picture: $e');
    return null;
  }
}

//finish
void get_posts() async {
  String? auth_token = html.window.localStorage["auth_token"];

}