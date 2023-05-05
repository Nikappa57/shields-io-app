import 'package:flutter/material.dart';
import 'package:readme_editor/models/icon.dart';
import 'package:readme_editor/models/shield.dart';
import 'package:readme_editor/src/shield/category.dart';
import 'package:readme_editor/src/shield/scraper.dart';
import 'package:readme_editor/src/shield/styles.dart';

class Shields extends ChangeNotifier {
  List<ShieldModel> _shields = [];
  List<BadgeIconModel> _icons = [];

  List<ShieldModel> get shields {
    return [..._shields]; // Return a copy of _shields
  }

  List<BadgeIconModel> get icons {
    return [..._icons]; // Return a copy of _icons
  }

  Future<void> setData() async {
    if (_shields.isNotEmpty) return null;
    Scraper scraper = Scraper();
    // Shields
    var futures = <Future>[];
    for (ShieldCategory category in ShieldCategory.values) {
      if (category == ShieldCategory.static || category == ShieldCategory.badge)
        continue;

      var thread = new Future(() async {
        // get shields list in category
        final List<Map<String, String>> categoryShields =
            await scraper.getShieldsByCategory(category.link);

        for (Map<String, String> shieldElement in categoryShields) {
          if (shieldElement['name'] != null &&
              shieldElement['code'] != null &&
              shieldElement['img'] != null) {
            ShieldModel shield = ShieldModel(
              name: shieldElement['name'],
              code: shieldElement['code'],
              previewImgUrl: shieldElement['img'].replaceAll(
                  'https://shields.io', 'https://raster.shields.io'),
              category: category,
            );
            if (shield.code.contains('?style=social')) {
              shield.code = shield.code.replaceAll('?style=social', '');
              shield.style = ShieldStyle.social;
            }
            _shields.add(shield);
          }
        }
      });
      futures.add(thread);
    }
    await Future.wait(futures);
    // Badges
    final List<Map<String, String>> badges = await scraper.getStaticBadges();
    for (Map<String, String> badgeElement in badges) {
      if (badgeElement['name'] != null &&
          badgeElement['code'] != null &&
          badgeElement['img'] != null) {
        if (_shields
            .where((element) => element.name == badgeElement['name'])
            .isNotEmpty) continue;
        _shields.add(
          ShieldModel(
            name: badgeElement['name'],
            code: badgeElement['code'],
            previewImgUrl: badgeElement['img'].replaceAll(
                'https://img.shields.io', 'https://raster.shields.io'),
            category: ShieldCategory.badge,
          ),
        );
      }
    }
    //icons
    final List<Map<String, String>> icons = await scraper.getStaticIcons();
    for (Map<String, String> icon in icons) {
      if (icon['name'] != null && icon['slug'] != null) {
        _icons.add(
          BadgeIconModel(name: icon['name'], slug: icon['slug']),
        );
      }
    }
  }
}
