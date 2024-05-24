import 'package:flutter/material.dart';
import 'notifications/notificationsColumn.dart';
import 'posts/postsColumn.dart';

class GenerateHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: PostsColumn(),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Container(
              color: Colors.white,
              child: NotificationColumn(),
            ),
          )
        ],
      ),
    );
  }
}
