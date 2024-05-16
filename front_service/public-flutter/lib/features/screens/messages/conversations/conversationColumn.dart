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