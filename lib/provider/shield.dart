import 'package:flutter/material.dart';
import 'package:readme_editor/models/shield.dart';
import 'package:readme_editor/src/shield/category.dart';
import 'package:readme_editor/src/shield/scraper.dart';
import 'package:readme_editor/src/shield/shield.dart';

class Shields extends ChangeNotifier {
  List<ShieldModel> _shields = [];

  List<ShieldModel> get shields {
    return [..._shields]; // Return a copy of _shields
  }

  Future<void> setData() async {
    Scraper scraper = Scraper();

    ShieldCategory.values.forEach((category) async {
      // get shields list in category
      final List categoryShields =
          await scraper.getShieldsByCategory(category.link);

      categoryShields.forEach((shieldElement) {
        if (shieldElement['name'] != null &&
            shieldElement['code'] != null &&
            shieldElement['img'] != null) {
          _shields.add(
            ShieldModel(
              name: shieldElement['name'],
              code: shieldElement['code'],
              previewImgUrl: shieldElement['img'],
              type: ShieldType.normal,
              category: category,
            ),
          );
        }
      });
    });
    print(_shields);
  }

  void addShield() {
    // _shields.add(value);
    notifyListeners();
  }
}
