import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/bookmark_bloc.dart';
import 'package:wiki_vault/src/models/article.dart';
import 'package:wiki_vault/src/views/widgets/dialog.dart';

// Stateless widget displaying a bookmark button 
// button changes color based on whether article is bookmarked, adding/removing the article from bookmarks when pressed based on state
class SearchBookmark extends StatelessWidget {
  const SearchBookmark({required this.article, Key? key}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BookmarkBloc, BookmarkState, bool>(
        selector: (state) => state.isBookmarked(article.pageID),
        builder: (context, state) {
          return state
              ? ElevatedButton(
                  // if article is bookmarked, display a button with a filled bookmark icon
                  child: const Icon(Icons.bookmark),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  onPressed: () => showDialogScreen(
                      context: context,
                      title: "Lesezeichen Entfernen",
                      content: Text('Möchtest du wirklich ' + article.title + ' von den Lesezeichen entfernen?'),
                      actions: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                            onPressed: () {
                              BlocProvider.of<BookmarkBloc>(context).add(RemoveBookmark(context, article));
                              Navigator.pop(context);
                            },
                            child: const Text("Entfernen")
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Abbrechen")
                        ),
                      ]
                  ),
              )
              : ElevatedButton(
                // otherwise display a button with an empty bookmark icon and add the article to bookmarks when pressed
                child: const Icon(Icons.bookmark),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                onPressed: () => showDialogScreen(
                  context: context,
                  title: "Lesezeichen Hinzufügen",
                  content: Text('Möchtest du wirklich ' + article.title + ' zu den Lesezeichen hinzufügen?'),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        onPressed: () {
                          BlocProvider.of<BookmarkBloc>(context).add(AddBookmark(context, article));
                          Navigator.pop(context);
                        },
                        child: const Text("Hinzufügen")
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Abbrechen")
                    ),
                  ]
                ),
              );
        });
  }
}
