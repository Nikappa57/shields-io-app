import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' as md;

class ReadMePreview extends StatefulWidget {
  ReadMePreview(this.text);
  final String text;

  @override
  State<ReadMePreview> createState() => _ReadMePreviewState();
}

class _ReadMePreviewState extends State<ReadMePreview> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Html(
          data: md.markdownToHtml(
            widget.text,
            extensionSet: md.ExtensionSet.gitHubWeb,
          ),
        ),
        padding: EdgeInsets.only(bottom: 20),
      ),
    );
  }
}
