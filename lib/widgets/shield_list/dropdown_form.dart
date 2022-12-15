import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:readme_editor/models/shield.dart';
import 'package:readme_editor/provider/shield.dart';
import 'package:readme_editor/src/shield/colors.dart';
import 'package:readme_editor/src/shield/styles.dart';
import 'package:select_form_field/select_form_field.dart';

class DropdownForm extends StatefulWidget {
  DropdownForm({
    @required this.shield,
    @required this.username,
    @required this.repo,
    this.isStatic = false,
  });
  final bool isStatic;
  final String username;
  final String repo;
  final ShieldModel shield;
  @override
  _DropdownFormState createState() => _DropdownFormState();
}

class _DropdownFormState extends State<DropdownForm> {
  Color _logoFormColor = Colors.black;
  String _logoHelperText = '';

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
    if (widget.isStatic) {
      widget.shield.color = ShieldColor.values[0];
      widget.shield.style = ShieldStyle.values[0];
    }
  }

  bool get _showImg {
    if (widget.shield.args.length == 0) return true;
    if (_args.keys.length - 2 <
        widget.shield.args.where((arg) => !arg.endsWith('*')).length)
      return false;
    for (String element in _args.values) {
      if (!element.endsWith('*')) {
        if (element == null) return false;
        if (element.isEmpty) return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Create your Badges"),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    for (String arg in widget.shield.args)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              arg.replaceAll(RegExp(r'\*$'), ' (optional)'),
                          icon: Icon(Icons.text_fields),
                        ),
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {
                          setState(() {
                            _args[arg] = val;
                          });
                        },
                      ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Logo (optional)',
                        helperText: _logoHelperText,
                        icon: Icon(
                          Icons.donut_small_sharp,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      style: TextStyle(color: _logoFormColor),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        var icons =
                            Provider.of<Shields>(context, listen: false).icons;
                        var icon = icons.firstWhere(
                          (icon) =>
                              icon.name.toLowerCase() == val.toLowerCase(),
                          orElse: () {
                            var hintLogo = icons.firstWhere((element) =>
                                element.name.toLowerCase().startsWith(val));
                            setState(() {
                              _logoFormColor = Colors.red;
                              if (hintLogo != null)
                                _logoHelperText = hintLogo.name;
                            });
                            return null;
                          },
                        );
                        if (icon != null)
                          setState(() {
                            widget.shield.icon = icon;
                            _logoFormColor = Colors.black;
                            _logoHelperText = '';
                          });
                      },
                    ),
                    if (widget.shield.icon != null)
                      SelectFormField(
                        type: SelectFormFieldType.dropdown,
                        icon: Icon(
                          Icons.color_lens_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        labelText: 'Logo Color (optional)',
                        items: _colorsValue,
                        onChanged: (val) {
                          setState(() {
                            widget.shield.icon.color = ShieldColor.values
                                .firstWhere((color) => color.name == val);
                          });
                        },
                      ),
                    SelectFormField(
                      type: SelectFormFieldType.dropdown,
                      initialValue:
                          widget.isStatic ? ShieldColor.values[0].name : null,
                      icon: Icon(
                        Icons.color_lens_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      labelText: widget.isStatic ? 'Color' : 'Color (optional)',
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
                        Icons.color_lens_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      labelText: 'Title Color (optional)',
                      items: _colorsValue,
                      onChanged: (val) {
                        setState(() {
                          widget.shield.titlecolor = ShieldColor.values
                              .firstWhere((color) => color.name == val);
                        });
                      },
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
                          Clipboard.setData(ClipboardData(
                              text: widget.shield
                                  .markdown(_args, isStatic: widget.isStatic)));

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Shield copied to clipboard"),
                            backgroundColor: Colors.green,
                          ));
                        },
                        child: FadeInImage(
                          fit: BoxFit.contain,
                          height: 30,
                          placeholder: AssetImage('assets/img/shield.png'),
                          image: NetworkImage(
                            widget.isStatic
                                ? widget.shield
                                    .staticShieldLink(_args)
                                    .replaceFirst('img.', 'raster.')
                                : widget.shield
                                    .mdLink(_args)
                                    .replaceFirst('img.', 'raster.'),
                          ),
                        ),
                      ),
                    if (!_showImg)
                      Image.asset(
                        'assets/img/shield.png',
                        height: 30,
                      ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
