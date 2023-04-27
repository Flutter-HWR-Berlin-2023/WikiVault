import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/search_bloc.dart';
import 'package:wiki_vault/src/views/widgets/general/loading.dart';
import 'package:wiki_vault/src/views/widgets/search/search_list.dart';
import 'package:wiki_vault/src/views/widgets/general/sidebar.dart';
import 'package:wiki_vault/src/core/messages.dart' as app_msg;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

/// Main search screen to search for and display articles
/// Displays list of search results and allows for navigation to article pages
/// Allows for saving articles to bookmarks and/or accessing their brief info
class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();

  PreferredSizeWidget _appbar() {
    return AppBar(
      title: SizedBox(
          height: 40,
          child: TextField(
            controller: search,
            textInputAction: TextInputAction.search,
            onSubmitted: (String text) => BlocProvider.of<SearchBloc>(context).add(SearchTerm(context, text)),
            cursorColor: Colors.redAccent,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(width: 0.5, style: BorderStyle.solid)), // custom border for text field
              hintText: app_msg.searchHint,
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(15),
            ),
          )),
      actions: <Widget>[
        IconButton(onPressed: () => BlocProvider.of<SearchBloc>(context).add(SearchTerm(context, search.text)), icon: const Icon(Icons.search))
      ],
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchStatus.initial:
          case SearchStatus.searching:
            return const Center(child: Loading());
          case SearchStatus.standby:
          case SearchStatus.continuing:
            // Default screen
            if (state.lastSearchTerm.isEmpty) {
              return const Center(child: Text(app_msg.searchAppeal, style: TextStyle(fontSize: 18)));
            }
            // Message on empty search results
            if (state.results.isEmpty) {
              return const Center(child: Text(app_msg.searchNoResults, style: TextStyle(fontSize: 18)));
            }
            // Render search results otherwise
            return SearchList(
                searches: state.results,
                articles: state.articles,
                canContinue: state.canContinue,
                continues: state.status == SearchStatus.continuing
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
      drawer: Sidebar.search(),
    );
  }
}
