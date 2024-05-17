import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final VoidCallback onEditClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    required this.onEditClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        alignment: Alignment.center,
      children: [
        buildImage(),
        Positioned(
          bottom: 0,
          right: 0,
          child: buildEditIcon(color),
        ),
      ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          height: 128,
          width: 128,
          // child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

      Widget buildEditIcon(Color color) => FloatingActionButton(
        // onPressed: onEditClicked,
        // backgroundColor: Colors.white,
        // child: Container(
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //     color: color,
        //   ),
        //   padding: EdgeInsets.all(8),
        //   child: Icon(
        //     Icons.edit,
        //     color: Colors.white,
        //     size: 20,
        //   ),
        // ),
        
      );

    // Widget buildEditIcon(Color color) => GestureDetector(
    //   onTap: onEditClicked,
    //   child: buildCircle(
    //     color: Colors.white,
    //     all: 3,
    //     child: buildCircle(
    //       color: color,
    //       all: 8,
    //       child: const Icon(
    //         Icons.edit,
    //         color: Colors.white,
    //         size: 20,
    //       ),
    //     ),
    //   ),
    // );

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
