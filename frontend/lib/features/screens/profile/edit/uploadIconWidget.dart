import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
        final filePath = await FilePicker.platform.pickFiles();

        if (filePath != null && filePath.files.isNotEmpty) {
          onFileSelected(filePath.files.single.path);
        }
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
              )),
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
