import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// TODO: pik existing project and add to db
// TODO: possibility to commit readme

class ReadMeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('files')
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
        print("files:");
        print(files);
        return ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) => Text(files[index]['project-name']),
        );
      },
    );
  }
}
