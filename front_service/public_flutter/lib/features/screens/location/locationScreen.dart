import 'package:flutter/material.dart';
import 'package:frontend/features/screens/home/notifications/notificationsColumn.dart';
import 'package:frontend/features/screens/location/posts/locationPostsColumn.dart';

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.teal.shade100,
              child: LocationPostsColumn(),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Container(
              color: Colors.white,
              // child: NotificationColumn(),
            ),
          )
        ],
      ),
    );
  }
}
