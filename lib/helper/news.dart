import 'package:http/http.dart' as http;
import 'package:newscartz/models/article.dart';
import 'dart:convert';

class News {

  List<ArticleModel> news  = [];

  Future<void> getNews() async{

    String url = "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=848bb409a18948bbbc1b8eb0d633685a";
    var uri = Uri.parse(url);
    var response = await http.get(uri);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if (element['title'] != null &&
            element['author'] != null &&
            element['description'] != null &&
            element['urlToImage'] != null &&
            element['content'] != null &&
            element['url'] != null) {
          ArticleModel article = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element["content"],
            url: element["url"],
          );
          news.add(article);
        }
      });
    }


  }


}


class NewsForCategorie {

  List<ArticleModel> news  = [];

  Future<void> getNewsForCategory(String category) async{

    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=848bb409a18948bbbc1b8eb0d633685a";

    var uri = Uri.parse(url);
    var response = await http.get(uri);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if (element['title'] != null &&
            element['author'] != null &&
            element['description'] != null &&
            element['urlToImage'] != null &&
            element['content'] != null &&
            element['url'] != null) {
          ArticleModel article = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element["content"],
            url: element["url"],
          );
          news.add(article);
        }
      });
    }


  }


}

class NewsForCategorie_Country {

  List<ArticleModel> news  = [];

  Future<void> getNewsForCategory_Country(String country, String category) async{

    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url = "http://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=848bb409a18948bbbc1b8eb0d633685a";

    var uri = Uri.parse(url);
    var response = await http.get(uri);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if (element['title'] != null &&
            element['author'] != null &&
            element['description'] != null &&
            element['urlToImage'] != null &&
            element['content'] != null &&
            element['url'] != null) {
          ArticleModel article = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element["content"],
            url: element["url"],
          );
          news.add(article);
        }
      });
    }


  }


}


