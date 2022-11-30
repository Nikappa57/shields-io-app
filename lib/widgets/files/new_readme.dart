import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewReadMe extends StatefulWidget {
  @override
  State<NewReadMe> createState() => _NewReadMeState();
}

class _NewReadMeState extends State<NewReadMe> {
  String _enteredTitle = '';

  void _newReadMe() {
    Navigator.of(context).pop();
    Firestore.instance.collection('files').add({
      'project-name': _enteredTitle,
      'text': 'Hi',
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
