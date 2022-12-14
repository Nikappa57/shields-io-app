import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readme_editor/models/shield.dart';
import 'package:readme_editor/src/shield/category.dart';
import 'package:readme_editor/src/shield/scraper.dart';

class Shields extends ChangeNotifier {
  List<ShieldModel> _shields = [];

  List<ShieldModel> get shields {
    return [..._shields]; // Return a copy of _shields
  }

  Future<void> setData() async {
    Scraper scraper = Scraper();
    final user = FirebaseAuth.instance.currentUser;
    final shieldData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favouriteShield')
        .get();

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
            final bool favourite = shieldData.docs
                .where((element) =>
                    element.data()['shield-code'] == shieldElement['code'])
                .isNotEmpty;
            _shields.add(
              ShieldModel(
                name: shieldElement['name'],
                code: shieldElement['code'],
                previewImgUrl: shieldElement['img'].replaceAll(
                    'https://shields.io', 'https://raster.shields.io'),
                category: category,
                favourite: favourite,
              ),
            );
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
        final bool favourite = shieldData.docs
            .where((element) =>
                element.data()['shield-code'] == badgeElement['code'])
            .isNotEmpty;

        _shields.add(
          ShieldModel(
            name: badgeElement['name'],
            code: badgeElement['code'],
            previewImgUrl: badgeElement['img'].replaceAll(
                'https://img.shields.io', 'https://raster.shields.io'),
            category: ShieldCategory.badge,
            favourite: favourite,
          ),
        );
      }
    }
  }
}
