import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewReadMe extends StatefulWidget {
  @override
  State<NewReadMe> createState() => _NewReadMeState();
}

class _NewReadMeState extends State<NewReadMe> {
  String _enteredTitle = '';

  void _newReadMe() async {
    Navigator.of(context).pop();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users/${user.uid}/readme').add({
      'project-name': _enteredTitle,
      'text': '# $_enteredTitle',
      'create-at': Timestamp.now(),
    });
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
              onChanged: (value) {
                setState(() {
                  _enteredTitle = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _enteredTitle.trim().isEmpty ? null : _newReadMe,
          )
        ],
      ),
    );
  }
}
