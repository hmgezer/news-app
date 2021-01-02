import 'dart:convert';

import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

rssToJson(String category,
    {String baseUrl = 'https://www.aa.com.tr/tr/rss/'}) async {
  var client = http.Client();
  final myTransformer = Xml2Json();

  return await client.get(baseUrl + category + '/rssfeed.xml').then((response) {
    return response.body;
  }).then((bodyString) {
    myTransformer.parse(bodyString);
    var json = myTransformer.toGData();
    return jsonDecode(json)['rss']['channel']['item'];
  });
}
