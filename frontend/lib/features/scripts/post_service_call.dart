import 'package:http/http.dart' as http;
import 'dart:convert';

class PostService {
  static const String apiUrl = 'http://localhost:80/api/posts';

  Future<List<dynamic>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }

  Future<void> createPost(String title, String content) async {
  try {
    // final token = await _getToken(); // Retrieve the token from storage or authentication service
    final token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6ImYzMTQ2OTQxLWZmZWUtNGQ0My1hMmVmLTE3MmEyNmFlMzJjMyIsImV4cCI6MTcxNjI1ODMxNn0.7uJaQhTjzcGZbrImygYjxdaLurTTDt_XdSBW-bWsM_M";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token', // Include the token in the Authorization header
      },
      body: jsonEncode(<String, dynamic>{
        'userId': 'user123', // Replace with the actual user ID
        'content': content,
        'location': 'Sample Location', // Replace with the actual location
      }),
    );

    if (response.statusCode == 201) {
      print('Post created successfully');
    } else {
      print('Request failed with status: ${response.statusCode} + $content');
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
}