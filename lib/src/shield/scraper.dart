import 'package:web_scraper/web_scraper.dart';

class Scraper {
  final webScraper = WebScraper('https://shields.io/');

  Future<List<Map<String, String>>> get categoryList async {
    List<Map<String, String>> categoryMap = [];
    if (await webScraper.loadWebPage('/')) {
      List<Map<String, dynamic>> elements =
          webScraper.getElement('div > a', ['href']);
      for (var e in elements) {
        print(e);
        final String link = e["attributes"]["href"];
        print(link);
        if (link.contains('/category/')) {
          print("OK");
          categoryMap.add({
            'name': e['title'],
            'link': link,
          });
        }
      }
    }
    print("----------");
    print(categoryMap);
    return categoryMap;
  }
}
