import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum ShieldStyle {
  plastic,
  flat,
  flatSquare,
  forTheBadge,
  social,
}

extension ColorExtension on ShieldStyle {
  String get name {
    switch (this) {
      case ShieldStyle.plastic:
        return "plastic";
      case ShieldStyle.flat:
        return "flat";
      case ShieldStyle.flatSquare:
        return "flat-square";
      case ShieldStyle.forTheBadge:
        return "for-the-badge";
      case ShieldStyle.social:
        return "social";
      default:
        return "";
    }
  }

  Widget get style {
    switch (this) {
      case ShieldStyle.plastic:
        return WebView(
            initialUrl:
                "https://img.shields.io/badge/style-plastic-green?logo=appveyor&style=plastic");
      case ShieldStyle.flat:
        return WebView(
            initialUrl:
                "https://img.shields.io/badge/style-flat-green?logo=appveyor&style=flat");
      case ShieldStyle.flatSquare:
        return WebView(
            initialUrl:
                "https://img.shields.io/badge/style-flat--square-green?logo=appveyor&style=flat-square");
      case ShieldStyle.forTheBadge:
        return WebView(
            initialUrl:
                "https://img.shields.io/badge/style-for--the--badge-green?logo=appveyor&style=for-the-badge");
      case ShieldStyle.social:
        return WebView(
            initialUrl:
                "https://img.shields.io/badge/style-social-green?logo=appveyor&style=social");
      default:
        return Icon(Icons.style_outlined);
    }
  }
}
