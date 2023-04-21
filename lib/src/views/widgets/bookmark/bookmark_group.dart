import 'package:flutter/material.dart';
import 'package:wiki_vault/src/models/article_group.dart';

// User may use this to group articles together for easier access
// Groups will be shown in the bookmark list as a title with a subtitle
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
