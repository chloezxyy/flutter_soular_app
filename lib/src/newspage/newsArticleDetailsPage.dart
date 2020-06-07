import 'package:flutter/material.dart';
import 'package:flutter_soular_app/src/viewmodels/newsArticleViewModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsArticleDetailsPage extends StatelessWidget {

  final NewsArticleViewModel article; 

  NewsArticleDetailsPage({this.article});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("${this.article.title}")
      ),
      body: WebView(
        initialUrl: this.article.url,
      )
    );
    
  }

}