import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/services/news_service.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() async {
  var api = Dio();
  String token;
  api.options.baseUrl = "https://www.aa.com.tr/tr/rss/";
  api.options.contentType = "application/json";

  //api.options.headers = {"Authorization": "Bearer $token", "language": "tr"};
  runApp(MyApp(
    api: api,
    token: token,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  final token, api;
  MyApp({this.api, this.token});
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
