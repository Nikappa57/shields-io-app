import 'package:flutter/material.dart';

class ReadMeDropdownButton extends StatelessWidget {
  ReadMeDropdownButton({
    @required this.username,
    @required this.repo,
    @required this.changeSearchBar,
  });

  final String username;
  final String repo;
  final void Function() changeSearchBar;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: Container(),
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).primaryIconTheme.color,
      ),
      onChanged: (item) {
        if (item == 'search') {
          changeSearchBar();
        }
      },
      items: [
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
