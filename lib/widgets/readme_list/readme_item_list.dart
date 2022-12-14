import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readme_editor/screens/single_readme.dart';
import 'package:readme_editor/widgets/readme_list/new_readme.dart';

class ReadMeItemList extends StatelessWidget {
  ReadMeItemList({
    @required this.documentId,
    @required this.title,
    @required this.userId,
    @required this.username,
  });

  final String documentId;
  final String title;
  final String userId;
  final String username;

  void _deleteReadme(DismissDirection d) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('readme')
        .doc(documentId)
        .delete();
  }

  void _editReadMe({
    @required BuildContext context,
    @required String title,
    @required String documentId,
    @required String user,
  }) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: const Radius.circular(45.0),
          topRight: const Radius.circular(45.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (_) => GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
            child: NewReadMe(
          user: user,
          title: title,
          documentId: documentId,
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(documentId),
      direction: DismissDirection.endToStart,
      background: Container(
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.centerRight,
      ),
      onDismissed: _deleteReadme,
      confirmDismiss: (direction) async {
        bool _confirm = false;
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Delete"),
              content: const Text("Do you want to delete the readme?"),
              actions: [
                TextButton(
                  child: const Text("Yes"),
                  onPressed: () {
                    _confirm = true;
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return _confirm;
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleReadMe(
                documentId: documentId,
                title: title,
                username: username,
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).accentTextTheme.headline1.color,
            ),
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).accentIconTheme.color,
              ),
              onPressed: () => _editReadMe(
                    context: context,
                    title: title,
                    documentId: documentId,
                    user: username,
                  )),
        ),
      ),
    );
  }
}
