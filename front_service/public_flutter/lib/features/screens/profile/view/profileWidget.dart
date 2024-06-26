import 'package:flutter/material.dart';
import 'package:frontend/features/screens/profile/view/editIconWidget.dart';

class ProfileWidget extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onEditClicked;
  final bool isEdit;

  const ProfileWidget({
    Key? key,
    required this.image,
    required this.onEditClicked,
    this.isEdit = false,
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
              onEditClicked: onEditClicked,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
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
