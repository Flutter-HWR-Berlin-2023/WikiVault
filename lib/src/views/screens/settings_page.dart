import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wiki_vault/src/views/widgets/sidebar.dart';

// Mockup page for app's general and search settings
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Einstellungen"),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Allgemein', style: TextStyle(color: Colors.red)),
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
            title: const Text('Suche', style: TextStyle(color: Colors.red)),
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
      ),
      drawer: Sidebar.settings(),
    );
  }
}
