import 'package:flutter/cupertino.dart';

class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});

  Map<String, dynamic> toJson() {
    return {
      'messageContent': messageContent,
      'messageType': messageType,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageContent: json['messageContent'],
      messageType: json['messageType'],
    );
  }
}