import 'package:flutter/material.dart';
import 'package:frontend/features/screens/profile/edit/uploadIconWidget.dart';

class EditProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onUploadClicked;
  final bool isEdit;

  const EditProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onUploadClicked,
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
            child: UploadIcon(
              color: color,
              onFileSelected: (filePath) {
                print('selected file path: $filePath');
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
