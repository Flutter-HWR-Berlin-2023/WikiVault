import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/search_bloc.dart' as bloc;

class SearchContinue extends StatelessWidget {
  const SearchContinue(this.isContinuing, {Key? key}) : super(key: key);
  final bool isContinuing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 35.0),
      child: Center(
        child: isContinuing
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
                onPressed: () => BlocProvider.of<bloc.SearchBloc>(context).add(bloc.SearchContinue()),
                child: const Text("MEHR LADEN"),
              ),
      ),
    );
  }
}
