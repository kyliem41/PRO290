import 'package:flutter/material.dart';
import 'package:frontend/features/screens/home/posts/post.dart';
import 'package:frontend/models/postModel.dart' as PostModel;
import 'package:frontend/features/scripts/get_user.dart';

class Post extends StatefulWidget {
  final PostModel.Post post;

  const Post({required this.post});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  late Future<String> username;

  @override
  void initState() {
    super.initState();
    username = getUsername(widget.post.userId); // Fetch user data
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
            CircleAvatar(
              child: Text("U"),
            ),
            Expanded(
              child: SizedBox(
                child: FutureBuilder<String>(
                  future: username,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return Text('No user data');
                    } else {
                      String username = snapshot.data!;
                      print('Username: $username');
                      return _postContent(username, widget.post.content);
                    }
                  },
                ),
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
                      label: "15",
                      hintText: "Comments",
                      onTap: () {
                        print('Comments icon clicked');
                      },
                    ),
                    HoverableIcon(
                      icon: Icons.repeat,
                      label: "15",
                      hintText: "Reposts",
                      onTap: () {
                        print('Repeat icon clicked');
                      },
                    ),
                    HoverableIcon(
                      icon: Icons.favorite_border,
                      label: "15",
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