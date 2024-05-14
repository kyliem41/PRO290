import 'package:flutter/material.dart';
import 'package:frontend/features/screens/messages/conversations/conversation.dart';

class ConversationColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatColumn(),
    );
  }
}

// class  extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         AppBar(
//           automaticallyImplyLeading: false,
//           title: const Text('Conversations:'),
//           backgroundColor: Theme.of(context).cardColor,
//           actions: <Widget>[
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.arrow_forward_ios_rounded),
//               tooltip: 'Hide Conversations',
//               color: Colors.blue,
//             ),
//           ],
//         ),
//         SizedBox(height: 20),
//         Container(
//           margin: EdgeInsets.only(top: 40),
//           padding: EdgeInsets.all(12),
//           child: ListView.builder(
//             itemBuilder: (_, index) => ChatColumn(),
//             itemCount: 10,
//             reverse: false,
//           ),
//         ),
//       ],
//     );
//   }
// }