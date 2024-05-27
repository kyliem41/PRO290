import 'package:frontend/models/userModel.dart';
import 'dart:html' as html;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> updateField(String currectValue, String newValue, String column) async {
  if (currectValue != newValue) {
    String? authToken = html.window.localStorage["auth_token"];

    final response = await http.patch(
      Uri.parse('http://localhost:80/user/update/$authToken'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'column': column,
        'new_data': newValue,
      }),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      print("updated");
    } 
    else {
      print("Error updating user");
    }
  }
}

Future<void> updatePfp(html.File file) async {
  final reader = html.FileReader();
  reader.readAsArrayBuffer(file);
  await reader.onLoadEnd.first;

  String? authToken = html.window.localStorage["auth_token"];
  final url = Uri.parse('http://localhost:80/user/update/pfp/$authToken');
  final formData = http.MultipartRequest('PATCH', url);

  formData.files.add(http.MultipartFile.fromBytes(
    'image',
    reader.result as List<int>,
    filename: file.name,
  ));

  try {
    final response = await http.Client().send(formData);
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
}
