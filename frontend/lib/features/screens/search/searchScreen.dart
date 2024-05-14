import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          SizedBox(height: 30),
          Text('SEARCH'),
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