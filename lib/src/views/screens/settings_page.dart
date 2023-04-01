import 'package:flutter/material.dart';

import '../widgets/general/sidebar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  PreferredSizeWidget _appbar() {
    return AppBar(
      title: const Text("Einstellungen"),
    );
  }

  Widget _body(BuildContext context) {
    return const Center(child: Text('Keine Einstellungen vorhanden'));
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