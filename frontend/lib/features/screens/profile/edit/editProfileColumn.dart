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
        padding: EdgeInsets.only(top: 60, right: 100, left: 100),
        physics: BouncingScrollPhysics(),
        children: [
          EditProfileWidget(
              imagePath: user.imagePath,
              isEdit: true,
              onUploadClicked: () {
                
              }),
          SizedBox(height: 24),
          TextFieldWidget(
            label: 'username',
            text: user.username,
            onChanged: (username) {},
          ),
          SizedBox(height: 24),
          TextFieldWidget(
            label: 'email',
            text: user.email,
            onChanged: (email) {},
          ),
          SizedBox(height: 24),
          TextFieldWidget(
            label: 'bio',
            text: user.bio,
            maxLines: 5,
            onChanged: (bio) {},
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
