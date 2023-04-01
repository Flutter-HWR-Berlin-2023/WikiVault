import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/search_bloc.dart';
import 'package:wiki_vault/src/models/search.dart';
import 'package:html/parser.dart';
import 'package:wiki_vault/src/views/widgets/search/search_bookmark.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({Key? key, required this.search}) : super(key: key);
  final Search search;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(search.title),
        subtitle: Text(parse(search.snippet).documentElement!.text),
        trailing: const SearchBookmark(),
        children: <Widget>[
          (search.extract != null) ? Text(parse(search.extract!).documentElement!.text.trim()) : const Text("Kein Extract"),
        ]
        //onTap: () => Navigator.of(context).pushNamed('/article', arguments: BlocProvider.of<SearchBloc>(context).state.getArticle(search.pageID)),
      );
  }
}
