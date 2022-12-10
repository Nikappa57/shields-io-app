import 'package:flutter/material.dart';
import 'package:readme_editor/models/shield.dart';

class ShieldListItem extends StatelessWidget {
  ShieldListItem(this.shield);

  final ShieldModel shield;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ListTile(
        title: Text(shield.name),
        subtitle: Container(
          margin: EdgeInsets.only(top: 8),
          height: 20,
          child: FadeInImage(
            fit: BoxFit.contain,
            placeholder: AssetImage('assets/img/shield.png'),
            image: NetworkImage(
              shield.previewImgUrl,
            ),
          ),
        ),
      ),
    );
  }
}
