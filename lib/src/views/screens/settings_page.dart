import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiki_vault/src/bloc/search_bloc.dart';
import 'package:wiki_vault/src/views/widgets/general/dialog.dart';
import 'package:wiki_vault/src/views/widgets/general/sidebar.dart';
import 'package:wiki_vault/src/core/messages.dart' as app_msg;

/// Page for app's general and search settings
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool useExtract;
  late int limit;
  late String language;

  @override
  void initState() {
    super.initState();
    SearchState state = BlocProvider.of<SearchBloc>(context).state;
    useExtract = state.useExtract;
    limit = state.limit;
    language = state.language;
  }


  // Methods for setting and saving new Settings

  _saveUseExtract(bool use) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('useExtract', use);
    BlocProvider.of<SearchBloc>(context).add(SearchSettings());
    setState(() {
      useExtract = use;
    });
  }

  _saveLimit(int limit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('limit', limit);
    BlocProvider.of<SearchBloc>(context).add(SearchSettings());
    setState(() {
      this.limit = limit;
    });
  }

  _saveLanguage(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    BlocProvider.of<SearchBloc>(context).add(SearchSettings());
    setState(() {
      this.language = language;
    });
  }


  // Design of Page

  PreferredSizeWidget _appbar() {
    return AppBar(
      title: const Text(app_msg.settingsPage),
    );
  }

  Padding _dialogButton(String title, bool isActive, Function onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
          style: (isActive)
              ? ElevatedButton.styleFrom(backgroundColor: Colors.redAccent)
              : ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: () => onPressed(),
          child: Text(title)
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text(app_msg.generalSection, style: TextStyle(color: Colors.red)),
          tiles: [
            SettingsTile.navigation(
              leading: const Icon(Icons.language),
              title: const Text('Sprache der Anwendung'),
              value: const Text('Deutsch'),
              enabled: false,
            ),
            SettingsTile.switchTile(
              onToggle: (value) {},
              initialValue: false,
              leading: const Icon(Icons.format_paint),
              title: const Text('Benutzerdefiniertes Design'),
              enabled: false,
            ),
          ],
        ),
        SettingsSection(
          title: const Text(app_msg.searchSection, style: TextStyle(color: Colors.red)),
          tiles: [
            SettingsTile.navigation(
              leading: const Icon(Icons.language),
              title: const Text('Sprache der Artikel'),
              value: Text((language == 'de') ? 'Deutsch' : 'English'),
              onPressed: (context) => showDialogScreen(
                  context: context,
                  title: 'In welcher Sprache sollen die Artikel sein?',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _dialogButton("Deutsch", language == 'de', () { _saveLanguage('de'); Navigator.pop(context); }),
                      _dialogButton("English", language == 'en', () { _saveLanguage('en'); Navigator.pop(context); }),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Abbrechen")
                    ),
                  ]
              ),
            ),
            SettingsTile.switchTile(
              initialValue: useExtract,
              leading: const Icon(Icons.text_snippet),
              title: const Text('Textausschnitt'),
              description: const Text('Ausschnitt des Artikels'),
              onToggle: (value) => _saveUseExtract(value),
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.search),
              title: const Text('Limit von Artikel'),
              value: Text(limit.toString()),
              onPressed: (context) => showDialogScreen(
                  context: context,
                  title: 'Limit von Artikel',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _dialogButton("5", limit == 5, () { _saveLimit(5); Navigator.pop(context); }),
                      _dialogButton("10", limit == 10, () { _saveLimit(10); Navigator.pop(context); }),
                      _dialogButton("15", limit == 15, () { _saveLimit(15); Navigator.pop(context); }),
                      _dialogButton("20", limit == 20, () { _saveLimit(20); Navigator.pop(context); }),
                      _dialogButton("25", limit == 25, () { _saveLimit(25); Navigator.pop(context); }),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Abbrechen")
                    ),
                  ]
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(context),
      drawer: Sidebar.settings(),
    );
  }
}
