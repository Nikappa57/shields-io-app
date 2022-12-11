import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readme_editor/models/shield.dart';
import 'package:readme_editor/src/shield/colors.dart';
import 'package:readme_editor/src/shield/styles.dart';
import 'package:select_form_field/select_form_field.dart';

class DropdownForm extends StatefulWidget {
  DropdownForm({
    @required this.shield,
    @required this.username,
    @required this.repo,
  });
  final String username;
  final String repo;
  final ShieldModel shield;
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
          margin: EdgeInsets.only(right: 8),
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
          margin: EdgeInsets.only(right: 8),
          alignment: Alignment.bottomCenter,
          child: style.style,
          color: Colors.transparent,
          height: 20,
          width: 100,
        ),
      }
  }.toList();

  final _formKey = GlobalKey<FormState>();
  Map<String, String> _args;

  @override
  void initState() {
    super.initState();
    _args = {
      'user': widget.username,
      'repo': widget.repo,
    };
  }

  bool get _showImg {
    if (widget.shield.args.length == 0) return true;
    if (_args.keys.length - 2 >=
        widget.shield.args.where((arg) => !arg.endsWith('*')).length)
      return false;
    _args.values.forEach((element) {
      if (!element.endsWith('*')) {
        if (element == null) return false;
        if (element.isEmpty) return false;
      }
    });

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 12,
      ),
      child: Column(
        children: [
          Text("Create your Badges"),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  for (String arg in widget.shield.args)
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: arg,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'data required';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        setState(() {
                          _args[arg] = val;
                        });
                      },
                    ),
                  SelectFormField(
                    type: SelectFormFieldType.dropdown,
                    icon: Icon(
                      Icons.color_lens_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a color';
                      }
                      return null;
                    },
                    labelText: 'Color',
                    items: _colorsValue,
                    onChanged: (val) {
                      setState(() {
                        widget.shield.color = ShieldColor.values
                            .firstWhere((color) => color.name == val);
                      });
                    },
                  ),
                  SelectFormField(
                    type: SelectFormFieldType.dropdown,
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
                    onChanged: (val) {
                      setState(() {
                        widget.shield.style = ShieldStyle.values
                            .firstWhere((style) => style.name == val);
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  if (_showImg)
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Clipboard.setData(
                            ClipboardData(text: widget.shield.markdown(_args)));

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Shield copied to clipboard"),
                          backgroundColor: Colors.green,
                        ));
                        print("COPY: ${widget.shield.markdown(_args)}");
                      },
                      child: FadeInImage(
                        fit: BoxFit.contain,
                        placeholder: AssetImage('assets/img/shield.png'),
                        image: NetworkImage(
                          widget.shield
                              .mdLink(_args)
                              .replaceFirst('img.', 'raster.'),
                        ),
                      ),
                    ),
                  if (!_showImg) Image.asset('assets/img/shield.png'),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState.validate()) {
                  //       _formKey.currentState.save();
                  //       _copyShield(context);
                  //     }
                  //   },
                  //   child: Text("Add"),
                  // ),
                ],
              )),
        ],
      ),
    );
  }
}
