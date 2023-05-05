import 'package:flutter/material.dart';
import 'package:readme_editor/src/shield/category.dart';

class TopNavBar extends StatelessWidget {
  TopNavBar(this.currentCategory, this.changeCategory);
  final ShieldCategory currentCategory;

  final void Function(ShieldCategory category) changeCategory;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 53,
        child: Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: ShieldCategory.values.length - 1, // - 1 for static
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () => changeCategory(ShieldCategory.values[index]),
              child: Card(
                elevation: 3,
                color: ShieldCategory.values[index] == ShieldCategory.All
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
        ),
      ),
    );
  }
}
