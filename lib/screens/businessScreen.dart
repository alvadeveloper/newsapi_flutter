import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../models/newsModel.dart';
import '../widgets/business/businessCard.dart';

String API_KEY = 'd558f0e4a9de4f5696c001ff0f820f4e';

List<News> business = [];

Future getbusinessData() async {
  String url =
      'https://newsapi.org/v2/top-headlines?q=business&from=2021-08-08&sortBy=popularity&apiKey=${API_KEY}';

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

      business.add(news);
    });
  }
}

class BusinessScreen extends StatefulWidget {
  // var count = 0;
  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getbusinessData(),
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
              itemCount: business.length,
              itemBuilder: (context, index) {
                print(business[index].urlToImage);
                return BusinessCard(
                    business[index].title ?? '',
                    business[index].description ?? '',
                    business[index].author ?? '',
                    business[index].content ?? '',
                    business[index].publshedAt ?? '',
                    business[index].urlToImage ?? '',
                    business[index].articleUrl ?? '');
              },
            ),
          );
        });
  }
}
