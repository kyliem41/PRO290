import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/userModel.dart';

Future<List<Users>> search(String username, String currentUserUsername) async {
  final response = await http.get(Uri.parse('http://localhost:80/user/search/$username?currentUser=$currentUserUsername'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body);
    List<Users> users = jsonResponse.map((userJson) => Users.fromJson(userJson)).toList();
    users.removeWhere((user) => user.username == currentUserUsername);
    
    print(users);
    return users;
  } 

  return [];
}

