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
    this.user,
    this.repo,
    this.color,
    this.style,
  );

  final String user;
  final String color;
  final String repo;
  final String style;

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
