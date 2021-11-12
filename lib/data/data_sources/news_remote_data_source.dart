import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/news_model.dart';

class NewsRemoteDataSource {
  static const _root = 'hacker-news.firebaseio.com';

  Future<List<int>> fetchTopIds() async {
    final response = await http.get(Uri.https(_root, '/v0/topstories.json'));
    final ids = json.decode(response.body);
    return ids.cast<int>() ?? [];
  }

  Future<NewsModel> fetchItem(int id) async {
    final response = await http.get(Uri.https(_root, '/v0/item/$id.json'));
    final parsedJson = json.decode(response.body);
    return NewsModel.fromJson(parsedJson);
  }
}
