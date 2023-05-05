import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readme_editor/models/shield.dart';
import 'package:readme_editor/src/shield/category.dart';
import 'package:readme_editor/widgets/shield_list/newshield_form.dart';

class ShieldListItem extends StatelessWidget {
  ShieldListItem({
    @required this.shield,
    @required this.username,
    @required this.repo,
    @required this.createShield,
  });

  final String username;
  final String repo;
  final ShieldModel shield;
  final Function createShield;

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
          child: NewShieldForm(
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ListTile(
        onTap: shield.category == ShieldCategory.badge
            ? () {
                Clipboard.setData(
                    ClipboardData(text: shield.markdown({}, isStatic: false)));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text("Badge copied to clipboard"),
                  backgroundColor: Colors.green,
                ));
              }
            : () => createShield(context, shield),
        title: Text(shield.name),
        subtitle: Container(
          margin: const EdgeInsets.only(top: 8),
          height: 25,
          child: FadeInImage(
            fit: BoxFit.contain,
            placeholder: const AssetImage('assets/img/shield.png'),
            image: NetworkImage(
              shield.previewImgUrl,
            ),
          ),
        ),
      ),
    );
  }
}
