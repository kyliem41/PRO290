import 'package:flutter/material.dart';
import 'package:frontend/features/screens/profile/customAppBar.dart';
import 'package:frontend/features/screens/profile/numbersWidget.dart';
import 'package:frontend/features/screens/profile/profileWidget.dart';
import 'package:frontend/models/userModel.dart';

class ProfileColumn extends StatefulWidget {
  @override
  _ProfileColumnState createState() => _ProfileColumnState();
}

class _ProfileColumnState extends State<ProfileColumn> {
  @override
  Widget build(BuildContext context) {
    final user = Users(
        username: 'johndoe',
        email: 'johndoe@gmail.com',
        bio: 'swell of a guy',
        imagePath: 'assets/images/john.png');

    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: customAppBar(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            // onClicked: () async {},
            onEditClicked: () {
              print('clicked :)');
            }
          ),
          SizedBox(height: 24),
          buildName(user),
          SizedBox(height: 24),
          NumbersWidget(),
          SizedBox(height: 48),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(Users user) => Column(
        children: [
          Text(
            user.username,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(Users user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              user.bio,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
