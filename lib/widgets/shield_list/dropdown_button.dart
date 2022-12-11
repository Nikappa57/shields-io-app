import 'package:flutter/material.dart';
import 'package:readme_editor/models/shield.dart';
import 'package:readme_editor/widgets/shield_list/dropdown_form.dart';

class ReadMeDropdownButton extends StatelessWidget {
  ReadMeDropdownButton({
    @required this.username,
    @required this.repo,
  });

  final String username;
  final String repo;

  void _createShield(
    BuildContext context,
  ) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: const Radius.circular(45.0),
          topRight: const Radius.circular(45.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (_) => GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
            child: DropdownForm(
          shield: staitcShield,
          username: username,
          repo: repo,
          isStatic: true,
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: Container(),
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).primaryIconTheme.color,
      ),
      onChanged: (item) {
        if (item == 'static') {
          _createShield(context);
        }
      },
      items: [
        DropdownMenuItem(
          child: Container(
            child: Row(
              children: [
                Icon(
                  Icons.source_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text("Static Shield"),
              ],
            ),
          ),
          value: 'static',
        ),
      ],
    );
  }
}
