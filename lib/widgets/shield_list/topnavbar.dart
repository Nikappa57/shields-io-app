import 'package:flutter/material.dart';
import 'package:readme_editor/src/shield/category.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(ShieldCategory.values.length, (int index) {
          return Card(
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
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ShieldCategory.values[index].name,
                    style: TextStyle(
                        color:
                            Theme.of(context).accentTextTheme.headline1.color),
                  ),
                ],
              )),
            ),
          );
        }),
      ),
    );
  }
}
