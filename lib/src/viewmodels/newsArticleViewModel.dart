

import 'package:flutter_soular_app/src/models/newsArticle.dart';

class NewsArticleViewModel {

  NewsArticle _newsArticle; 

  NewsArticleViewModel({NewsArticle article}): _newsArticle = article;

  String get title { 
    return _newsArticle.title; 
  }

  String get description { 
    return _newsArticle.description;
  }

  String get imageURL {
    return _newsArticle.urlToImage; 
  }

  String get url {
    return _newsArticle.url; 
  }

}