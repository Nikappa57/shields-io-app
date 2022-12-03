import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readme_editor/widgets/readme/readme_item_list.dart';

// TODO: pik existing project and add to db
// TODO: possibility to commit readme
// TODO: add diff check

// TODO: show only user readme and add to firebase perms that

class ReadMeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext ctx, AsyncSnapshot<dynamic> future) {
          if (future.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 30,
                width: 30,
              ),
            );
          }
          return StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document(future.data.uid)
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
                final files = snapshot.data.documents;
                return ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      return ReadMeItemList(
                        files[index].documentID,
                        files[index]['project-name'],
                      );
                    });
              });
        });
  }
}
