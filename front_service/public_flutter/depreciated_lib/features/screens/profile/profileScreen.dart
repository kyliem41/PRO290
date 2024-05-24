import 'package:flutter/material.dart';
import '../home/homeGenerator.dart';
import '../location/locationScreen.dart';
import '../messages/messages/messageScreen.dart';

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
