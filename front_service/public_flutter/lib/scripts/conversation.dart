import 'dart:convert';
import 'package:http/http.dart' as http;

//possibly dont send all the data
Future<Map<String, dynamic>> getUser(String username) async {
  final response = await http.get(Uri.parse('http://localhost:80/user/get/username/$username'));
  if (response.statusCode == 200) {
    print(response.body);
    return jsonDecode(response.body);
  } 
  else {
    throw Exception('Failed to load user');
  }
}