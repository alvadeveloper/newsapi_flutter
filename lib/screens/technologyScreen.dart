import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../models/newsModel.dart';
import '../widgets/technology/technologyCard.dart';

String API_KEY = 'd558f0e4a9de4f5696c001ff0f820f4e';

List<News> technology = [];

Future getTechnolgyData() async {
  String url =
      'https://newsapi.org/v2/top-headlines?q=technology&from=2021-08-08&sortBy=popularity&apiKey=${API_KEY}';

  var response = await http.get(Uri.parse(url));

  var jsonData = jsonDecode(response.body);

  if (jsonData['status'] == 'ok') {
    jsonData['articles'].forEach((element) {
      News news = News(
        title: element['title'],
        author: element['author'],
        description: element['description'],
        urlToImage: element['urlToImage'],
        publshedAt: DateTime.parse(element['publishedAt']),
        content: element["content"],
        articleUrl: element["url"],
      );

      technology.add(news);
    });
  }
}

class technologyScreen extends StatefulWidget {
  // var count = 0;
  @override
  _technologyScreenState createState() => _technologyScreenState();
}

class _technologyScreenState extends State<technologyScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getTechnolgyData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Text('Do not have connection, please try again later'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scrollbar(
            isAlwaysShown: true,
            child: ListView.builder(
              itemCount: technology.length,
              itemBuilder: (context, index) {
                return TechnologyCard(
                    technology[index].title ?? '',
                    technology[index].description ?? '',
                    technology[index].author ?? '',
                    technology[index].content ?? '',
                    technology[index].publshedAt ?? '',
                    technology[index].urlToImage ?? '',
                    technology[index].articleUrl ?? '');
              },
            ),
          );
        });
  }
}
