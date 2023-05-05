import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readme_editor/models/shield.dart';
import 'package:readme_editor/provider/shield.dart';
import 'package:readme_editor/src/shield/category.dart';
import 'package:readme_editor/widgets/shield_list/dropdown_button.dart';
import 'package:readme_editor/widgets/shield_list/dropdown_form.dart';
import 'package:readme_editor/widgets/shield_list/search_form.dart';
import 'package:readme_editor/widgets/shield_list/shield_list_item.dart';
import 'package:readme_editor/widgets/shield_list/topnavbar.dart';

class SingleReadMe extends StatefulWidget {
  SingleReadMe({
    @required this.repo,
    @required this.username,
  });
  final String repo;
  final String username;

  @override
  State<SingleReadMe> createState() => _SingleReadMeState();
}

class _SingleReadMeState extends State<SingleReadMe> {
  ShieldCategory _currentCategory = ShieldCategory.values[0];
  bool _showSearchBar = false;
  String _searchText = '';

  void _changeCategory(ShieldCategory category) {
    if (category != _currentCategory)
      setState(() {
        _currentCategory = category;
      });
  }

  void _changeSearchBar() {
    setState(() {
      _showSearchBar = !_showSearchBar;
      _searchText = '';
    });
  }

  void _onSearching(String text) {
    setState(() {
      _searchText = text;
    });
  }

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
          username: widget.username,
          repo: widget.repo,
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ShieldModel> shields = Provider.of<Shields>(context).shields;
    print(shields);
    if (!(_currentCategory == ShieldCategory.All))
      shields = shields
          .where((element) => element.category == _currentCategory)
          .toList();
    if (widget.repo == 'Shields')
      shields = shields
          .where((element) => !element.isGithubShield)
          .toList(); // remove github shields
    if (_showSearchBar)
      shields = shields
          .where((shield) =>
              shield.name.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.repo),
        actions: [
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              onPressed: _changeSearchBar),
        ],
      ),
      body: Column(
        children: [
          TopNavBar(_currentCategory, _changeCategory),
          if (_showSearchBar) ShearchForm(_changeSearchBar, _onSearching),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: shields.length,
                itemBuilder: (BuildContext context, int index) =>
                    ShieldListItem(
                  shield: shields[index],
                  repo: widget.repo,
                  username: widget.username,
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createShield(context);
        },
        child: Icon(Icons.badge),
      ),
    );
  }
}
