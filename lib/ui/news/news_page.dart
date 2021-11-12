/*
 * Copyright (c) 2021 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for
 * pedagogical or instructional purposes related to programming, coding,
 * application development, or information technology.  Permission for such
 * use, copying, modification, merger, publication, distribution, sublicensing,
 * creation of derivative works, or sale is expressly withheld.
 *
 * This project and source code may use libraries or frameworks that are
 * released under various Open-Source licenses. Use of those libraries and
 * frameworks are governed by their own individual licenses.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

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
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: isLoading ? const ProgressWidget() : buildNewsList(),
    );
  }

  ListView buildNewsList() {
    return ListView(
      children: news
          .map(
            (newsItem) => NewsItemWidget(
              newsItem: newsItem,
            ),
          )
          .toList(),
    );
  }
}
