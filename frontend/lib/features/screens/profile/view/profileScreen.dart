import 'package:flutter/material.dart';
import 'package:frontend/features/screens/profile/view/profileColumn.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.teal.shade100,
              child: ProfileColumn(),
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
