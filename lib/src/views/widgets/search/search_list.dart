import 'package:flutter/material.dart';
import 'package:wiki_vault/src/models/search.dart';
import 'package:wiki_vault/src/views/widgets/search/search_continue.dart';
import 'package:wiki_vault/src/views/widgets/search/search_item.dart';

import 'package:wiki_vault/src/models/article.dart';

// stateless widget building a ListView of SearchItems and SearchContinue widgets based on given searches and articles, 
// adds a divider between each item, and a scroll controller and android-esque bouncing physics
class SearchList extends StatelessWidget {
  const SearchList({required this.searches, required this.articles, required this.canContinue, required this.continues, Key? key}) : super(key: key);

  final List<Search> searches;
  final Map<int, Article> articles;
  final bool canContinue;  // whether or not the user can continue searching
  final bool continues; // whether or not the user is currently searching

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: canContinue ? searches.length + 1 : searches.length,
      itemBuilder: (BuildContext context, int index) {
        return index >= searches.length ? SearchContinue(continues: continues) : SearchItem(
            search: searches[index],
            article: (articles.containsKey(searches[index].pageID) ? articles[searches[index].pageID]! : Article())
        );
      },
      separatorBuilder: (_, index) {
        return const Divider(color: Colors.grey);
      },
      controller: ScrollController(),
      physics: const BouncingScrollPhysics(), // bouncing physics for Android-like haptics
    );
  }
}