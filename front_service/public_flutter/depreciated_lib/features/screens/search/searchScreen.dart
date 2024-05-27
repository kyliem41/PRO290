import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../home/notifications/notification.dart';
import '../home/notifications/notificationsColumn.dart';
import 'customAppBar.dart';
import 'searchResultsColumn.dart';

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