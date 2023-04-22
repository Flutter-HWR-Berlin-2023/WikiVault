import 'package:flutter/material.dart';
import 'package:wiki_vault/src/core/messages.dart' as app_msg;

enum Pages {
  search,
  bookmark,
  history,
  settings
}

// Navigation drawer for the app's main pages
class Sidebar extends StatelessWidget {
  const Sidebar({required this.page, Key? key}) : super(key: key);
  final Pages page;

  // Each of these activate respective entry in navigation drawer
  static Sidebar search() => const Sidebar(page: Pages.search);
  static Sidebar bookmark() => const Sidebar(page: Pages.bookmark);
  static Sidebar history() => const Sidebar(page: Pages.history);
  static Sidebar settings() => const Sidebar(page: Pages.settings);

  ListTile _menuButton(String title, IconData icon, bool isActive, Function onPressed) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.redAccent : Colors.black),
      title: Text(title, style: TextStyle(fontSize: 20, color: isActive ? Colors.redAccent : Colors.black)),
      onTap: () => onPressed()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                // Heading the navigation drawer: WikiVault logo and name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(app_msg.appAssetIcon, height: 30),
                    const SizedBox(width: 5),
                    const Text(app_msg.appName, style: TextStyle(fontSize: 16))
                  ],
                ),
                const Divider(),
                // List the main pages of the app
                _menuButton(app_msg.searchPage, Icons.search, Pages.search == page, () {
                  Navigator.of(context).pop();
                  Future.delayed(const Duration(milliseconds: 150), () {
                    Navigator.of(context).pushReplacementNamed('/search');
                  });
                }),
                _menuButton(app_msg.bookmarkPage, Icons.bookmark, Pages.bookmark == page, () {
                  Navigator.of(context).pop();
                  Future.delayed(const Duration(milliseconds: 150), () {
                    Navigator.of(context).pushReplacementNamed('/bookmark');
                  });
                }),
                _menuButton(app_msg.historyPage, Icons.history, Pages.history == page, () {
                  Navigator.of(context).pop();
                  Future.delayed(const Duration(milliseconds: 150), () {
                    Navigator.of(context).pushReplacementNamed('/history');
                  });
                }),
                const Divider(),
                _menuButton(app_msg.settingsPage, Icons.settings, Pages.settings == page, () {
                  Navigator.of(context).pop();
                  Future.delayed(const Duration(milliseconds: 150), () {
                    Navigator.of(context).pushReplacementNamed('/settings');
                  });
                }),
              ],
            ),
            // Help button at the bottom of the navigation drawer
            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Column(
                children: <Widget>[
                  _menuButton(app_msg.help, Icons.help, false, () {
                  Navigator.of(context).pop();
                  Future.delayed(const Duration(milliseconds: 150), () {
                    showAboutDialog(
                        context: context,
                        applicationName: app_msg.appName,
                        applicationVersion: app_msg.appVersion,
                        applicationIcon: Image.asset(app_msg.appAssetIcon, height: 40),
                        applicationLegalese: app_msg.appLegalese);
                  });
                })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
