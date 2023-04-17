import 'package:flutter/material.dart';
import 'package:wiki_vault/src/models/search.dart';
import 'package:wiki_vault/src/views/widgets/search/search_continue.dart';
import 'package:wiki_vault/src/views/widgets/search/search_item.dart';

import 'package:wiki_vault/src/models/article.dart';

class SearchList extends StatelessWidget {
  const SearchList(this.searches, this.articles, this.canContinue, this.isContinuing, {Key? key}) : super(key: key);

  final List<Search> searches;
  final Map<int, Article> articles;
  final bool canContinue;
  final bool isContinuing;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: canContinue ? searches.length + 1 : searches.length,
      itemBuilder: (BuildContext context, int index) {
        return index >= searches.length ? SearchContinue(isContinuing) : SearchItem(searches[index], (articles.containsKey(searches[index].pageID) ? articles[searches[index].pageID]! : Article()));
      },
      separatorBuilder: (_, index) {
        return const Divider(color: Colors.grey);
      },
      controller: ScrollController(),
      physics: const BouncingScrollPhysics(),
    );
  }
}