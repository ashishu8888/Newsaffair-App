import 'dart:math';

import 'package:news_affair_app/model/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  List<ArticleModel> news = [];

  Future<List<ArticleModel>> getNews() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=4f7292771af94b8c8e768be2df00a237");

    var response = await http.get(url);

    var jsonData = json.decode(response.body);
    // print(jsonData);
    try {
      if (jsonData['status'] == "ok") {
        jsonData['articles'].forEach((element) {
          if (element['urlToImage'] != null &&
              element['description'] != null &&
              element['author'] != null &&
              element['url'] != null &&
              element['content'] != null) {
            ArticleModel articleModel = ArticleModel(
                author: element['author'],
                title: element['title'],
                description: element['description'],
                url: element['url'],
                urlToimage: element['urlToImage'],
                content: element["content"]);
            news.add(articleModel);
          }
        });
      }
    } catch (e) {
      print('$e + hi');
    }
    return news;
  }
}
