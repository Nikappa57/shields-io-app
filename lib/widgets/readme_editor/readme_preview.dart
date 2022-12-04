import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

// TODO: markdown styleSheet

class ReadMePreview extends StatefulWidget {
  ReadMePreview(this.text);
  final String text;

  @override
  State<ReadMePreview> createState() => _ReadMePreviewState();
}

class _ReadMePreviewState extends State<ReadMePreview> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Markdown(
        controller: _controller,
        selectable: true,
        data: widget.text,
      ),
      padding: EdgeInsets.only(bottom: 20),
    );
  }
}
