import 'package:flutter/material.dart';
import 'package:frontend/features/screens/home/notifications/notification.dart';

class NotificationColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Notifications:'),
          backgroundColor: Theme.of(context).cardColor,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios_rounded),
              tooltip: 'Hide Notifications',
              color: Colors.blue,
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.all(12),
          child: ListView.builder(
            itemBuilder: (_, int index) => Notifications(),
            itemCount: 10,
            reverse: false,
          ),
        ),
      ],
    );
  }
}
