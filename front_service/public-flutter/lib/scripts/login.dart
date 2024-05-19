import 'package:http/http.dart' as http;

class LoginService {
  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('localhost:80/user/login'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } 
    else {
      return false;
    }
  }
}