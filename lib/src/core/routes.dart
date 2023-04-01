import 'package:flutter/material.dart';
import 'package:wiki_vault/src/models/article.dart';
import 'package:wiki_vault/src/views/screens/article_page.dart';
import 'package:wiki_vault/src/views/screens/bookmark_page.dart';
import 'package:wiki_vault/src/views/screens/history_page.dart';
import 'package:wiki_vault/src/views/screens/search_page.dart';
import 'package:wiki_vault/src/views/screens/settings_page.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name!) {
      case "/bookmark":
        return FadeTransitionRoute<bool>(builder: (BuildContext context) => const BookmarkPage(), settings: settings);
      case "/search":
        return FadeTransitionRoute<bool>(builder: (BuildContext context) => const SearchPage(), settings: settings);
      case "/history":
        return FadeTransitionRoute<bool>(builder: (BuildContext context) => const HistoryPage(), settings: settings);
      case "/settings":
        return FadeTransitionRoute<bool>(builder: (BuildContext context) => const SettingsPage(), settings: settings);
      case "/article":
        return SlideTransitionRoute<bool>(builder: (BuildContext context) => ArticlePage(settings.arguments as Article), settings: settings);
      default:
        return FadeTransitionRoute<bool>(builder: (BuildContext context) => const SearchPage(), settings: settings);
    }
  }
}

class FadeTransitionRoute<T> extends MaterialPageRoute<T> {
  FadeTransitionRoute({required WidgetBuilder builder, RouteSettings? settings}) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
        child: child
    );
  }
}

class SlideTransitionRoute<T> extends MaterialPageRoute<T> {
  SlideTransitionRoute({required WidgetBuilder builder, RouteSettings? settings}) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0)).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
      child: child,
    );
  }
}
