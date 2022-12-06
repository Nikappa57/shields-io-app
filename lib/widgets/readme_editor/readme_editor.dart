import 'package:flutter/material.dart';
import 'package:simple_markdown_editor/simple_markdown_editor.dart';

// TODO: add copy all btn

class ReadMeEditor extends StatefulWidget {
  ReadMeEditor(this.text, this.onChange, this.controller);
  final String text;
  final TextEditingController controller;
  final void Function(String value) onChange;
  @override
  State<ReadMeEditor> createState() => _ReadMeEditorState();
}

class _ReadMeEditorState extends State<ReadMeEditor> {
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scrollbar(
        child: MarkdownFormField(
          controller: widget.controller,
          enableToolBar: true,
          emojiConvert: true,
          focusNode: _focusNode,
          onChanged: widget.onChange,
        ),
      ),
    );
  }
}
