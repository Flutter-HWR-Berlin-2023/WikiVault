import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/bookmark_bloc.dart';
import 'package:wiki_vault/src/views/widgets/bookmark/bookmark_list.dart';
import 'package:wiki_vault/src/views/widgets/loading.dart';
import 'package:wiki_vault/src/views/widgets/sidebar.dart';

// Displays the list of user-side saved articles to be accessed offline and in full as needed
class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lesezeichen"),
      ),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          if (state.status == BookmarkStatus.standby) {
            if (state.bookmarksEmpty()) {
              return const Center(child: Text('Keine Lesezeichen', style: TextStyle(fontSize: 18)));
            }
            return BookmarkList(state.getGroups(), state.getArticles());
          }
          return const Center(child: Loading());
        },
      ),
      drawer: Sidebar.bookmark(),
    );
  }
}
