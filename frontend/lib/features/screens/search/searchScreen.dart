import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/features/screens/home/notifications/notification.dart';
import 'package:frontend/features/screens/home/notifications/notificationsColumn.dart';
import 'package:frontend/features/screens/search/customAppBar.dart';
import 'package:frontend/features/screens/search/searchResultsColumn.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: SearchResultsColumn(),
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