import 'package:flutter/material.dart';
import 'package:newsApp/model/categories_model.dart';

class NewsDetailScreen extends StatefulWidget {
  final News news;
  const NewsDetailScreen(this.news);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.title ?? ''),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Text(
              widget.news.title ?? '',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(widget.news.author ?? ''),
            Image.network(widget.news.urlToImage),
            SizedBox(
              height: 20,
            ),
            Text(widget.news.description ?? '',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.normal,
                )),
            Text(
              widget.news.content ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
