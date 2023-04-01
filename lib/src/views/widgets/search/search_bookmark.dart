import 'package:flutter/material.dart';

class SearchBookmark extends StatelessWidget {
  const SearchBookmark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(child: const Icon(Icons.bookmark), style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent)), onPressed: () {});
  }
}
