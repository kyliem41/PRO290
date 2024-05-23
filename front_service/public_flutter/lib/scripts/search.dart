import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> search(String username) async {
  final response = await http.get(Uri.parse('http://localhost:80/user/search/$username'));

  if (response.statusCode == 200) {

    List<dynamic> jsonResponse = jsonDecode(response.body);
    List<Map<String, dynamic>> users = jsonResponse.map((user) => user as Map<String, dynamic>).toList();
    return users;
  } 

  return [];
}
