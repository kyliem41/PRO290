import 'package:flutter/material.dart';

class EditIcon extends StatefulWidget {
  final Color color;
  final VoidCallback onEditClicked;

  const EditIcon({
    Key? key,
    required this.color,
    required this.onEditClicked,
  }) : super(key: key);

  @override
  _EditIconState createState() => _EditIconState();
}

class _EditIconState extends State<EditIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onEditClicked,
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: buildCircle(
          color: Colors.white,
          all: 3,
          child: buildCircle(
              all: 8,
              color: isHovered ? Colors.grey : widget.color,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              )),
        ),
      ),
    );
  }

  void _onHover(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

// Widget buildEditIcon(Color color) => GestureDetector(
//         onTap: onEditClicked,
//         child: buildCircle(
//           all: 3,
//           color: Colors.white,
//           child: buildCircle(
//             all: 8,
//             color: color,
//             child: Icon(
//               Icons.edit,
//               color: Colors.white,
//               size: 20,
//             ),
//           ),
//         ),
//       );