import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readme_editor/models/shield.dart';
import 'package:readme_editor/provider/shield.dart';
import 'package:readme_editor/src/shield/category.dart';
import 'package:readme_editor/widgets/shield_list/dropdown_button.dart';
import 'package:readme_editor/widgets/shield_list/shield_list_item.dart';
import 'package:readme_editor/widgets/shield_list/topnavbar.dart';

class SingleReadMe extends StatefulWidget {
  SingleReadMe({
    @required this.documentId,
    @required this.title,
    @required this.username,
  });
  final String documentId;
  final String title;
  final String username;

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

  Future<void> _addToFavourites(ShieldModel shield) async {
    if (shield.favourite) return null;
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users/${user.uid}/favouriteShield')
        .add({
      'shield-code': shield.code,
      'create-at': Timestamp.now(),
    });

    setState(() {
      shield.favourite = true;
    });
  }

  Future<void> _removeFromFavourites(ShieldModel shield) async {
    if (!shield.favourite) return null;

    final user = FirebaseAuth.instance.currentUser;
    final shieldData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('readme')
        .where('shield-code', isEqualTo: shield.code)
        .get();
    if (shieldData.docs.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('readme')
          .doc(shieldData.docs.first.id)
          .delete();
    }
    setState(() {
      shield.favourite = false;
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
          ReadMeDropdownButton(
            username: widget.username,
            repo: widget.title,
          )
        ],
      ),
      body: Column(
        children: [
          TopNavBar(_currentCategory, _changeCategory),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: shields.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ShieldListItem(
                          shield: shields[index],
                          repo: widget.title,
                          username: widget.username,
                          addToFavourites: _addToFavourites,
                          removeFromFavourites: _removeFromFavourites)),
            ),
          )
        ],
      ),
    );
  }
}
