import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readme_editor/src/repo/exist_repo.dart';

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
  bool canSave = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _user = widget.user;
      _enteredTitle = widget.title;
    }
  }

  Future<bool> _isUnique() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('readme')
        .where('project-name', isEqualTo: _enteredTitle)
        .get();
    return data != null;
  }

  void _newReadMe() async {
    Navigator.of(context).pop();

    FirebaseFirestore.instance.collection('users/${user.uid}/readme').add({
      'project-name': _enteredTitle,
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
          Text(widget.documentId != null ? 'Edit ReadMe' : 'Add new ReadMe'),
          Form(
            child: Column(
              children: [
                Focus(
                  canRequestFocus: false,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'GitHub project name',
                      icon: Icon(Icons.title),
                    ),
                    initialValue: _enteredTitle,
                    onChanged: (value) {
                      if (this.mounted)
                        setState(() {
                          _enteredTitle = value;
                        });
                    },
                  ),
                  onFocusChange: (_) async {
                    final _canSave = await existRepo(_user, _enteredTitle) &&
                        await _isUnique();
                    if (this.mounted)
                      setState(() {
                        canSave = _canSave;
                      });
                  },
                ),
                Focus(
                  canRequestFocus: false,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'username',
                      icon: Icon(Icons.person),
                    ),
                    initialValue: _user,
                    onChanged: (value) {
                      if (this.mounted)
                        setState(() {
                          _user = value;
                        });
                    },
                  ),
                  onFocusChange: (_) async {
                    final _canSave = await existRepo(_user, _enteredTitle);
                    if (this.mounted)
                      setState(() {
                        canSave = _canSave;
                      });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        canSave ? Theme.of(context).primaryColor : Colors.grey),
                  ),
                  child: Text(
                    widget.documentId != null ? 'Save' : 'Add',
                    style: TextStyle(
                      color: Theme.of(context).accentTextTheme.headline6.color,
                    ),
                  ),
                  onPressed: canSave
                      ? () async {
                          final bool _canSave =
                              await existRepo(_user, _enteredTitle);
                          if (_canSave) {
                            if (widget.documentId != null)
                              _editReadMe();
                            else
                              _newReadMe();
                          } else {
                            if (this.mounted)
                              setState(() {
                                canSave = _canSave;
                              });
                          }
                        }
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
