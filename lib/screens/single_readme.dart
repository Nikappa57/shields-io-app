import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readme_editor/provider/shield.dart';
import 'package:readme_editor/src/shield/category.dart';
import 'package:readme_editor/src/shield/shield.dart';
import 'package:readme_editor/widgets/shield_list/dropdown_button.dart';
import 'package:readme_editor/widgets/shield_list/topnavbar.dart';

// TODO: confirm exit

class SingleReadMe extends StatefulWidget {
  SingleReadMe({
    @required this.documentId,
    @required this.title,
    @required this.userId,
  });
  final String documentId;
  final String title;
  final String userId;

  @override
  State<SingleReadMe> createState() => _SingleReadMeState();
}

class _SingleReadMeState extends State<SingleReadMe> {
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

    // TODO
  }

  // void _updateReadMe() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user.uid)
  //       .collection('readme')
  //       .doc(widget.documentId)
  //       .update({'text': _textInput});
  // }

  @override
  Widget build(BuildContext context) {
    final shields = Provider.of<Shields>(context).shields;

    return Scaffold(
      appBar: AppBar(
        //TODO: update this
        title: Text(widget.title),
        actions: [
          ReadMeDropdownButton(_addShield),
        ],
      ),
      body: TopNavBar(),
      // ListView.builder(
      //   itemCount: shields.length,
      //   itemBuilder: (BuildContext context, int index) =>
      //       Text(shields[index].name),
      // ),
    );
  }
}
