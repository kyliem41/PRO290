import 'package:flutter/cupertino.dart';

class ChatMessage {
  String messageId;
  String senderId;
  List<String> recipientIds;
  String content;
  String messageType;
  String conversationId;
  bool readStatus;

  ChatMessage({
    required this.messageId,
    required this.senderId,
    required this.recipientIds,
    required this.content,
    required this.messageType,
    required this.conversationId,
    this.readStatus = false,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageId: json['messageId'],
      senderId: json['senderId'],
      recipientIds: List<String>.from(json['recipientIds']),
      content: json['content'],
      messageType: json['type'],
      conversationId: json['conversationId'],
      readStatus: json['readStatus'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'recipientIds': recipientIds,
      'content': content,
      'type': messageType,
      'conversationId': conversationId,
      'readStatus': readStatus,
    };
  }
}