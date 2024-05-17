import 'package:flutter/material.dart';
import 'package:frontend/features/screens/profile/editIconWidget.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onEditClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
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
            child: EditIcon(
              color: color, 
              onEditClicked: () {
              //Navigator.push(context, )
            },
          ),
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
        ),
      ),
    );
  }
}
