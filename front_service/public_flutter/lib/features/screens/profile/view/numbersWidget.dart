import 'package:flutter/material.dart';
import 'package:frontend/models/userModel.dart'; 
import 'package:frontend/features/screens/profile/view/customAppBar.dart';
import 'package:frontend/features/scripts/get_user.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users?>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          Users? user = snapshot.data;
          return buildNumbers(context, user!);
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget buildNumbers(BuildContext context, Users user) => IntrinsicHeight(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildButton(context, user.following.length.toString(), 'Following'),
        Container(
          height: 24,
          child: VerticalDivider(),
        ),
        buildButton(context, user.followers.length.toString(), 'Followers'),
        Container(
          height: 24,
          child: VerticalDivider(),
        ),
        buildButton(context, '0', 'Posts'),
      ],
    ),
  );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
