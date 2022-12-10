import 'package:flutter/material.dart';
import 'package:readme_editor/src/shield/category.dart';

class TopNavBar extends StatelessWidget {
  TopNavBar(this.currentCategory, this.changeCategory);
  final ShieldCategory currentCategory;

  final void Function(ShieldCategory category) changeCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        itemCount: ShieldCategory.values.length,
        itemBuilder: (BuildContext context, int index) => InkWell(
          onTap: () => changeCategory(ShieldCategory.values[index]),
          child: Card(
            elevation: 3,
            color: Theme.of(context).accentColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    ShieldCategory.values[index].icon,
                    color: Theme.of(context).accentIconTheme.color,
                  ),
                  if (ShieldCategory.values[index] == currentCategory)
                    SizedBox(
                      width: 10,
                    ),
                  if (ShieldCategory.values[index] == currentCategory)
                    Text(
                      ShieldCategory.values[index].name,
                      style: TextStyle(
                          color: Theme.of(context)
                              .accentTextTheme
                              .headline1
                              .color),
                    ),
                ],
              )),
            ),
          ),
        ),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
