import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/features/screens/messages/messages/customAppBar.dart';
import 'package:frontend/features/scripts/messageService.dart';
import 'package:frontend/features/scripts/userService.dart';
import 'package:frontend/models/chatMessageModel.dart';
import 'package:frontend/models/chatUsersModel.dart';

class MessageColumn extends StatefulWidget {
  @override
  _MessageColumnState createState() => _MessageColumnState();
}

class _MessageColumnState extends State<MessageColumn> {
  List<ChatMessage> messages = [];
  ChatUsers? sender;
  List<ChatUsers> recipients = [];
  final _controller = TextEditingController();
  final MessageService messageService = MessageService();
  final UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    _loadUsersAndMessages();
  }

  void _loadUsersAndMessages() async {
    try {
      // ChatUsers sender = await userService.getSender();
      // List<ChatUsers> recipients = await userService.getRecipients();
      List<ChatMessage> loadedMessages = await messageService.getMessages();

      setState(() {
        // sender = sender;
        // recipients = recipients;
        messages = loadedMessages;
      });
    } catch (e) {
      print('Error loading messages: $e');
    }
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty &&
        sender != null &&
        recipients.isNotEmpty) {
      ChatMessage newMessage = ChatMessage(
          messageId: '',
          // senderId: sender!.userId.toString(),
          senderId: 'senderId',
          recipientIds: ['recipientId'],
          // recipientIds: recipients.map((r) => r.userId.toString()).toList(),
          content: _controller.text,
          messageType: 'text',
          conversationId: '');

      try {
        ChatMessage message = await messageService.createMessage(newMessage);
        setState(() {
          messages.add(message);
        });
        _controller.clear();
      } catch (e) {
        print('Error creating message: $e');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: customAppBar(),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 15, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.teal[200]
                          : Colors.teal[300]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messages[index].content,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 121, 107, 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixIcon: Icon(
                          Icons.colorize_rounded,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                      ),
                      onSubmitted: (value) => _sendMessage(),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: _sendMessage,
                    backgroundColor: Color.fromRGBO(0, 121, 107, 1),
                    elevation: 0,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}