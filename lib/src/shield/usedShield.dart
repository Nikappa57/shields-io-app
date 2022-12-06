import 'package:flutter/foundation.dart';

enum UsedShield {
  lastCommit,
  contributors,
  releseDate,
  codeSize,
  fileCount,
  issue,
  license,
  stars,
  pipenvDependency,
  pythonVersion,
}

extension ColorExtension on UsedShield {
  String get name => describeEnum(this);
  String get markdown {
    switch (this) {
      case UsedShield.lastCommit:
        return "![last commit](/github/last-commit/";
      case UsedShield.contributors:
        return "![contributors](/github/all-contributors/";
      case UsedShield.releseDate:
        return "![relese date](/github/release-date/";
      case UsedShield.codeSize:
        return "![code size](/github/languages/code-size/";
      case UsedShield.fileCount:
        return "![file count](/github/directory-file-count/";
      case UsedShield.issue:
        return "![issue](/github/issues/";
      case UsedShield.stars:
        return "![stars](/github/stars/";
      case UsedShield.license:
        return "![license](/github/license/";
      case UsedShield.pythonVersion:
        return "![GitHub Pipenv locked Python version](https://img.shields.io/github/pipenv/locked/python-version/";
      default:
        return "";
    }
  }
}
