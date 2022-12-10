import 'package:flutter/foundation.dart';
import 'package:readme_editor/src/shield/category.dart';
import 'package:readme_editor/src/shield/colors.dart';
import 'package:readme_editor/src/shield/shield.dart';
import 'package:readme_editor/src/shield/styles.dart';

class ShieldModel {
  String name;
  String lable; // only for static shield
  String text; // only for static shield
  ShieldType type;
  ShieldStyle style;
  ShieldColor color;
  ShieldCategory category;
  String code;
  String previewImgUrl;

  ShieldModel({
    @required this.name,
    this.lable,
    this.text,
    @required this.code,
    @required this.type,
    this.style,
    this.color,
    @required this.category,
    @required this.previewImgUrl,
  });
}
