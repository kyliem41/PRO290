import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> validateUsername(String username) async {
  final response = await http.get(Uri.parse('http://localhost:80/user/get/username/$username'));

    if (response.statusCode == 404) {
      return "";
    }

    return "email is already linked to an existing account";
}

//needs to also check if email exists
Future<String> validateEmail(String email) async {
  RegExp expression = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  if (expression.hasMatch(email)) {
    final response = await http.get(Uri.parse('http://localhost:80/user/get/email/$email'));

    if (response.statusCode == 404) {
      return "";
    }

    return "email is already linked to an existing account";
  }

  return "Needs to be a valid email format example@example.com";
}

String validatePassword(String password, String confirmationPassword){
  RegExp expression = RegExp(r'^(?=.*[A-Z])(?=.*[0-9]).{8,}$');
  if(password == confirmationPassword) {
    if (expression.hasMatch(password)) {
      return "";
    }

    return "Password should contain at least one capital letter and number and be 8 characters in length";
  }
  
  return "Passwords don't match";
}

void createAccount (String username, String dob, String email, String password) {

}