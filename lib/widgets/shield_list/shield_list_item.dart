import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readme_editor/models/shield.dart';
import 'package:readme_editor/src/shield/category.dart';
import 'package:readme_editor/widgets/shield_list/dropdown_form.dart';

class ShieldListItem extends StatelessWidget {
  ShieldListItem({
    @required this.shield,
    @required this.username,
    @required this.repo,
    @required this.addToFavourites,
    @required this.removeFromFavourites,
  });

  final String username;
  final String repo;
  final ShieldModel shield;
  final Future<void> Function(ShieldModel shield) addToFavourites;
  final Future<void> Function(ShieldModel shield) removeFromFavourites;

  void _createShield(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: const Radius.circular(45.0),
          topRight: const Radius.circular(45.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (_) => GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          child: DropdownForm(
            shield: shield,
            username: username,
            repo: repo,
          ),
        ),
      ),
    );
  }

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
        onTap: shield.category == ShieldCategory.badge
            ? () {
                Clipboard.setData(
                    ClipboardData(text: shield.markdown({}, isStatic: false)));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Badge copied to clipboard"),
                  backgroundColor: Colors.green,
                ));
              }
            : () => _createShield(context),
        title: Text(shield.name),
        trailing: IconButton(
            icon: Icon(
                shield.favourite ? Icons.star : Icons.star_border_outlined),
            onPressed: () {
              if (shield.favourite) {
                removeFromFavourites(shield);
              } else {
                addToFavourites(shield);
              }
            }),
        subtitle: Container(
          margin: EdgeInsets.only(top: 8),
          height: 25,
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
