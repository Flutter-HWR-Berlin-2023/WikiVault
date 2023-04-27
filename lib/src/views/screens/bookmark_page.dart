import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/bookmark_bloc.dart';
import 'package:wiki_vault/src/views/widgets/bookmark/bookmark_list.dart';
import 'package:wiki_vault/src/views/widgets/general/loading.dart';
import 'package:wiki_vault/src/views/widgets/general/sidebar.dart';
import 'package:wiki_vault/src/core/messages.dart' as app_msg;

/// Bookmark Page to list all bookmarked articles
class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  PreferredSizeWidget _appbar() {
    return AppBar(
      title: const Text(app_msg.bookmarkPage),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        switch (state.status) {
          case BookmarkStatus.initial:
          case BookmarkStatus.loading:
            return const Center(child: Loading());
          case BookmarkStatus.standby:
            if (state.isBookmarksEmpty()) {
              return const Center(child: Text(app_msg.noBookmarks, style: TextStyle(fontSize: 18)));
            }
            return BookmarkList(
                articleList: state.getArticles()
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(context),
      drawer: Sidebar.bookmark(),
    );
  }
}