import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readme_editor/screens/readme_preview_fullscreen.dart';
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
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                height: 150,
                child: ReadMePreview(_textInput),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              Positioned(
                child: IconButton(
                  icon: Icon(
                    Icons.fullscreen,
                    color: Theme.of(context).primaryColor,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReadMePrevireFullScreen(
                        widget.title,
                        _textInput,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: ReadMeEditor(_textInput, _onChange),
          ),
        ],
      ),
    );
  }
}
