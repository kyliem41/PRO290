import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:frontend/features/scripts/update_user.dart';

class UploadIcon extends StatelessWidget {
  final Color color;
  final Function(String?) onFileSelected;

  const UploadIcon({
    Key? key,
    required this.color,
    required this.onFileSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
        uploadInput.accept = 'image/*';
        uploadInput.click();

        uploadInput.onChange.listen((event) {
          final files = uploadInput.files;
          if (files != null && files.isNotEmpty) {
            final file = files[0];
            updatePfp(file);
            onFileSelected(file.relativePath);
          }
        });
      },
      child: Tooltip(
        message: 'Upload Picture',
        child: buildCircle(
          color: Colors.white,
          all: 3,
          child: buildCircle(
            all: 8,
            color: color,
            child: Icon(
              Icons.upload_file_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
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