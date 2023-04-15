import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/bookmark_bloc.dart';
import 'package:wiki_vault/src/models/article.dart';

class SearchBookmark extends StatelessWidget {
  const SearchBookmark(this.article, {Key? key}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BookmarkBloc, BookmarkState, bool>(
        selector: (state) => state.isBookmarked(article.pageID),
        builder: (context, state) {
          return state
              ? ElevatedButton(
                  child: const Icon(Icons.bookmark),
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent)),
                  onPressed: () => BlocProvider.of<BookmarkBloc>(context).add(RemoveBookmark(article.pageID))
              )
              : ElevatedButton(
                  child: const Icon(Icons.bookmark),
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey)),
                  onPressed: () => BlocProvider.of<BookmarkBloc>(context).add(AddBookmark(article))
              );
        });
  }
}
