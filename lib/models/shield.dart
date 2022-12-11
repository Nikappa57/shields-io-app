import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:readme_editor/src/shield/category.dart';
import 'package:readme_editor/src/shield/colors.dart';
import 'package:readme_editor/src/shield/styles.dart';

class ShieldModel {
  String name;
  String code;
  ShieldStyle style;
  ShieldColor color;
  ShieldCategory category;
  String previewImgUrl;
  bool favourite;

  ShieldModel({
    @required this.name,
    @required this.code,
    this.style,
    this.color,
    @required this.category,
    @required this.previewImgUrl,
    @required this.favourite,
  });

  String staticShieldLink(Map<String, String> shieldArgs) {
    String _link =
        "https://img.shields.io/badge/${shieldArgs["title"]}-${shieldArgs["text"]}-${this.color.name}";
    if (this.style != null) _link += '?style=${this.style.name}';
    return _link;
  }

  List<String> get args {
    final arg = RegExp(r':([a-zA-Z]+\*?)');
    return arg
        .allMatches(this.code)
        .map((m) => m.group(1))
        .where((element) =>
            element != 'user' && element != 'repo' && element != 'color')
        .toList();
  }

  String mdLink(Map<String, String> shieldArgs) {
    String _linkSuffix = this.code;
    shieldArgs.keys.forEach((key) {
      _linkSuffix = _linkSuffix.replaceAll(":$key", shieldArgs[key]);
    });
    String _link = 'https://img.shields.io$_linkSuffix';
    if (this.color != null || this.style != null) {
      if (this.style != null) {
        _link += '?style=${this.style.name}'; // add style
      } else if (this.color != null) {
        return _link + '?color=${this.color.name}'; // only color
      }
      if (this.color != null) {
        return _link + '&color=${this.color.name}'; // style and color
      } else {
        return _link; // only style
      }
    } else {
      return _link; // no style or color
    }
  }

  String markdown(Map<String, String> shieldArgs, {bool isStatic = false}) {
    final String _link =
        isStatic ? staticShieldLink(shieldArgs) : mdLink(shieldArgs);
    return '![${this.name}]($_link)';
  }
}

ShieldModel staitcShield = ShieldModel(
  name: 'static',
  code: '/badge/:title-:text-:color',
  category: ShieldCategory.static,
  previewImgUrl: 'https://raster.shields.io/badge/title-text-red',
  favourite: false,
);
