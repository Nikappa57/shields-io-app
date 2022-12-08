import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readme_editor/widgets/readme_list/readme_item_list.dart';

// TODO: pik existing project and add to db
// TODO: possibility to commit readme
// TODO: add diff check

// TODO: show only user readme and add to firebase perms that

class ReadMeList extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('readme')
            .orderBy('create-at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 30,
                width: 30,
              ),
            );
          }
          final files = snapshot.data.docs;
          return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                return ReadMeItemList(
                  files[index].id,
                  files[index].data()['project-name'],
                  files[index].data()['text'],
                  user.uid,
                );
              });
        });
  }
}
