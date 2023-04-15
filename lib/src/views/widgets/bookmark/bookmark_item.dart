import 'package:flutter/material.dart';

import 'package:wiki_vault/src/models/article.dart';

class BookmarkItem extends StatelessWidget {
  const BookmarkItem(this.article, {Key? key}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title),
      subtitle: article.description != null ? Text(article.description![0].toUpperCase() + article.description!.substring(1).toLowerCase()) : null,
      onLongPress: () => Navigator.of(context).pushNamed('/article', arguments: article),
    );
  }
}