import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readme_editor/widgets/readme_editor/readme_editor.dart';
import 'package:readme_editor/widgets/readme_editor/readme_preview.dart';

// TODO: responsive

class SingleReadMe extends StatefulWidget {
  SingleReadMe(this.documentId, this.title, this.text);
  final String documentId;
  final String title;
  final String text;

  @override
  State<SingleReadMe> createState() => _SingleReadMeState();
}

class _SingleReadMeState extends State<SingleReadMe> {
  String _textInput;
  bool _btnActive = false;

  @override
  void initState() {
    super.initState();
    _textInput = widget.text;
  }

  void _onChange(value) {
    setState(() {
      _textInput = value;
      _btnActive = true;
    });
  }

  void _updateReadMe() async {
    final user = await FirebaseAuth.instance.currentUser();
    await Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('readme')
        .document(widget.documentId)
        .updateData({'text': _textInput});

    setState(() {
      _btnActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.cloud_upload_outlined),
            onPressed: _btnActive ? _updateReadMe : null,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: ReadMePreview(_textInput),
          ),
          Divider(
            thickness: 2.0,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: ReadMeEditor(_textInput, _onChange),
          ),
        ],
      ),
    );
  }
}
