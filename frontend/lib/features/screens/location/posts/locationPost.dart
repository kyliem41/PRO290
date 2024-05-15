import 'package:flutter/material.dart';

class LocationPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              child: Text("U"),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _postContent("User", "Handle", "Text"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _postContent(String user, String userHandle, String text) {
  String time = "01/05/05";
  String location = "im right here";

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Text(
            user,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              " $userHandle $location $time",
              style: TextStyle(
                color: Color.fromARGB(197, 189, 189, 189),
              ),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: 15),
        child: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ultrices vitae auctor eu augue ut lectus. Purus non enim praesent elementum facilisis leo vel. Dictum fusce ut placerat orci nulla pellentesque dignissim. Mattis enim ut tellus elementum sagittis vitae. Tristique senectus et netus et malesuada fames ac turpis egestas. Malesuada fames ac turpis egestas integer eget aliquet nibh praesent. Non odio euismod lacinia at quis risus. Porta lorem mollis aliquam ut. Proin fermentum leo vel orci porta. Elementum nisi quis eleifend quam adipiscing vitae. Ut venenatis tellus in metus vulputate eu scelerisque felis imperdiet. Lectus urna duis convallis convallis tellus id interdum velit.',
          style: TextStyle(color: Colors.black),
        ),
      ),
      SizedBox(height: 10),
      Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.message_rounded, color: Colors.black),
                Container(
                  margin: EdgeInsets.only(left: 3),
                  child: Text("15", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.repeat, color: Colors.black),
                Container(
                  margin: EdgeInsets.only(left: 3),
                  child: Text("15", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.favorite_border, color: Colors.black),
                Container(
                  margin: EdgeInsets.only(left: 3),
                  child: Text("15", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            Icon(Icons.share, color: Colors.black),
          ],
        ),
      ),
    ],
  );
}



// import 'package:flutter/material.dart';

// class Post extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: Container(
//         padding: EdgeInsets.all(10),
//         margin: EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           border: Border.all(style: BorderStyle.solid),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             CircleAvatar(
//               child: Text("U"),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: _postContent("User", "Handle", "Text"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _postContent(String user, String userHandle, String text) {
//   //final DateTime time = new DateTime(2024);
//   String time = "01/05/05";
//   String location = "im right here";

//   return Flexible(
//     child: SingleChildScrollView(
//       child: Container(
//         margin: EdgeInsets.only(left: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Text(user,
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold)),
//                 Container(
//                   margin: EdgeInsets.only(left: 5),
//                   child: Text(" " + userHandle + " " + location + " " + time,
//                       style:
//                           TextStyle(color: Color.fromARGB(197, 189, 189, 189))),
//                 ),
//               ],
//             ),
//             Container(
//                 margin: EdgeInsets.only(top: 15),
//                 child: Text(
//                     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ultrices vitae auctor eu augue ut lectus. Purus non enim praesent elementum facilisis leo vel. Dictum fusce ut placerat orci nulla pellentesque dignissim. Mattis enim ut tellus elementum sagittis vitae. Tristique senectus et netus et malesuada fames ac turpis egestas. Malesuada fames ac turpis egestas integer eget aliquet nibh praesent. Non odio euismod lacinia at quis risus. Porta lorem mollis aliquam ut. Proin fermentum leo vel orci porta. Elementum nisi quis eleifend quam adipiscing vitae. Ut venenatis tellus in metus vulputate eu scelerisque felis imperdiet. Lectus urna duis convallis convallis tellus id interdum velit.',
//                     style: TextStyle(color: Colors.black))), //text
//             SizedBox(height: 10),
//             Container(
//               margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Icon(Icons.message_rounded, color: Colors.black),
//                       Container(
//                         margin: EdgeInsets.only(left: 3),
//                         child:
//                             Text("15", style: TextStyle(color: Colors.black)),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Icon(Icons.repeat, color: Colors.black),
//                       Container(
//                         margin: EdgeInsets.only(left: 3),
//                         child:
//                             Text("15", style: TextStyle(color: Colors.black)),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Icon(Icons.favorite_border, color: Colors.black),
//                       Container(
//                         margin: EdgeInsets.only(left: 3),
//                         child:
//                             Text("15", style: TextStyle(color: Colors.black)),
//                       ),
//                     ],
//                   ),
//                   Icon(Icons.share, color: Colors.black),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
