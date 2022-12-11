import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ShieldCategory {
  All,
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
  static,
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
        suffix = describeEnum(this).toLowerCase();
        break;
    }
    return '/category/$suffix';
  }

  IconData get icon {
    switch (this) {
      case ShieldCategory.All:
        return Icons.list_alt;
      case ShieldCategory.Build:
        return Icons.build;
      case ShieldCategory.CodeCoverage:
        return Icons.grading_sharp;
      case ShieldCategory.TestResults:
        return Icons.check_box;
      case ShieldCategory.Analysis:
        return Icons.equalizer;
      case ShieldCategory.Chat:
        return Icons.chat_bubble_outline;
      case ShieldCategory.Dependencies:
        return Icons.developer_board_outlined;
      case ShieldCategory.Size:
        return Icons.file_copy_outlined;
      case ShieldCategory.Downloads:
        return Icons.download_outlined;
      case ShieldCategory.Funding:
        return Icons.monetization_on_outlined;
      case ShieldCategory.IssueTracking:
        return Icons.error_outline;
      case ShieldCategory.License:
        return Icons.privacy_tip_outlined;
      case ShieldCategory.Rating:
        return Icons.star_border;
      case ShieldCategory.Social:
        return Icons.contact_phone_outlined;
      case ShieldCategory.Version:
        return Icons.format_list_numbered;
      case ShieldCategory.PlatformSupport:
        return Icons.support;
      case ShieldCategory.Monitoring:
        return Icons.control_camera;
      case ShieldCategory.Activity:
        return Icons.accessibility_outlined;
      case ShieldCategory.Other:
        return Icons.plus_one_outlined;
      default:
        return null;
    }
  }
}
