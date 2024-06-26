import 'package:flutter/material.dart';
import 'customAppBar.dart';
import '../../../../models/chatMeessageModel.dart';
import '../../../../scripts/message.dart';

class MessageColumn extends StatefulWidget {
  @override
  _MessageColumnState createState() => _MessageColumnState();
}

class _MessageColumnState extends State<MessageColumn> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

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
                      messages[index].messageContent,
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
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    //here
                    onPressed: () async {
                      print(await sendMessage("3f145f08-e447-4bc8-995a-d10000cff49b", "7db64d06-9acd-45f7-90e6-1708801e5ab7", "this is a test", "text", "7db64d06-9acd-45f7-90e6-1708801e5ab7"));
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Color.fromRGBO(0, 121, 107, 1),
                    elevation: 0,
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
