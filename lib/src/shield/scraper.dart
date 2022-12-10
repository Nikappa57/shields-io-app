import 'package:web_scraper/web_scraper.dart';

class Scraper {
  final webScraper = WebScraper('https://shields.io/');

  Future<List> getShieldsByCategory(String categoryLink) async {
    List<Map<String, String>> shields = [];
    if (await webScraper.loadWebPage(categoryLink)) {
      final List<Map<String, dynamic>> elementsImg =
          webScraper.getElement('tr > td > span.OYSbn > img', ['alt', 'src']);
      final List<Map<String, dynamic>> elementsCode = webScraper
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
}
