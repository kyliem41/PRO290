import 'package:flutter/material.dart';

class Post extends StatelessWidget {

  
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
                child: _postContent("testid", "test content"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _postContent(String userid, String text) {
  //final DateTime time = new DateTime(2024);
  // String user, String userHandle, 
  String time = "01/05/05";
  String location = "im right here";

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
                    child: Text(" " + userid + " " + location + " " + time,
                        style: TextStyle(
                            color: Color.fromARGB(197, 189, 189, 189))),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ultrices vitae auctor eu augue ut lectus. Purus non enim praesent elementum facilisis leo vel. Dictum fusce ut placerat orci nulla pellentesque dignissim. Mattis enim ut tellus elementum sagittis vitae. Tristique senectus et netus et malesuada fames ac turpis egestas. Malesuada fames ac turpis egestas integer eget aliquet nibh praesent. Non odio euismod lacinia at quis risus. Porta lorem mollis aliquam ut. Proin fermentum leo vel orci porta. Elementum nisi quis eleifend quam adipiscing vitae. Ut venenatis tellus in metus vulputate eu scelerisque felis imperdiet. Lectus urna duis convallis convallis tellus id interdum velit.',
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
