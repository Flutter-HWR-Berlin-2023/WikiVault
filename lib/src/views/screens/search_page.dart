import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/search_bloc.dart';
import 'package:wiki_vault/src/views/widgets/general/loading.dart';
import 'package:wiki_vault/src/views/widgets/search/search_list.dart';

import '../widgets/general/sidebar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();

  PreferredSizeWidget _appbar() {
    return AppBar(
      title: SizedBox(
          height: 40,
          child: TextField(
            controller: search,
            textInputAction: TextInputAction.search,
            onSubmitted: (String text) => BlocProvider.of<SearchBloc>(context).add(SearchTerm(text)),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, style: BorderStyle.solid),
                //borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              hintText: 'Suchen...',
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(10),
            ),
          )),
      actions: <Widget>[IconButton(onPressed: () => BlocProvider.of<SearchBloc>(context).add(SearchTerm(search.text)), icon: const Icon(Icons.search))],
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
            if (state.lastSearchTerm.isEmpty) {
              return const Center(child: Text('Suche nach Artikeln!'));
            }
            if (state.results.isEmpty) {
              return const Center(child: Text('Keine Ergebnisse'));
            }
            return SearchList(list: state.results, canContinue: state.canContinue);
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