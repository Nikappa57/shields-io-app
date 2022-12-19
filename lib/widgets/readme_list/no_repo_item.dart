import 'package:flutter/material.dart';
import 'package:readme_editor/screens/single_readme.dart';

class NoRepoItemList extends StatelessWidget {
  NoRepoItemList({
    @required this.documentId,
    @required this.userId,
    @required this.username,
  });

  final String documentId;
  final String userId;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
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
              title: 'Shields',
              username: username,
            ),
          ),
        ),
        title: Text(
          'Github-less',
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.headline6.color,
          ),
        ),
        subtitle: Text(
          'create your Shields without having a github repo',
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.headline1.color,
          ),
        ),
      ),
    );
  }
}
