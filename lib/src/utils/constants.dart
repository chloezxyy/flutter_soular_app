class Constants {

  static String HEADLINE_NEWS_URL  =  "https://newsapi.org/v2/top-headlines?country=us&apiKey=9f97357e9b2947dd8e51812a5c7a1ef3";

  static String headlinesFor(String keyword) {

    return  "https://newsapi.org/v2/everything?q=$keyword&apiKey=9f97357e9b2947dd8e51812a5c7a1ef3";

  }
      static final String NEWS_PLACEHOLDER_IMAGE_ASSET_URL = 'assets/images/graph.jpg';


  

}