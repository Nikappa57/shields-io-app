import 'package:flutter/foundation.dart';
import 'package:readme_editor/models/icon.dart';
import 'package:readme_editor/src/shield/category.dart';
import 'package:readme_editor/src/shield/colors.dart';
import 'package:readme_editor/src/shield/styles.dart';

class ShieldModel {
  String name;
  String code;
  ShieldStyle style;
  ShieldColor color;
  ShieldColor titlecolor;
  BadgeIconModel icon;
  ShieldCategory category;
  String previewImgUrl;
  bool favourite;

  ShieldModel({
    @required this.name,
    @required this.code,
    this.style,
    this.color,
    this.titlecolor,
    @required this.category,
    @required this.previewImgUrl,
    @required this.favourite,
  });

  String staticShieldLink(Map<String, String> shieldArgs) {
    String _link = 'https://img.shields.io/badge/';
    if (shieldArgs["title"] != null) _link += '${shieldArgs["title"]}-';
    _link +=
        '${shieldArgs["text"]}-${this.color.name}?style=${this.style.name}';
    if (this.icon != null) _link += '&logo=${this.icon.slug}';
    if (this.icon != null && this.icon.color != null)
      _link += '&logoColor=${this.icon.color.name}';
    if (this.titlecolor != null) _link += '&labelColor=${this.titlecolor.name}';

    return _link;
  }

  List<String> get args {
    final argPattern = RegExp(r':([a-zA-Z]+[\*\?\+]?)');
    return argPattern.allMatches(this.code).map((m) => m.group(1)).toList();
  }

  List<String> get optionalArgs {
    final argPattern = RegExp(r':([a-zA-Z]+[\*\?])');
    return argPattern.allMatches(this.code).map((m) => m.group(1)).toList();
  }

  String mdLink(Map<String, String> shieldArgs) {
    String _linkSuffix = this.code;
    shieldArgs.keys.forEach((key) {
      _linkSuffix = _linkSuffix.replaceAll(":$key", shieldArgs[key]);
    });

    this.optionalArgs.forEach((arg) {
      if (!shieldArgs.containsKey(arg))
        _linkSuffix = _linkSuffix.replaceAll(":$arg", '');
    });

    String _link = 'https://img.shields.io$_linkSuffix';
    _link += _link.contains('?') ? '&' : '?';
    _link += 'style=${this.style.name}';
    if (this.color != null) _link += '&color=${this.color.name}';
    if (this.titlecolor != null) _link += '&labelColor=${this.titlecolor.name}';
    if (this.icon != null) _link += '&logo=${this.icon.name}';
    if (this.icon != null && this.icon.color != null)
      _link += '&logoColor=${this.icon.color.name}';

    return _link;
  }

  String markdown(Map<String, String> shieldArgs, {bool isStatic = false}) {
    final String _link =
        isStatic ? staticShieldLink(shieldArgs) : mdLink(shieldArgs);
    return '![${this.name}]($_link)';
  }

  bool get isGithubShield {
    if (this.code.startsWith('/github/')) return true;
    if ((this.code.toLowerCase().contains('github') ||
            this.name.toLowerCase().contains('github')) &&
        (this.args.contains('user') || this.args.contains('repo'))) return true;
    return false;
  }
}

ShieldModel staitcShield = ShieldModel(
  name: 'static',
  code: '/badge/:title*-:text-:color',
  category: ShieldCategory.static,
  previewImgUrl: 'https://raster.shields.io/badge/title-text-red',
  favourite: false,
);
