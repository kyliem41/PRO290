import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:frontend/models/postModel.dart';


class PostService {
  static const String apiUrl = 'http://localhost:80/api/posts';
  static const String secret = 'idkmanwhatdoyouwantfromme';

//   Future<List<dynamic>> fetchPosts() async {
//     try {
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         return jsonData;
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         return [];
//       }
//     } catch (error) {
//       print('Error: $error');
//       return [];
//     }
//   }

  static Future<void> createPost(String content) async {
  try {
    //final token = html.window.localStorage["auth_token"];
    final token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6ImI3Yjg4NDkzLTIxYjctNDRmYS1hYTIxLTQyMjdmMGY5NTM5ZSIsImV4cCI6MTcxNjQ4MTAwM30.DYwRLOV2GfpG7fv0FbzW1wrgcreINW2ncCA97jvXpF0";

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Map<String, dynamic> map = position.toJson();

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token', // Include the token in the Authorization header
      },
      body: jsonEncode(<String, dynamic>{
        'userId':  await _getUserId(), 
        'content': "hard conded content",
        'position': map,
      }),
    );

    if (response.statusCode == 201) {
      print('Post created successfully');
    } else {
      print('Request failed with status: ${response.statusCode} + $content');
      print(position.toJson());
    }
  } catch (error) {
    print('Error: $error');
  }
}

// Future<String> _getToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('token');
//   return token ?? '';
// }

static FutureOr<String> _getUserId() async {
  String? token = html.window.localStorage["auth_token"];
  if (token == null) {
    return '';
  }

try {
  // Decode the JWT token
  final jwt = JWT.verify(token, SecretKey(secret));

  // Extract the user ID from the token's payload
  final userId = jwt.payload['id'];

  // Use the user ID as needed
  return userId;
} catch (e) {
  print('Error decoding JWT token: $e');
}
// should never reach here
 return ''; 
}

static Future<List<Post>> getAllPosts() async {
  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Post.fromListJson(jsonData);
    } else {
      print('Request failed with status: ${response.statusCode}');
      return Future.error('Request failed with status: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
    return Future.error('Error: $error');
  }
}

}