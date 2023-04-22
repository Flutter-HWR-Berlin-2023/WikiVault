import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wiki_vault/src/views/widgets/sidebar.dart';
import 'package:wiki_vault/src/core/messages.dart' as app_msg;

// Mockup page for app's general and search settings
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  PreferredSizeWidget _appbar() {
    return AppBar(
      title: const Text(app_msg.settingsPage),
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
              value: const Text('Deutsch'),
              enabled: false,
            ),
            SettingsTile.switchTile(
              onToggle: (value) {},
              initialValue: true,
              leading: const Icon(Icons.text_snippet),
              title: const Text('Textausschnitt'),
              description: const Text('Ausschnitt des Artikels'),
              enabled: false,
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
