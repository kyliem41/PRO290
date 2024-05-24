import 'package:flutter/material.dart';

AppBar customAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Color.fromRGBO(0, 121, 107, 1),
    flexibleSpace: SafeArea(
      child: Container(
        padding: EdgeInsets.only(right: 16),
        child: Row(
          children: <Widget>[
            SizedBox(width: 10),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "<https://randomuser.me/api/portraits/men/5.jpg>"),
              maxRadius: 20,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Kriss Benwat",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Online",
                    style: TextStyle(color: Colors.grey.shade50, fontSize: 13),
                  ),
                ],
              ),
            ),
            // Icon(
            //   Icons.settings,
            //   color: Colors.black54,
            // ),
          ],
        ),
      ),
    ),
  );
}