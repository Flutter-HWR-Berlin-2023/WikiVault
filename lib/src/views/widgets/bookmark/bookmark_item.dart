import 'package:flutter/material.dart';

import '../../../models/article.dart';

class BookmarkItem extends StatelessWidget {
  const BookmarkItem(this.article, {Key? key, required }) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title),
      subtitle: article.description == null ? null : Text(article.description!),
    );
  }
}