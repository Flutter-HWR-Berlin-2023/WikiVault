import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/bookmark_bloc.dart';
import 'package:wiki_vault/src/models/article.dart';
import 'package:wiki_vault/src/views/widgets/dialog.dart';

class BookmarkEdit extends StatefulWidget {
  const BookmarkEdit({required this.article, Key? key}) : super(key: key);
  final Article article;

  @override
  State<BookmarkEdit> createState() => _BookmarkEditState();
}

class _BookmarkEditState extends State<BookmarkEdit> {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  void initState() {
    super.initState();
    _title.text = widget.article.title;
    _description.text = widget.article.description ?? "";
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
        onPressed: () => showDialogScreen(
            context: context,
            title: "Lesezeichen Ändern",
            content: Column(
              children: [
                Text('Änderungen von ' + widget.article.title),
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(5, 20, 20, 5),
                  title: const Text("Titel", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: TextField(
                    controller: _title,
                    decoration: const InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(5, 20, 20, 50),
                  title: const Text("Beschreibung", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: TextField(
                    controller: _description,
                    decoration: const InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  onPressed: () {
                    String? description = _description.text.isNotEmpty ? _description.text : null;
                    BlocProvider.of<BookmarkBloc>(context).add(AddBookmark(context, widget.article.copyWith(title: _title.text, description: description)));
                    Navigator.pop(context);
                  },
                  child: const Text("Ändern")
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Abbrechen")
              ),
            ]
        ),
        child: const Icon(Icons.edit)
    );
  }
}
