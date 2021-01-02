import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsService with ChangeNotifier {
  getNewsData(context) async {
    var response;
    try {
      response = await Provider.of<Dio>(context, listen: false)
          .get('default?cat=guncel');
    } catch (e) {
      response = e;
      print(e);
    }
    print(response);
    return response;
  }
}
