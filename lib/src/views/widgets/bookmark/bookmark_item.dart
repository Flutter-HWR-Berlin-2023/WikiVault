import 'package:flutter/material.dart';

import 'package:wiki_vault/src/models/article.dart';
import 'package:wiki_vault/src/views/widgets/bookmark/bookmark_edit.dart';
import 'package:wiki_vault/src/views/widgets/search/search_bookmark.dart';

// An individual article in the bookmark list consists of a title, a subtitle and a link to the article page (offline)
class BookmarkItem extends StatelessWidget {
  const BookmarkItem({required this.article, Key? key}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title),
      subtitle: article.description != null ? Text(article.description![0].toUpperCase() + article.description!.substring(1).toLowerCase()) : null,
      trailing: Wrap(
        spacing: 12, // space between two icons
        children: <Widget>[
          BookmarkEdit(article: article),
          SearchBookmark(article: article)
        ],
      ),
      onTap: () => Navigator.of(context).pushNamed('/article', arguments: article),
    );
  }
}