import 'dart:async';

import '../../models/news_model.dart';
import '../data_sources/news_remote_data_source.dart';

class NewsRepository {
  const NewsRepository({
    required this.remoteDataSource,
  });
  final NewsRemoteDataSource remoteDataSource;

  Future<List<NewsModel>> fetchTopNews() async {
    final ids = await remoteDataSource.fetchTopIds();
    final news =
        ids.sublist(0, 30).map((id) => remoteDataSource.fetchItem(id)).toList();
    return Future.wait(news);
  }
}
