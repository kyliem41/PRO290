import 'package:flutter/material.dart';
import 'package:frontend/models/postModel.dart' as PostModel;

class Post extends StatelessWidget {
  final PostModel.Post post;

  const Post({required this.post});
  
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
                child: _postContent(post.userId, post.content),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _postContent(String userid, String content) {
  //final DateTime time = new DateTime(2024);
  //String user, String userHandle, 

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
                  Text(userid,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(userid, style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                      content,
                      style: TextStyle(color: Colors.black))), //text
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
