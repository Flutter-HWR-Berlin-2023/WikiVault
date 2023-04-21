import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wiki_vault/src/models/article.dart';

// Displaying an article in full
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(child: Html(data: article.article))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appbar(context), body: _body(context));
  }
}
