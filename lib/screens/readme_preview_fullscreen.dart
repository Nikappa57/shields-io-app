import 'package:flutter/material.dart';
import 'package:readme_editor/widgets/readme_editor/readme_preview.dart';

class ReadMePrevireFullScreen extends StatelessWidget {
  const ReadMePrevireFullScreen(this.title, this.text);
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ReadMePreview(text),
    );
  }
}
