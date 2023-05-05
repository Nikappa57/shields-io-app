import 'package:web_scraper/web_scraper.dart';

class Scraper {
  final shieldScraper = WebScraper('https://shields.io/');
  final badgesScraper = WebScraper('https://ileriayo.github.io/');
  final iconScraper = WebScraper('https://raw.githubusercontent.com/');

  Future<List> getShieldsByCategory(String categoryLink) async {
    List<Map<String, String>> shields = [];
    if (await shieldScraper.loadWebPage(categoryLink)) {
      final List<Map<String, dynamic>> elementsImg = shieldScraper
          .getElement('tr > td > span.hRIOFQ > img', ['alt', 'src']);
      final List<Map<String, dynamic>> elementsCode = shieldScraper
          .getElement('tr > td > code.snippet__StyledCode-rxmdgr-1', []);
      if (elementsImg.length != elementsCode.length) return null;
      final int len = elementsImg.length;
      for (int i = 0; i < len; i++) {
        shields.add({
          'name': elementsImg[i]['attributes']['alt'],
          'img': 'https://shields.io' + elementsImg[i]['attributes']['src'],
          'code': elementsCode[i]['title'],
        });
      }
    }
    return shields;
  }

  // icons
  Future<List> getStaticIcons() async {
    final iconsPattern = RegExp(r'\| `(.*)` \| `(.*)` \|');
    List<Map<String, String>> icons = [];
    if (await iconScraper
        .loadWebPage('/simple-icons/simple-icons/develop/slugs.md')) {
      String pageContent = iconScraper.getPageContent();
      final matches = iconsPattern.allMatches(pageContent);

      for (var match in matches) {
        icons.add({
          'name': match.group(1),
          'slug': match.group(2),
        });
      }
    }
    return icons;
  }

  // badges
  Future<List> getStaticBadges() async {
    final badgePattern = RegExp(r'(\/badge.*?)\)');
    List<Map<String, String>> badges = [];
    if (await badgesScraper.loadWebPage('/markdown-badges/')) {
      List<Map<String, dynamic>> elementsImg = badgesScraper
          .getElement('table > tbody > tr > td > img', ['alt', 'src']);
      elementsImg = elementsImg
          .where((element) => (element['attributes']['src'] as String)
              .startsWith('https://img.shields.io/badge/'))
          .toList();
      final List<Map<String, dynamic>> elementsCode =
          badgesScraper.getElement('tr > td > code', []);
      if (elementsImg.length != elementsCode.length) return null;
      final int len = elementsImg.length;
      for (int i = 0; i < len; i++) {
        String codeMatch = badgePattern
            .allMatches(elementsCode[i]['title'])
            .elementAt(0)
            .group(1);

        badges.add({
          'name': elementsImg[i]['attributes']['alt'],
          'img': elementsImg[i]['attributes']['src'],
          'code': codeMatch,
        });
      }
    }
    return badges;
  }
}
