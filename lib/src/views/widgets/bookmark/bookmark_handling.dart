import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/bookmark_bloc.dart';
import 'package:wiki_vault/src/models/article.dart';
import 'package:wiki_vault/src/views/widgets/general/dialog.dart';
import 'package:wiki_vault/src/core/messages.dart' as app_msg;

/// Stateless widget displaying a bookmark button
/// button changes color based on whether article is bookmarked, adding/removing the article from bookmarks when pressed based on state
class BookmarkHandling extends StatelessWidget {
  const BookmarkHandling({required this.article, Key? key}) : super(key: key);
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
                      title: app_msg.removeBookmark,
                      content: Text(app_msg.buttonRemoveBookmark(article.title)),
                      actions: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                            onPressed: () {
                              BlocProvider.of<BookmarkBloc>(context).add(RemoveBookmark(context, article));
                              Navigator.pop(context);
                            },
                            child: const Text(app_msg.remove)
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                            onPressed: () => Navigator.pop(context),
                            child: const Text(app_msg.cancel)
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
                  title: app_msg.addBookmark,
                  content: Text(app_msg.buttonAddBookmark(article.title)),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        onPressed: () {
                          BlocProvider.of<BookmarkBloc>(context).add(AddBookmark(context, article));
                          Navigator.pop(context);
                        },
                        child: const Text(app_msg.add)
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(app_msg.cancel)
                    ),
                  ]
                ),
              );
        });
  }
}
