import 'package:wiki_vault/src/bloc/bookmark_bloc.dart';
import 'package:wiki_vault/src/bloc/search_bloc.dart';
import 'package:wiki_vault/src/core/routes.dart';
import 'package:wiki_vault/src/models/article.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/models/article_group.dart';
import 'package:wiki_vault/src/core/messages.dart' as app_msg;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive database
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  Hive.registerAdapter(ArticleGroupAdapter());
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
          title: app_msg.appName,
          onGenerateRoute: (routeSettings) => Routes.onGenerateRoute(routeSettings),
          initialRoute: '/splash',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
            appBarTheme: const AppBarTheme(
              color: Colors.redAccent,
            ),
            primaryColor: Colors.redAccent
          ),
          debugShowCheckedModeBanner: false,
        )
    );
  }
}
