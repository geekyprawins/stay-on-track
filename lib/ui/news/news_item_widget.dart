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

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../models/news_model.dart';
import '../../utils/datetime_utils.dart';
import '../app_colors.dart';

class NewsItemWidget extends StatefulWidget {
  final NewsModel newsItem;

  const NewsItemWidget({Key? key, required this.newsItem}) : super(key: key);

  @override
  _NewsItemWidgetState createState() => _NewsItemWidgetState();
}

class _NewsItemWidgetState extends State<NewsItemWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  NewsModel get newsItem => widget.newsItem;
  bool isExpanded = false;

  void toggleIsExpanded() {
    if (mounted) {
      setState(() => isExpanded = !isExpanded);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textTheme = Theme.of(context).textTheme;

    return isExpanded
        ? buildExpandedListTile(textTheme, context)
        : buildCollapsedListTile(textTheme);
  }

  ListTile buildCollapsedListTile(TextTheme textTheme) {
    return ListTile(
      onTap: () => toggleIsExpanded(),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            DateTimeUtils.formattedDateFromEpoch(newsItem.time),
            style: textTheme.bodyText2,
          ),
          const SizedBox(height: 10),
          Text(
            newsItem.title,
            style: textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildExpandedListTile(textTheme, context) {
    return ListTile(
      tileColor: AppColors.primary.withOpacity(0.3),
      onTap: toggleIsExpanded,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateTimeUtils.formattedDateFromEpoch(newsItem.time),
                style: textTheme.bodyText2,
              ),
              IconButton(
                icon: const Icon(
                  Icons.link,
                  color: AppColors.black,
                ),
                onPressed: () async => _launchURL(context),
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(
            newsItem.title,
            style: textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary.withAlpha(200),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'by: ' + newsItem.by,
            style: textTheme.bodyText2,
          ),
          Text(
            newsItem.kids.length.toString() +
                ' comments | ' +
                newsItem.score.toString() +
                ' votes',
            style: textTheme.bodyText2,
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    final url = newsItem.url;
    if (Platform.isIOS || await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could\'nt launch the article\'s URL.'),
        ),
      );
    }
  }
}
