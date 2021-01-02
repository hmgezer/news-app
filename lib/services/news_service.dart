import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsApp/model/categories_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  bool loading = true;

  setLoading(val) {
    loading = val;
    notifyListeners();
  }

  List<News> newsUs = [];
  getNewsData(String title) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&pageSize=14&apiKey=1784eb677bb34338a3d8b5ebb53959f4";
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          News newnews = News(
              author: element["author"],
              content: element["content"],
              description: element["description"],
              title: element["title"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              publishedAt: element["publishedAt"]);
          newsUs.add(newnews);
          print(newnews.title);
        }
      });
    }
    setLoading(false);
  }
}
