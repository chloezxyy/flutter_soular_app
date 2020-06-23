
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soular_app/src/models/newsArticle.dart';
import 'package:flutter_soular_app/src/services/webService.dart';
import 'package:flutter_soular_app/src/utils/constants.dart';

class NewsListState extends State<NewsList> {

  List<NewsArticle> _newsArticles = List<NewsArticle>(); 

  @override
  void initState() {
    super.initState();
    _populateNewsArticles(); 
  }

  void _populateNewsArticles() {
   
    Webservice().load(NewsArticle.all).then((newsArticles) => {
      setState(() => {
        _newsArticles = newsArticles
      })
    });

  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
      return ListTile(
        title: _newsArticles[index].urlToImage == null ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL) : Image.network(_newsArticles[index].urlToImage), 
        subtitle: Text(_newsArticles[index].title, style: TextStyle(fontSize: 18)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        body: ListView.builder(
          // itemCount: _newsArticles.length,
          itemCount: 3,

          itemBuilder: _buildItemsForListView,
        )
      );
  }
}

class NewsList extends StatefulWidget {

  @override
  createState() => NewsListState(); 
}