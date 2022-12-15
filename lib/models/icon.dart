import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readme_editor/src/shield/colors.dart';

class BadgeIconModel {
  String name;
  String slug;
  ShieldColor color;

  BadgeIconModel({
    @required this.name,
    @required this.slug,
    this.color,
  });

  Widget get svg => SvgPicture.network(
        'https://simpleicons.org/icons/${this.slug}.svg',
      );
}
