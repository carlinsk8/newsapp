import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/theme.dart';
import 'package:newsapp/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            _ListCategories(),
            Expanded(
                child: newsService.getArticleByCategory.length == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListNews(newsService.getArticleByCategory))
          ],
        ),
      ),
    );
  }
}

class _ListCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    final newsService = Provider.of<NewsService>(context);
    return Container(
      width: double.infinity,
      height: 80.0,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext contex, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _CategoryButton(categories[index]),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    categories[index].name.capitalize(),
                    style: TextStyle(
                        color: newsService.selectedCategory ==
                                categories[index].name
                            ? myTheme.accentColor
                            : null),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return Container(
      child: GestureDetector(
        onTap: () {
          final newsService = Provider.of<NewsService>(context, listen: false);
          newsService.selectedCategory = category.name;
        },
        child: Container(
            width: 40.0,
            height: 40.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Icon(category.icon,
                color: newsService.selectedCategory == category.name
                    ? myTheme.accentColor
                    : Colors.black54)),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
