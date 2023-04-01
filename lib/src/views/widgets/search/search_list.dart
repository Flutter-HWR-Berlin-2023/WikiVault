import 'package:flutter/material.dart';
import 'package:wiki_vault/src/models/search.dart';
import 'package:wiki_vault/src/views/widgets/search/search_continue.dart';
import 'package:wiki_vault/src/views/widgets/search/search_item.dart';

class SearchList extends StatelessWidget {
  const SearchList({Key? key, required this.list, required this.canContinue}) : super(key: key);

  final List<Search> list;
  final bool canContinue;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: canContinue ? list.length + 1 : list.length,
      itemBuilder: (BuildContext context, int index) {
        return index >= list.length ? const SearchContinue() : SearchItem(search: list[index]);
      },
      separatorBuilder: (_, index) {
        return const Divider(color: Colors.grey);
      },
      controller: ScrollController(),
    );
  }
}