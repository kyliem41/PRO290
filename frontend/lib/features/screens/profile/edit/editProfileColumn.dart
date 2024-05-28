import 'package:flutter/material.dart';
import 'package:frontend/features/screens/profile/edit/customAppBar.dart';
import 'package:frontend/features/screens/profile/edit/editProfileWidget.dart';
import 'package:frontend/features/screens/profile/edit/textFieldWidget.dart';
import 'package:frontend/models/userModel.dart';

class EditProfileColumn extends StatefulWidget {
  @override
  _EditProfileColumnState createState() => _EditProfileColumnState();
}

class _EditProfileColumnState extends State<EditProfileColumn> {
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Users(
        username: 'johndoe',
        email: 'johndoe@gmail.com',
        bio: 'swell of a guy',
        pfp: 'assets/images/john.png',
        id: 420420420420,
        followers: ['jane', 'jim', 'joe'],
        following: ['jane', 'jim', 'joe'],
        dob: DateTime(2000, 1, 1),
        password: 'password'
        );

    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: customAppBar(),
      body: ListView(
        padding: EdgeInsets.only(top: 60, right: 100, left: 100),
        physics: BouncingScrollPhysics(),
        children: [
          EditProfileWidget(
              imagePath: user.pfp, isEdit: true, onUploadClicked: () {}),
          SizedBox(height: 24),
          TextFieldWidget(
            label: 'username',
            text: user.username,
            onChanged: (username) {
              _userController.text = username;
              print('username: $username');
            },
          ),
          SizedBox(height: 24),
          TextFieldWidget(
            label: 'email',
            text: user.email,
            onChanged: (email) {
              _emailController.text = email;
              print('email: $email');
            },
          ),
          SizedBox(height: 24),
          TextFieldWidget(
            label: 'bio',
            text: user.bio,
            maxLines: 5,
            onChanged: (bio) {
              _bioController.text = bio;
              print('bio: $bio');
            },
          ),
          SizedBox(height: 34),
          SizedBox(
            width: 50,
            child: ElevatedButton(
                onPressed: () {
                  // SubmitDetails();
                },
                child: Text('SUBMIT')),
          ),
        ],
      ),
    );
  }
}
