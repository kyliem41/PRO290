import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:frontend/models/postModel.dart' as PostModel;
import 'package:frontend/features/scripts/userService.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/features/scripts/get_user.dart';
// front_service\public_flutter\lib\features\scripts
import 'package:http/http.dart' as http;
import 'package:frontend/features/scripts/get_user.dart';

class Post extends StatefulWidget {
  final PostModel.Post post;

  const Post({required this.post});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  late Future<String> username;
  late Future<Users> futureUser;

  @override
  void initState() {
    super.initState();
    username = getUsername(widget.post.userId);
    futureUser = getUserById(widget.post.userId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<Users>(
              future: futureUser,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return CircleAvatar(
                    child: Text("U"),
                  );
                } else if (!snapshot.hasData) {
                  return CircleAvatar(
                    child: Text("U"),
                  );
                } else {
                  final user = snapshot.data!;
                  return FutureBuilder<Uint8List?>(
                    future: getPfpById(user.id),
                    builder: (context, pfpSnapshot) {
                      if (pfpSnapshot.connectionState == ConnectionState.waiting) {
                        return CircleAvatar(
                          child: CircularProgressIndicator(),
                        );
                      } else if (pfpSnapshot.hasError || pfpSnapshot.data == null) {
                        return CircleAvatar(
                          child: Text("U"),
                        );
                      } else {
                        return CircleAvatar(
                          backgroundImage: MemoryImage(pfpSnapshot.data!),
                        );
                      }
                    },
                  );
                }
              },
            ),
            Expanded(
              flex: 3,
              child: FutureBuilder<Users>(
                future: futureUser,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('No user data');
                  } else {
                    final user = snapshot.data!;
                    return _postContent(user.username, widget.post.content);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _postContent(String username, String content) {
  return Flexible(
    child: ListView(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(username,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(username, style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(content,
                    style: TextStyle(color: Colors.black)), //text
              ),
              SizedBox(height: 10),
              Container(
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    HoverableIcon(
                      icon: Icons.message_rounded,
                      label: "0",
                      hintText: "Comments",
                      onTap: () {
                        print('Comments icon clicked');
                      },
                    ),
                    HoverableIcon(
                      icon: Icons.repeat,
                      label: "0",
                      hintText: "Reposts",
                      onTap: () {
                        print('Repeat icon clicked');
                      },
                    ),
                    HoverableIcon(
                      icon: Icons.favorite_border,
                      label: "0",
                      hintText: "Likes",
                      onTap: () {
                        print('Like icon clicked');
                      },
                    ),
                    HoverableIcon(
                      icon: Icons.share,
                      label: "",
                      hintText: "Share",
                      onTap: () {
                        print('Share icon clicked');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class HoverableIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final String hintText;
  final VoidCallback onTap;

  const HoverableIcon({
    Key? key,
    required this.icon,
    required this.label,
    required this.hintText,
    required this.onTap,
  }) : super(key: key);

  @override
  _HoverableIconState createState() => _HoverableIconState();
}

class _HoverableIconState extends State<HoverableIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovering = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Tooltip(
          message: widget.hintText,
          child: Row(
            children: <Widget>[
              Icon(widget.icon, color: _hovering ? Colors.blue : Colors.black),
              if (widget.label.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(left: 3),
                  child: Text(widget.label,
                      style: TextStyle(
                          color: _hovering ? Colors.blue : Colors.black)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}