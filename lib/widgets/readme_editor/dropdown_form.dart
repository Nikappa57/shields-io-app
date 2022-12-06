import 'package:flutter/material.dart';
import 'package:readme_editor/src/shield/colors.dart';
import 'package:readme_editor/src/shield/shield.dart';
import 'package:readme_editor/src/shield/styles.dart';
import 'package:select_form_field/select_form_field.dart';

// TODO: fix style img
// TODO: add other shields
// TODO: paste markdwon in editor

class DropdownForm extends StatelessWidget {
  DropdownForm(this.shieldType);

  final ShieldType shieldType;

  final List<Map<String, dynamic>> _colorsValue = {
    for (var color in ShieldColor.values)
      {
        'value': color.name,
        'label': color.name,
        'icon': Container(
          color: color.color,
          height: 10,
          width: 10,
        ),
      }
  }.toList();

  final List<Map<String, dynamic>> _styleValue = {
    for (var style in ShieldStyle.values)
      {
        'value': style.name,
        'label': style.name,
        'icon': Container(
          alignment: Alignment.bottomCenter,
          child: style.style,
          color: Colors.transparent,
          height: 20,
          width: 100,
        ),
      }
  }.toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25,
        right: 12,
        left: 12,
      ),
      child: Column(
        children: [
          Text("Create your Badges"),
          Form(
              child: Column(
            children: [
              if (this.shieldType == ShieldType.static)
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'lable',
                    prefixIcon: Icon(Icons.title),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              if (this.shieldType == ShieldType.static)
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'message',
                    prefixIcon: Icon(Icons.textsms_outlined),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              SelectFormField(
                type: SelectFormFieldType.dropdown,
                initialValue: ShieldColor.values[0].name,
                icon: Icon(
                  Icons.color_lens_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                labelText: 'Color',
                items: _colorsValue,
                onChanged: (val) => print(val),
                onSaved: (val) => print(val),
              ),
              SelectFormField(
                type: SelectFormFieldType.dropdown,
                initialValue: ShieldStyle.values[0].name,
                icon: Icon(
                  Icons.style_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                labelText: 'Style',
                items: _styleValue,
                onChanged: (val) => print(val),
                onSaved: (val) => print(val),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    // TODO
                    Navigator.of(context).pop();
                  },
                  child: Text("Add"))
            ],
          )),
        ],
      ),
    );
  }
}
