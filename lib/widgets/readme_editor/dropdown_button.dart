import 'package:flutter/material.dart';
import 'package:readme_editor/src/shield/shield.dart';
import 'package:readme_editor/widgets/readme_editor/dropdown_form.dart';

class ReadMeDropdownButton extends StatelessWidget {
  ReadMeDropdownButton(this.addShield);
  final void Function({
    String lable,
    String message,
    String packageName,
    String color,
    @required String style,
    @required ShieldType shieldType,
  }) addShield;

  void _createShield(
    BuildContext context,
    ShieldType shieldType,
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
        child:
            SingleChildScrollView(child: DropdownForm(shieldType, addShield)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: Container(),
      icon: Icon(
        Icons.shield,
        color: Theme.of(context).primaryIconTheme.color,
      ),
      onChanged: (item) {
        if (item == 'static') {
          _createShield(context, ShieldType.static);
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
                  Icons.star,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text("Most used Shields"),
              ],
            ),
          ),
          value: 'used',
        ),
      ],
    );
  }
}
