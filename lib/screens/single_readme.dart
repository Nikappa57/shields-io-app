import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readme_editor/src/shield/shield.dart';
import 'package:readme_editor/widgets/readme_editor/dropdown_button.dart';
import 'package:readme_editor/widgets/readme_editor/readme_editor.dart';

// TODO: confirm exit

class SingleReadMe extends StatefulWidget {
  SingleReadMe(this.documentId, this.title, this.text, this.userId);
  final String documentId;
  final String title;
  final String text;
  final String userId;

  @override
  State<SingleReadMe> createState() => _SingleReadMeState();
}

class _SingleReadMeState extends State<SingleReadMe> {
  String _textInput;
  bool _btnActive = false;
  TextEditingController _controller = TextEditingController();

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

  void _addShield({
    String lable = '',
    String message = '',
    String packageName = '',
    String color,
    @required String style,
    @required ShieldType shieldType,
  }) async {
    print(
        "NEWSHIELD $lable, $message, $color, $style ${shieldType.toString()}");
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get();
    final String username = userData.data()['username'];

    String newShield = "";
    if (shieldType == ShieldType.static) {
      newShield = Shield(
        user: username,
        repo: widget.title,
        color: color,
        style: style,
      ).staticShield(lable, message);
    }

    setState(() {
      _controller.text += newShield;
    });
  }

  void _updateReadMe() async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('readme')
        .doc(widget.documentId)
        .update({'text': _textInput});

    setState(() {
      _btnActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO: update this
        title: Text(widget.title),
        actions: [
          ReadMeDropdownButton(_addShield),
          IconButton(
            icon: Icon(Icons.cloud_upload_outlined),
            onPressed: _btnActive ? _updateReadMe : null,
          ),
        ],
      ),
      body: ReadMeEditor(_textInput, _onChange, _controller),
    );
  }
}
