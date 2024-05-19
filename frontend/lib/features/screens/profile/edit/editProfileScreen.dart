import 'package:flutter/material.dart';
import 'package:frontend/features/screens/profile/edit/editProfileColumn.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Container(
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.teal.shade100,
              child: EditProfileColumn(),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Container(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}