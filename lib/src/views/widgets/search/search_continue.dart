import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/search_bloc.dart' as bloc;
import 'package:wiki_vault/src/core/messages.dart' as app_msg;

/// Stateless widget displaying a button with a circular progress indicator if 'continues' is true,
/// otherwise displays a button with text "MEHR LADEN" and triggers a search event when pressed.
class SearchContinue extends StatelessWidget {
  const SearchContinue({required this.continues, Key? key}) : super(key: key);
  final bool continues; // whether or not the user is currently searching

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 35.0),
      child: Center(
        child: continues
            ? ElevatedButton(
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent)),
                onPressed: () { },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              )
            : ElevatedButton(
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent)),
                onPressed: () => BlocProvider.of<bloc.SearchBloc>(context).add(bloc.SearchContinue(context)),
                child: const Text(app_msg.continueButton),
              ),
      ),
    );
  }
}
