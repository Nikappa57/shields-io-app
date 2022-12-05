import 'package:flutter/material.dart';
import 'package:simple_markdown_editor/simple_markdown_editor.dart';

// TODO: add copy all btn
// TODO: add

class ReadMeEditor extends StatefulWidget {
  ReadMeEditor(this.text, this.onChange);
  final String text;
  final void Function(String value) onChange;
  @override
  State<ReadMeEditor> createState() => _ReadMeEditorState();
}

class _ReadMeEditorState extends State<ReadMeEditor> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: MarkdownFormField(
            controller: _controller,
            enableToolBar: true,
            emojiConvert: true,
            autoCloseAfterSelectEmoji: false,
            focusNode: _focusNode,
          ),
        ),
      ),
    );
  }
}
