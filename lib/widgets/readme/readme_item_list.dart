import 'package:flutter/material.dart';

class ReadMeItemList extends StatelessWidget {
  ReadMeItemList(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).accentTextTheme.headline1.color,
          ),
        ),
      ),
    );
  }
}
