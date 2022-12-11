import 'package:flutter/material.dart';

class ShearchForm extends StatelessWidget {
  ShearchForm(this.closeSearchBar, this.onSearching);
  final void Function() closeSearchBar;
  final void Function(String text) onSearching;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                icon: Icon(Icons.search),
              ),
              onChanged: onSearching,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: closeSearchBar,
          )
        ],
      ),
    );
  }
}
