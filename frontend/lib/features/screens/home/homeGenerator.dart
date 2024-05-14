import 'package:flutter/material.dart';
import 'package:frontend/features/screens/home/notifications/notificationsColumn.dart';
import 'package:frontend/features/screens/home/posts/postsColumn.dart';

class GenerateHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Container(
              // margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              color: Colors.teal.shade100,
              child: PostsColumn(),
            ),
          ),
          SizedBox(
            width: 450,
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

// class Search extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         AppBar(
//           automaticallyImplyLeading: false,
//           title: const Text('Search:'),
//           backgroundColor: Theme.of(context).cardColor,
//           actions: <Widget>[
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.arrow_forward_ios_rounded),
//               tooltip: 'Search',
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }