import 'package:flutter/material.dart';
import 'package:frontend/features/screens/messages/conversations/conversationList.dart';
import 'package:frontend/models/chatUsersModel.dart';

class ChatColumn extends StatefulWidget {
  @override
  _ChatColumnState createState() => _ChatColumnState();
}

class _ChatColumnState extends State<ChatColumn> {
  List<ChatUsers> chatUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        //BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Conversations',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 121, 107, 1)),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 2),
                          IconButton(
                            //TODOS: add new convo
                            onPressed: () {},
                            icon: Icon(Icons.add),
                            tooltip: 'New Conversation',
                            color: Color.fromRGBO(0, 121, 107, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "search",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // return ConversationList(
                //   name: chatUsers[index].name,
                //   messageText: chatUsers[index].messageText,
                //   imageURL: chatUsers[index].imageURL,
                //   time: chatUsers[index].time,
                //   isMessageRead: (index == 0 || index == 3) ? true : false,
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
