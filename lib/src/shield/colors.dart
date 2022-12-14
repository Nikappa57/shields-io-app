import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ShieldColor {
  brightgreen,
  green,
  yellowgreen,
  yellow,
  orange,
  red,
  blue,
  lightgrey,
  success,
  important,
  critical,
  informational,
  inactive,
  blueviolet,
  pink,
  lightblue,
}

extension ColorExtension on ShieldColor {
  String get name => describeEnum(this);
  Color get color {
    switch (this) {
      case ShieldColor.brightgreen:
        return const Color(0xff4AC41C);
      case ShieldColor.green:
        return const Color(0xff95C20D);
      case ShieldColor.yellowgreen:
        return const Color(0xffA2A429);
      case ShieldColor.yellow:
        return const Color(0xffD6AF23);
      case ShieldColor.orange:
        return const Color(0xffF37F40);
      case ShieldColor.red:
        return const Color(0xffD9644D);
      case ShieldColor.blue:
        return const Color(0xff0F80C1);
      case ShieldColor.lightgrey:
        return const Color(0xff9E9E9E);
      case ShieldColor.success:
        return const Color(0xff4DC71F);
      case ShieldColor.important:
        return const Color(0xffF37F40);
      case ShieldColor.critical:
        return const Color(0xffD9644D);
      case ShieldColor.informational:
        return const Color(0xff1081C2);
      case ShieldColor.inactive:
        return const Color(0xffA0A0A0);
      case ShieldColor.blueviolet:
        return const Color(0xff8A35D9);
      case ShieldColor.pink:
        return const Color(0xffF46DB1);
      case ShieldColor.lightblue:
        return const Color(0xff98C6F4);
      default:
        return const Color(0xff000000);
    }
  }
}
