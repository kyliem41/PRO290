import 'package:flutter/material.dart';
import 'package:frontend/features/screens/messages/conversationColumn.dart';
import 'package:frontend/features/screens/messages/messageColumn.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: MessageColumn(),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Container(
              color: Colors.white,
              child: ConversationColumn(),
            ),
          )
        ],
      ),
    );
  }
}
