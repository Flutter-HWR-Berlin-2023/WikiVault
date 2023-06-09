import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/search_bloc.dart';
import 'package:wiki_vault/src/models/article.dart';
import 'package:wiki_vault/src/views/widgets/bookmark/bookmark_handling.dart';
import 'package:wiki_vault/src/views/widgets/general/sidebar.dart';
import 'package:wiki_vault/src/core/messages.dart' as app_msg;

/// History page lists those articles that have been accessed in fulltext
/// Per article, the list will show only the most recent access
class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Article> history = <Article>[];

  @override
  void initState() {
    super.initState();
    history = BlocProvider.of<SearchBloc>(context).state.history.reversed.toList();
  }

  PreferredSizeWidget _appbar() {
    return AppBar(
      title: const Text(app_msg.historyPage),
    );
  }

  Widget _body(BuildContext context) {
    if (history.isEmpty) return const Center(child: Text(app_msg.noHistory, style: TextStyle(fontSize: 18)));
    return ListView.separated(
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() { history.removeAt(index); });
            BlocProvider.of<SearchBloc>(context).add(SearchRemoveHistory(item.pageID));
          },
          background: Container(
            color: Colors.redAccent,
            child: Row(
              children: [
                const Icon(Icons.delete),
                Expanded(child: Container()),
                const Icon(Icons.delete),
              ],
            )
          ),
          child: ListTile(
              title: Text(item.title),
              subtitle: item.description != null ? Text(item.description![0].toUpperCase() + item.description!.substring(1).toLowerCase()) : null,
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  BookmarkHandling(article: item),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                    onPressed: () {
                      setState(() { history.removeAt(index); });
                      BlocProvider.of<SearchBloc>(context).add(SearchRemoveHistory(item.pageID));
                    },
                    child: const Icon(Icons.clear))
                ],
              ),
            onTap: () => Navigator.of(context).pushNamed('/article', arguments: item),
          ),
        );
      },
      separatorBuilder: (_, index) {
        return const Divider(color: Colors.grey);
      },
      controller: ScrollController(), // to enable scroll physics
      physics: const BouncingScrollPhysics(), // realizing Android scroll haptics
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(context),
      drawer: Sidebar.history(), // activate the history tab in the sidebar
    );
  }
}
