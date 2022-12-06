import 'package:readme_editor/src/shield/colors.dart';
import 'package:readme_editor/src/shield/styles.dart';
import 'package:readme_editor/src/shield/usedShield.dart';

enum ShieldType {
  static,
  dependency,
  used,
}

class Shield {
  Shield(
    String user,
    String repo,
    ShieldColor color,
    ShieldStyle style,
  ) {
    this.user = user;
    this.repo = repo;
    this.color = color.name;
    this.style = color.name;
  }

  String user;
  String color;
  String repo;
  String style;

  String staticShield(String lable, String message) {
    return "![$lable](https://img.shields.io/badge/$lable-$message-${this.color}?style=${this.style})";
  }

  String pipenvDependency(String packageName) {
    return "![GitHub Pipenv locked dependency version](https://img.shields.io/github/pipenv/locked/dependency-version/${this.user}/${this.repo}/$packageName?style=${this.style})";
  }

  String usedShield(UsedShield shieldPrefix) {
    return shieldPrefix.markdown +
        "${this.user}/${this.repo}?style=${this.style})";
  }
}
