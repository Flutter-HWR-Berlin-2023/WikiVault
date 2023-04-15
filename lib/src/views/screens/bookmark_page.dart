import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/bookmark_bloc.dart';
import 'package:wiki_vault/src/views/widgets/bookmark/bookmark_list.dart';
import 'package:wiki_vault/src/views/widgets/loading.dart';
import 'package:wiki_vault/src/views/widgets/sidebar.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  PreferredSizeWidget _appbar() {
    return AppBar(
      title: const Text("Lesezeichen"),
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
            if (state.bookmarksEmpty()) {
              return const Center(child: Text('Keine Lesezeichen', style: TextStyle(fontSize: 18)));
            }
            return BookmarkList(state.getGroups(), state.getArticles());
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
