import 'package:frontend/models/userModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'dart:typed_data';

Future<void> onFollow(String userId) async {
  String? auth_token = html.window.localStorage["auth_token"];
  if (auth_token != null) {
    final response = await http.post(Uri.parse('http://localhost:80/user/follow/$auth_token/$userId'));
    print(response.statusCode);
  }
}

Future<void> onUnfollow(String userId) async{
  String? auth_token = html.window.localStorage["auth_token"];
  if (auth_token != null) {
    final response = await http.delete(Uri.parse('http://localhost:80/user/unfollow/$auth_token/$userId'));
    print(response.statusCode);
  }
}