import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EntertainmentCard extends StatelessWidget {
  String title;
  String author;
  String description;
  String urlToImage;
  DateTime publshedAt;
  String content;
  String articleUrl;

  EntertainmentCard(this.title, this.description, this.author, this.content,
      this.publshedAt, this.urlToImage, this.articleUrl);
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).copyWith().size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            urlToImage == ''
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      urlToImage,
                      errorBuilder: (context, error, stackTrace) => SizedBox(),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title.length > 50 ? '${title.substring(0, 50)}...' : title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(description.length > 250
                  ? '${description.substring(0, 250)}...'
                  : description),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: TextButton(
                onPressed: () async {
                  if (await canLaunch(articleUrl)) {
                    await launch(
                      articleUrl,
                      forceSafariVC: true,
                      forceWebView: true,
                      enableJavaScript: true,
                    );
                  } else {
                    throw 'Could not launch $articleUrl';
                  }
                },
                child: Text(
                  articleUrl.length > 30
                      ? '${articleUrl.substring(0, 30)}...'
                      : articleUrl,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child:
                  Text(author, style: TextStyle(fontStyle: FontStyle.italic)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Text(publshedAt.toIso8601String(),
                  style: TextStyle(fontStyle: FontStyle.italic)),
            ),
          ],
        ),
      ),
    );
  }
}
