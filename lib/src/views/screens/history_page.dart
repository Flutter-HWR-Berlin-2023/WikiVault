import 'package:flutter/material.dart';

import '../widgets/general/sidebar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  PreferredSizeWidget _appbar() {
    return AppBar(
      title: const Text("Verlauf"),
    );
  }

  Widget _body(BuildContext context) {
    return const Center(child: Text('Kein Verlauf'));
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