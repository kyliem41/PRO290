import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/features/scripts/conversation.dart';
import 'package:frontend/models/chatUsersModel.dart';
import 'package:frontend/features/scripts/search.dart';
import 'package:frontend/features/scripts/get_user.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/models/conversation.dart';

class ChatColumn extends StatefulWidget {
  @override
  _ChatColumnState createState() => _ChatColumnState();
}

class _ChatColumnState extends State<ChatColumn> {
  List<ChatUsers> chatUsers = [];
  final _searchController = TextEditingController();
  List<Users> searchResults = [];
  List<dynamic> conversations = [];

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    try {
      final List<dynamic> allConversations = await getConversations();
      setState(() {
        conversations = allConversations;
      });
    } catch (e) {
      print('Error loading conversations: $e');
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('New Conversation'),
              content: Container(
                height: searchResults.isEmpty ? 150 : 400,
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search for a user",
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
                          borderSide: BorderSide(color: Colors.grey.shade100),
                        ),
                      ),
                    ),
                    if (searchResults.isNotEmpty) ...[
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                print('Selected user: ${searchResults[index]}');
                                Conversation? conversation = await createConversation(searchResults[index].id);
                              },
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text(searchResults[index].username),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Search'),
                  onPressed: () async {
                    Users? user = await getUser();
                    if (user != null) {
                      List<Users> results = await search(_searchController.text, user.username);
                      setState(() {
                        searchResults = results;
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
                        color: Color.fromRGBO(0, 121, 107, 1),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 2),
                          IconButton(
                            onPressed: _showSearchDialog,
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
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: conversations.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                itemBuilder: (context, index) {
                  return Container(
                    child: ListTile(
                      title: FutureBuilder<Users?>(
                        future: getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final currentUser = snapshot.data;
                              final conversation = conversations[index];
                              final otherUserId = conversation['firstUserId'] != currentUser?.id ? conversation['firstUserId'] : conversation['secondUserId'];
                              return FutureBuilder<String>(
                                future: getUsername(otherUserId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      final username = snapshot.data;
                                      return Text(username ?? '');
                                    }
                                  }
                                },
                              );
                            }
                          }
                        },
                      ),
                      onTap: () async {
                        Users? currentUser = await getUser();
                        final conversation = conversations[index];
                        final otherUserId = conversation['firstUserId'] != currentUser?.id ? conversation['firstUserId'] : conversation['secondUserId'];
                        print('Tapped conversation with $otherUserId');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}