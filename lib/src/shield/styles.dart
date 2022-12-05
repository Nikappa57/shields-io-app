import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        return null;
    }
  }
}
