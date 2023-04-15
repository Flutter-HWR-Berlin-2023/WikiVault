import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wiki_vault/src/bloc/search_bloc.dart';
import 'package:wiki_vault/src/models/article.dart';
import 'package:wiki_vault/src/models/search.dart';
import 'package:wiki_vault/src/views/widgets/search/search_bookmark.dart';

class SearchItem extends StatefulWidget {
  const SearchItem(this.search, this.article, {Key? key}) : super(key: key);
  final Search search;
  final Article article;

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasArticle = widget.article.pageID != 0;
    final bool hasExtract = widget.search.extract != null && widget.search.extract!.isNotEmpty;
    final bool closed = !_isExpanded && _controller.isDismissed;
    if (!closed && hasArticle) {
      _isExpanded = false;
      _controller.reverse().then<void>((void value) {
        if (!mounted) return;
        setState(() {});
      });
    }

    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget? child) {
        return Column(
            children: <Widget>[
              ListTileTheme.merge(
                child: hasArticle
                    ? ListTile(
                    title: Text(widget.search.title, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
                    subtitle: widget.search.description != null ? Text(widget.search.description![0].toUpperCase() + widget.search.description!.substring(1).toLowerCase()) : null,
                    trailing: SearchBookmark(widget.article),
                    onLongPress: () => Navigator.of(context).pushNamed('/article', arguments: widget.article),
                  )
                : ListTile(
                  onTap: () => setState(() {
                    if (!hasExtract) return;
                    _isExpanded = !_isExpanded;
                    if (_isExpanded) {
                      _controller.forward();
                    } else {
                      _controller.reverse().then<void>((void value) {
                        if (!mounted) return;
                        setState(() {});
                      });
                    }
                    PageStorage.of(context)?.writeState(context, _isExpanded);
                  }),
                  title: Text(widget.search.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: widget.search.description != null ? Text(widget.search.description![0].toUpperCase() + widget.search.description!.substring(1).toLowerCase()) : null,
                  onLongPress: () => BlocProvider.of<SearchBloc>(context).add(SearchGetArticle(widget.search.pageID)),
                ),
              ),
              ClipRect(
                child: Align(
                  alignment: Alignment.center,
                  heightFactor: _heightFactor.value,
                  child: child,
                ),
              ),
            ],
          );
      },
      child: closed ? null : Offstage(
        offstage: closed,
        child: TickerMode(
          enabled: !closed,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Html(data: widget.search.extract!.substring(widget.search.extract!.indexOf('<p>'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
