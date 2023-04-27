import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wiki_vault/src/models/article.dart';

/// Displaying an article in full
class ArticlePage extends StatelessWidget {
  const ArticlePage({required this.article, Key? key}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(article.title),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(child: Html(data: article.article))
        )
    );
  }
}
