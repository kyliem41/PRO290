import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

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

Future<void> createAccount(String username, String dob, String email, String password, File file) async {
  var uri = Uri.parse('http://localhost:80/user/post');
  var request = http.MultipartRequest('POST', uri);

  request.fields['username'] = username;
  request.fields['dob'] = dob;
  request.fields['email'] = email;
  request.fields['password'] = password;

  var fileStream = http.ByteStream(file.openRead());
  var length = await file.length();
  var multipartFile = http.MultipartFile(
    "TempFile<'r>", // This should match the server's expected parameter name
    fileStream,
    length,
    filename: file.path.split('/').last,
  );
  request.files.add(multipartFile);

  var response = await request.send();

  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    print('Response: $responseBody');
    // Handle successful response
  } else {
    print('Failed to create account: ${response.statusCode}');
    // Handle error response
  }
}