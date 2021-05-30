import "package:flutter/material.dart";
import 'package:web_scraper/web_scraper.dart';

class Scrapper extends StatefulWidget {
  @override
  _ScrapperState createState() => _ScrapperState();
}

class _ScrapperState extends State<Scrapper> {
  @override
  void initState() {
    initChaptersTitleScrap();
    super.initState();
  }

  void initChaptersTitleScrap() async {
    print("Function is called");
    final rawUrl =
        'https://unacademy.com/course/gravitation-for-iit-jee/D5A8YSAJ';
    final webScraper = WebScraper('https://unacademy.com');
    final endpoint = rawUrl.replaceAll(r'https://unacademy.com', '');
    print(endpoint);
    if (await webScraper.loadWebPage(endpoint)) {
      final titleElements = webScraper.getElement(
          'div.Week__Wrapper-sc-1qeje5a-2 > a.Link__StyledAnchor-sc-1n9f3wx-0 '
          '> div.ItemCard__ItemInfo-xrh60s-1 '
          '> h6.H6-sc-1gn2suh-0',
          []);
      print(titleElements);
      final titleList = <String>[];
      titleElements.forEach((element) {
        final title = element['title'];
        titleList.add('$title');
      });
      print(titleList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Scaraping"),
    );
  }
}
