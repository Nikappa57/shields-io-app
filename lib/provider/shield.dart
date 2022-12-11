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

    Future.forEach(ShieldCategory.values, (ShieldCategory category) async {
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
  }
}
