import 'package:flutter/material.dart';
import 'package:readme_editor/src/shield/colors.dart';
import 'package:readme_editor/src/shield/shield.dart';
import 'package:readme_editor/src/shield/styles.dart';
import 'package:select_form_field/select_form_field.dart';

// TODO: fix style img
// TODO: add other shields

class DropdownForm extends StatefulWidget {
  DropdownForm(this.shieldType, this.addShield);

  final void Function({
    String lable,
    String message,
    String packageName,
    String color,
    @required String style,
    @required ShieldType shieldType,
  }) addShield;
  final ShieldType shieldType;

  @override
  _DropdownFormState createState() => _DropdownFormState();
}

class _DropdownFormState extends State<DropdownForm> {
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

  final _formKey = GlobalKey<FormState>();
  String _color = '';
  String _style = '';
  String _lable = '';
  String _message = '';
  String _packageName = '';

  void _createNewShield(BuildContext context) async {
    print("NEW SHIELD");
    if (widget.shieldType == ShieldType.static) {
      widget.addShield(
        color: _color,
        message: _message,
        lable: _lable,
        style: _style,
        shieldType: widget.shieldType,
      );
    }

    Navigator.of(context).pop();
  }

  //TODO: fix pixel owerflow when display error message
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
              key: _formKey,
              child: Column(
                children: [
                  if (this.widget.shieldType == ShieldType.static)
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'lable',
                        prefixIcon: Icon(Icons.title),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a lable';
                        }
                        return null;
                      },
                      onSaved: (val) => _lable = val,
                      textInputAction: TextInputAction.next,
                    ),
                  if (this.widget.shieldType == ShieldType.static)
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'message',
                        prefixIcon: Icon(Icons.textsms_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (val) => _message = val,
                    ),
                  // SelectFormField(
                  //   type: SelectFormFieldType.dropdown,
                  //   initialValue: ShieldColor.values[0].name,
                  //   icon: Icon(
                  //     Icons.color_lens_outlined,
                  //     color: Theme.of(context).primaryColor,
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please select a color';
                  //     }
                  //     return null;
                  //   },
                  //   labelText: 'Color',
                  //   items: _colorsValue,
                  //   onSaved: (val) => _color = val,
                  // ),
                  SelectFormField(
                    type: SelectFormFieldType.dropdown,
                    initialValue: ShieldStyle.values[0].name,
                    icon: Icon(
                      Icons.style_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a style';
                      }
                      return null;
                    },
                    labelText: 'Style',
                    items: _styleValue,
                    onSaved: (val) => _style = val,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        _createNewShield(context);
                      }
                    },
                    child: Text("Add"),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
