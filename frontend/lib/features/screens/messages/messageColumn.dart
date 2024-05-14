import 'package:flutter/material.dart';
import 'package:frontend/features/screens/messages/message.dart';

class MessageColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Message'),
          centerTitle: true,
          backgroundColor: Theme.of(context).highlightColor,
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.all(12),
          child: ListView.builder(
            itemBuilder: (_, int index) => Message(),
            itemCount: 10,
            reverse: false,
          ),
        ),
      ],
    );
  }
}
