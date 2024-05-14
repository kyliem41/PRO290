import 'package:flutter/material.dart';
import 'package:frontend/features/screens/home/homeGenerator.dart';
import 'package:frontend/features/screens/location/locationScreen.dart';
import 'package:frontend/features/screens/messages/messageScreen.dart';
import 'package:frontend/features/screens/profile/profileScreen.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          SizedBox(height: 30),
          Text('NOTIFICATIONS'),
        ],
      ),
    );
  }
}
