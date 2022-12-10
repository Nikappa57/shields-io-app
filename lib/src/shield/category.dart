import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ShieldCategory {
  Build,
  CodeCoverage,
  TestResults,
  Analysis,
  Chat,
  Dependencies,
  Size,
  Downloads,
  Funding,
  IssueTracking,
  License,
  Rating,
  Social,
  Version,
  PlatformSupport,
  Monitoring,
  Activity,
  Other,
}

extension ColorExtension on ShieldCategory {
  String get name => describeEnum(this);

  String get link {
    String suffix;

    switch (this) {
      case ShieldCategory.CodeCoverage:
        suffix = 'coverage';
        break;
      case ShieldCategory.TestResults:
        suffix = 'test-results';
        break;
      case ShieldCategory.IssueTracking:
        suffix = 'issue-tracking';
        break;
      case ShieldCategory.PlatformSupport:
        suffix = 'platform-support';
        break;
      default:
        suffix = describeEnum(this);
        break;
    }
    return '/category/$suffix';
  }

  Icon get icon {
    switch (this) {
      case ShieldCategory.Build:
        return Icon(Icons.build);
      case ShieldCategory.CodeCoverage:
        return Icon(Icons.grading_sharp);
      case ShieldCategory.TestResults:
        return Icon(Icons.check_box);
      case ShieldCategory.Analysis:
        return Icon(Icons.equalizer);
      case ShieldCategory.Chat:
        return Icon(Icons.chat_bubble_outline);
      case ShieldCategory.Dependencies:
        return Icon(Icons.developer_board_outlined);
      case ShieldCategory.Size:
        return Icon(Icons.file_copy_outlined);
      case ShieldCategory.Downloads:
        return Icon(Icons.download_outlined);
      case ShieldCategory.Funding:
        return Icon(Icons.monetization_on_outlined);
      case ShieldCategory.IssueTracking:
        return Icon(Icons.error_outline);
      case ShieldCategory.License:
        return Icon(Icons.privacy_tip_outlined);
      case ShieldCategory.Rating:
        return Icon(Icons.star_border);
      case ShieldCategory.Social:
        return Icon(Icons.contact_phone_outlined);
      case ShieldCategory.Version:
        return Icon(Icons.format_list_numbered);
      case ShieldCategory.PlatformSupport:
        return Icon(Icons.support);
      case ShieldCategory.Monitoring:
        return Icon(Icons.control_camera);
      case ShieldCategory.Activity:
        return Icon(Icons.accessibility_outlined);
      case ShieldCategory.Other:
        return Icon(Icons.plus_one_outlined);
      default:
        return null;
    }
  }
}
