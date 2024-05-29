import 'package:flutter/material.dart';
import 'package:frontend/features/screens/profile/edit/editProfileScreen.dart';
import 'package:frontend/features/screens/profile/view/customAppBar.dart';
import 'package:frontend/features/screens/profile/view/numbersWidget.dart';
import 'package:frontend/features/screens/profile/view/profileWidget.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/features/scripts/get_user.dart';
import 'dart:typed_data';

class ProfileColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: customAppBar(),
      body: FutureBuilder<Users?>(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Users? user = snapshot.data;
            return ListView(
              padding: EdgeInsets.only(top: 60),
              physics: BouncingScrollPhysics(),
              children: [
                FutureBuilder<Uint8List?>(
                  future: getPfp(),
                  builder: (context, pfpSnapshot) {
                    if (pfpSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } 
                    else if (pfpSnapshot.hasError) {
                      return ProfileWidget(
                        image: AssetImage('assets/default_pfp.png'),
                        onEditClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(),
                            ),
                          );
                        },
                      );
                    } else if (pfpSnapshot.hasData && pfpSnapshot.data != null) {
                      return ProfileWidget(
                        image: MemoryImage(pfpSnapshot.data!),
                        onEditClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(),
                            ),
                          );
                        },
                      );
                    } else {
                      return ProfileWidget(
                        image: AssetImage('assets/default_pfp.png'),
                        onEditClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: 24),
                buildName(user!),
                SizedBox(height: 24),
                NumbersWidget(),
                SizedBox(height: 48),
                buildAbout(user),
              ],
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
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
            "",
            style: TextStyle(color: Colors.grey[600]),
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