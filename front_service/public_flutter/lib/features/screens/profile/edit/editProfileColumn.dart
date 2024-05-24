import 'package:flutter/material.dart';
import 'package:frontend/features/screens/profile/edit/customAppBar.dart';
import 'package:frontend/features/screens/profile/edit/editProfileWidget.dart';
import 'package:frontend/features/screens/profile/edit/textFieldWidget.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/features/scripts/get_user.dart';

class EditProfileColumn extends StatefulWidget {
  @override
  _EditProfileColumnState createState() => _EditProfileColumnState();
}

class _EditProfileColumnState extends State<EditProfileColumn> {
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users?>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Users? user = snapshot.data;
          if (user != null) {
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
                      child: Text('SUBMIT'),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('No user data available');
          }
        }
      },
    );
  }
}