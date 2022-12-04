import 'package:flutter/material.dart';

class ReadMeEditor extends StatefulWidget {
  ReadMeEditor(this.text, this.onChange);
  final String text;
  final void Function(String value) onChange;
  @override
  State<ReadMeEditor> createState() => _ReadMeEditorState();
}

class _ReadMeEditorState extends State<ReadMeEditor> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scrollbar(
          child: TextField(
        controller: _controller,
        expands: true,
        maxLines: null,
        onChanged: widget.onChange,
      )),
    );
  }
}
