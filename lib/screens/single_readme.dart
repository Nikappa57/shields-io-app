import 'package:flutter/material.dart';
import 'package:readme_editor/widgets/readme_editor/readme_editor.dart';
import 'package:readme_editor/widgets/readme_editor/readme_preview.dart';

class SingleReadMe extends StatefulWidget {
  SingleReadMe(this.documentId, this.title, this.text);
  final String documentId;
  final String title;
  final String text;

  @override
  State<SingleReadMe> createState() => _SingleReadMeState();
}

class _SingleReadMeState extends State<SingleReadMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: ReadMePreview(widget.text),
          ),
          Divider(
            thickness: 2.0,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: ReadMeEditor(widget.text),
          ),
        ],
      ),
    );
  }
}
