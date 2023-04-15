import 'package:flutter/material.dart';
import 'package:wiki_vault/src/core/messages.dart' as msg;

enum Pages {
  search,
  bookmark,
  history,
  settings
}

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key, required this.page}) : super(key: key);
  final Pages page;

  static Sidebar search() {return const Sidebar(page: Pages.search);}
  static Sidebar bookmark() {return const Sidebar(page: Pages.bookmark);}
  static Sidebar history() {return const Sidebar(page: Pages.history);}
  static Sidebar settings() {return const Sidebar(page: Pages.settings);}

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icon.png', height: 30),
                    const SizedBox(width: 5),
                    const Text('WikiVault', style: TextStyle(fontSize: 16))
                  ],
                ),
                const Divider(),
                _menuButton(msg.searchPage, Icons.search, Pages.search == page, () {
                  Navigator.of(context).pop();
                  Future.delayed(const Duration(milliseconds: 150), () {
                    Navigator.of(context).pushReplacementNamed('/search');
                  });
                }),
                _menuButton(msg.bookmarkPage, Icons.favorite, Pages.bookmark == page, () {
                  Navigator.of(context).pop();
                  Future.delayed(const Duration(milliseconds: 150), () {
                    Navigator.of(context).pushReplacementNamed('/bookmark');
                  });
                }),
                _menuButton(msg.historyPage, Icons.history, Pages.history == page, () {
                  Navigator.of(context).pop();
                  Future.delayed(const Duration(milliseconds: 150), () {
                    Navigator.of(context).pushReplacementNamed('/history');
                  });
                }),
                const Divider(),
                _menuButton(msg.settingsPage, Icons.settings, Pages.settings == page, () {
                  Navigator.of(context).pop();
                  Future.delayed(const Duration(milliseconds: 150), () {
                    Navigator.of(context).pushReplacementNamed('/settings');
                  });
                }),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Column(
                children: <Widget>[
                  _menuButton('Hilfe', Icons.help, false, () {
                  Navigator.of(context).pop();
                  Future.delayed(const Duration(milliseconds: 150), () {
                    showAboutDialog(
                        context: context,
                        applicationName: "WikiVault",
                        applicationVersion: '1.0',
                        applicationIcon: Image.asset('assets/icon.png', height: 40),
                        applicationLegalese: "Diese App wurde für den Kurs Flutter erstellt");
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
