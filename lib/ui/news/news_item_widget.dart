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
