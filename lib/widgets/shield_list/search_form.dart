import 'package:flutter/material.dart';

class ShearchForm extends StatelessWidget {
  ShearchForm(this.closeSearchBar, this.onSearching);
  final void Function() closeSearchBar;
  final void Function(String text) onSearching;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1200,
      height: 50,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                icon: const Icon(Icons.search),
              ),
              autofocus: true,
              onChanged: onSearching,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: closeSearchBar,
          )
        ],
      ),
    );
  }
}
