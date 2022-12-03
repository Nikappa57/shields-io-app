import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RenameReadMe extends StatefulWidget {
  RenameReadMe(this.documentId, this.title);

  final String documentId;
  final String title;
  @override
  State<RenameReadMe> createState() => _RenameReadMe();
}

class _RenameReadMe extends State<RenameReadMe> {
  String _enteredTitle = '';
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _enteredTitle = widget.title;
    _controller.text = widget.title;
  }

  void _renameReadMe() async {
    Navigator.of(context).pop();
    final user = await FirebaseAuth.instance.currentUser();
    await Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('readme')
        .document(widget.documentId)
        .updateData({'project-name': _enteredTitle});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: 'GitHub project name'),
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _enteredTitle = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _enteredTitle.trim().isEmpty ? null : _renameReadMe,
          )
        ],
      ),
    );
  }
}
