import 'package:flutter/material.dart';
import 'package:frontend/features/screens/home/homeGenerator.dart';
import 'package:frontend/features/screens/location/locationScreen.dart';
import 'package:frontend/features/screens/notifications/notificationScreen.dart';
import 'package:frontend/features/screens/profile/profileScreen.dart';

class MessagesPage extends StatefulWidget {
  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          SizedBox(height: 30),
          Text('MESSAGE'),
        ],
      ),
    );
  }
}
