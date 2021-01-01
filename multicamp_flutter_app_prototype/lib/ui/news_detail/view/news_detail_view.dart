import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

class NewsDetailView extends StatefulWidget {
  String title, url;

  NewsDetailView(String title, String url) : super() {
    this.title = title;
    this.url = url;
  }

  @override
  _NewsDetailViewState createState() => _NewsDetailViewState(title, url);
}

class _NewsDetailViewState extends State<NewsDetailView> {
  String title, url;

  _NewsDetailViewState(String title, String url) {
    this.title = title;
    this.url = url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                // color: Colors.black54,
              ),
              onPressed: () => Navigator.pop(context)),
          title: Text(
            title,
            style: TextStyle(fontSize: 12),
            maxLines: 3,
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.share,
                  // color: Colors.black54,
                ),
                onPressed: () => Share.share("$title $url")),
          ],
        ),
        body: WebView(initialUrl: url));
  }
}
