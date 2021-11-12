import 'package:flutter/material.dart';

import '../../data/repository/news_repository.dart';
import '../../models/news_model.dart';
import '../../utils/list_utils.dart';
import '../app_colors.dart';
import '../_shared/progress_widget.dart';
import 'news_item_widget.dart';

class NewsPage extends StatefulWidget {
  final NewsRepository newsRepository;
  const NewsPage({Key? key, required this.newsRepository}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late List<NewsModel> news;
  bool isLoading = true;

  //TODO: Preserve News State on tab change
// 1
  void updateNewsState() {
    // 2
    final fetchedNews =
        PageStorage.of(context)!.readState(context, identifier: widget.key);

    // 3
    if (fetchedNews != null) {
      setNewsState(fetchedNews);
    } else {
      fetchNews();
    }
  }

// 4
  void saveToPageStorage(List<NewsModel> newNewsState) {
    PageStorage.of(context)!
        .writeState(context, newNewsState, identifier: widget.key);
  }

  void setNewsState(
    List<NewsModel> newNewsState, {
    bool shouldSavePageStorage = true,
  }) {
    if (mounted) {
      setState(() {
        news = newNewsState;
        isLoading = false;
      });
    }
  }

  Future<void> fetchNews() async {
    try {
      final fetchedNews = await widget.newsRepository.fetchTopNews();
      final shuffledNews = ListUtils.shuffle(fetchedNews) as List<NewsModel>;
      setNewsState(shuffledNews);
      saveToPageStorage(shuffledNews);
    } on Exception catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error while fetching the news!'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    updateNewsState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const ProgressWidget()
        :
        // 1
        RefreshIndicator(
            child: buildNewsList(),
            // 2
            onRefresh: fetchNews,
            color: AppColors.primary,
          );
  }

  ListView buildNewsList() {
    return ListView(
      children: news
          .map(
            (newsItem) => Column(
              key: ValueKey<int>(newsItem.id),
              children: [
                NewsItemWidget(
                  newsItem: newsItem,
                ),
                const Divider(
                  color: Colors.black54,
                  height: 0,
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
