import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingleReadMe extends StatefulWidget {
  SingleReadMe(this.documentId);
  final String documentId;
  @override
  State<SingleReadMe> createState() => _SingleReadMeState();
}

class _SingleReadMeState extends State<SingleReadMe> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> future) {
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
                  .document(widget.documentId)
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

                final readme = snapshot.data;
                return Scaffold(
                  appBar: AppBar(
                    title: Text(readme['project-name']),
                  ),
                );
              });
        });
  }
}
