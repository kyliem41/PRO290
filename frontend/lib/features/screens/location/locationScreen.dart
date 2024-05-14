import 'package:flutter/material.dart';
import 'package:frontend/features/screens/home/homeGenerator.dart';
import 'package:frontend/features/screens/messages/messageScreen.dart';
import 'package:frontend/features/screens/notifications/notificationScreen.dart';
import 'package:frontend/features/screens/profile/profileScreen.dart';

class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          SizedBox(height: 30),
          Text('LOCATION'),
        ],
      ),
    );
  }
}
