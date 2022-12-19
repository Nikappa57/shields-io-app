import 'package:flutter/material.dart';
import 'package:readme_editor/models/shield.dart';
import 'package:readme_editor/widgets/shield_list/dropdown_form.dart';

class ReadMeDropdownButton extends StatelessWidget {
  ReadMeDropdownButton({
    @required this.username,
    @required this.repo,
    @required this.changeSearchBar,
  });

  final String username;
  final String repo;
  final void Function() changeSearchBar;

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
      isScrollControlled: true,
      builder: (_) => GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
            child: DropdownForm(
          shield: staitcShield,
          username: username,
          repo: repo,
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
        } else if (item == 'search') {
          changeSearchBar();
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
        DropdownMenuItem(
          child: Container(
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text("Search"),
              ],
            ),
          ),
          value: 'search',
        ),
      ],
    );
  }
}
