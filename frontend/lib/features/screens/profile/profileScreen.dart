import 'package:flutter/material.dart';
import 'package:frontend/features/screens/home/homeGenerator.dart';
import 'package:frontend/features/screens/location/locationScreen.dart';
import 'package:frontend/features/screens/messages/messageScreen.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          SizedBox(height: 30),
          Text('PROFILE'),
        ],
      ),
    );
  }
}
