import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_vault/src/bloc/search_bloc.dart' as bloc;

class SearchContinue extends StatelessWidget {
  const SearchContinue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => BlocProvider.of<bloc.SearchBloc>(context).add(bloc.SearchContinue()),
        child: const Text("Continue"),
      ),
    );
  }
}