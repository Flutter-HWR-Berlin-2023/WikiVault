import 'package:flutter/material.dart';
import 'package:wiki_vault/src/models/article.dart';
import 'package:html/parser.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage(this.article, {Key? key}) : super(key: key);
  final Article article;

  PreferredSizeWidget _appbar(BuildContext context) {
    return AppBar(
      title: Text(article.title),
      leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
    );
  }

  Widget _body(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
        child: Text(parse(article.article).documentElement!.text)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _body(context)
    );
  }
}