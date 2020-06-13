import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _urlNews= "https://newsapi.org/v2";
final _apiKey= "6d78ffed81b540e4a6058281ba38498f";

class NewsService with ChangeNotifier {

  List<Article> headlines = [];

  String _selectedCategory = "business";

  List<Category> categories = [
    Category(FontAwesomeIcons.building,"business"),
    Category(FontAwesomeIcons.tv,"entertainment"),
    Category(FontAwesomeIcons.addressCard,"general"),
    Category(FontAwesomeIcons.headSideVirus,"health"),
    Category(FontAwesomeIcons.vials,"science"),
    Category(FontAwesomeIcons.volleyballBall,"sports"),
    Category(FontAwesomeIcons.memory,"technology"),

  ];

  Map<String, List<Article>> categoryArticles={};
      
  NewsService(){
    this.getTopHeadlines();
    categories.forEach((item) {
      this.categoryArticles[item.name]=new List();
    });
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String value){
    this._selectedCategory=value;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get getArticleByCategory => this.categoryArticles[this._selectedCategory];

  getTopHeadlines() async {
    
    final url = "$_urlNews/top-headlines?apiKey=$_apiKey&country=us";
    final resp = await http.get(url);
    
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async{

    if(this.categoryArticles[category].length>0){
      return this.categoryArticles[category];
    }

    final url = "$_urlNews/top-headlines?apiKey=$_apiKey&country=us&category=$category";
    final resp = await http.get(url);
    
    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category].addAll(newsResponse.articles);
    
    notifyListeners();
  }

}