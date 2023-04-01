import 'package:wiki_vault/src/bloc/bookmark_bloc.dart';
import 'package:wiki_vault/src/bloc/search_bloc.dart';
import 'package:wiki_vault/src/core/routes.dart';
import 'package:wiki_vault/src/models/article.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  runApp(const WikiVault());
}

class WikiVault extends StatelessWidget {
  const WikiVault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(lazy: false, create: (BuildContext context) => SearchBloc()..add(SearchInit())),
          BlocProvider(lazy: false, create: (BuildContext context) => BookmarkBloc()..add(BookmarkInit())),
        ],
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: Colors.redAccent,
            ),
            primaryColor: Colors.redAccent,
            scaffoldBackgroundColor: Colors.white,
          ),
          title: 'WikiVault',
          onGenerateRoute: (routeSettings) => Routes.onGenerateRoute(routeSettings),
          initialRoute: '/search'
        )
    );
  }
}
