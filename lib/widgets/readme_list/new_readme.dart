import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewReadMe extends StatefulWidget {
  NewReadMe({
    @required this.user,
    this.documentId,
    this.title = '',
  });
  final String user;
  final String documentId;
  final String title;
  @override
  State<NewReadMe> createState() => _NewReadMeState();
}

class _NewReadMeState extends State<NewReadMe> {
  final user = FirebaseAuth.instance.currentUser;
  String _enteredTitle;
  String _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _enteredTitle = widget.title;
  }

  void _newReadMe() async {
    Navigator.of(context).pop();

    FirebaseFirestore.instance.collection('users/${user.uid}/readme').add({
      'project-name': _enteredTitle,
      'text': '# $_enteredTitle',
      'create-at': Timestamp.now(),
      'user': _user,
    });
  }

  void _editReadMe() async {
    Navigator.of(context).pop();
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('readme')
        .doc(widget.documentId)
        .update({
      'project-name': _enteredTitle,
      'user': _user,
    });
  }

  bool get canSave {
    return true; // TODO
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 20,
      ),
      child: Column(
        children: [
          Text(
              widget.documentId != null ? 'Edit new ReadMe' : 'Add new ReadMe'),
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'GitHub project name',
                    icon: Icon(Icons.title),
                  ),
                  initialValue: widget.title,
                  onChanged: (value) {
                    setState(() {
                      _enteredTitle = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'username',
                    icon: Icon(Icons.person),
                  ),
                  initialValue: widget.user,
                  onChanged: (value) {
                    setState(() {
                      _user = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: Text(
                    widget.documentId != null ? 'Save' : 'Add',
                    style: TextStyle(
                        color:
                            Theme.of(context).accentTextTheme.headline6.color),
                  ),
                  onPressed: () {
                    if (canSave) {
                      if (widget.documentId != null)
                        _editReadMe();
                      else
                        _newReadMe();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
