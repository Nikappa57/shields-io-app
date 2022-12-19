import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readme_editor/widgets/readme_list/no_repo_item.dart';
import 'package:readme_editor/widgets/readme_list/readme_item_list.dart';

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
          final List files = snapshot.data.docs;
          files.insert(0, files.removeLast());
          return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                String title = files[index].data()['project-name'];
                return title == 'start'
                    ? NoRepoItemList(
                        documentId: files[index].id,
                        userId: user.uid,
                        username: files[index].data()['user'])
                    : ReadMeItemList(
                        documentId: files[index].id,
                        title: title,
                        userId: user.uid,
                        username: files[index].data()['user'],
                      );
              });
        });
  }
}
