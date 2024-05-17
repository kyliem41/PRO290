import 'package:flutter/material.dart';
import 'package:frontend/features/screens/profile/edit/editProfileScreen.dart';

class EditIcon extends StatelessWidget {
  final Color color;
  final VoidCallback onEditClicked;

  const EditIcon({
    Key? key,
    required this.color,
    required this.onEditClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditProfilePage()),
        );
      },
      child: Tooltip(
        message: 'Edit Profile',
        child: buildCircle(
          color: Colors.white,
          all: 3,
          child: buildCircle(
              all: 8,
              color: color,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              )),
        ),
      ),
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
