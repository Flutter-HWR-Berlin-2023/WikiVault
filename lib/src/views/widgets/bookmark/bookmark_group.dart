import 'package:flutter/material.dart';
import 'package:wiki_vault/src/models/article_group.dart';

class BookmarkGroup extends StatelessWidget {
  const BookmarkGroup(this.articleGroup, {Key? key}) : super(key: key);
  final ArticleGroup articleGroup;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(articleGroup.name),
      subtitle: articleGroup.description == null ? null : Text(articleGroup.description!),
    );
  }
}
