import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readme_editor/provider/shield.dart';
import 'package:readme_editor/src/shield/category.dart';
import 'package:readme_editor/widgets/shield_list/dropdown_button.dart';
import 'package:readme_editor/widgets/shield_list/shield_list_item.dart';
import 'package:readme_editor/widgets/shield_list/topnavbar.dart';

// TODO: add favourites shields

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
  ShieldCategory _currentCategory = ShieldCategory.values[0];

  _changeCategory(ShieldCategory category) {
    if (category != _currentCategory)
      setState(() {
        _currentCategory = category;
      });
  }

  @override
  Widget build(BuildContext context) {
    final shields = Provider.of<Shields>(context)
        .shields
        .where((element) => element.category == _currentCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.userId)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot userData) {
                if (userData.connectionState == ConnectionState.waiting)
                  return Container();
                return ReadMeDropdownButton(
                  username: userData.data.data()['username'],
                  repo: widget.title,
                );
              }),
        ],
      ),
      body: Column(
        children: [
          TopNavBar(_currentCategory, _changeCategory),
          Expanded(
              child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.userId)
                .get(),
            builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> userData) =>
                Container(
              child: ListView.builder(
                itemCount: shields.length,
                itemBuilder: (BuildContext context, int index) =>
                    ShieldListItem(
                  shield: shields[index],
                  repo: widget.title,
                  username: userData.data.data()['username'],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
