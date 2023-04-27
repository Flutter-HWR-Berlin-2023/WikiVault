import 'package:flutter/material.dart';
import 'package:wiki_vault/src/views/widgets/bookmark/bookmark_item.dart';
import 'package:wiki_vault/src/models/article.dart';

/// Defining a stateless widget that builds ListView of BookmarkItems separated by Dividers
/// Using a list of ArticleGroups and(/or) Articles as input.
class BookmarkList extends StatelessWidget {
  const BookmarkList({required this.articleList, Key? key}) : super(key: key);
  final List<Article> articleList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: articleList.length,
      itemBuilder: (BuildContext context, int index) {
        return BookmarkItem(article: articleList[index]);
      },
      separatorBuilder: (_, index) {
        return const Divider(color: Colors.grey);
      },
      controller: ScrollController(),
      physics: const BouncingScrollPhysics(),
    );
  }
}