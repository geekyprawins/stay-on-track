import 'package:flutter/material.dart';

@immutable
class NewsModel {
  final int id;
  final String by;
  final int time;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;

  NewsModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        by = parsedJson['by'] ?? '',
        time = parsedJson['time'],
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'] ?? '',
        score = parsedJson['score'],
        title = parsedJson['title'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
