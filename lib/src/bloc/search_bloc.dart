import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:wiki_vault/src/models/article.dart';
import 'package:wiki_vault/src/models/search.dart';
import 'package:wiki_vault/src/views/widgets/snackbar.dart';

part 'search_event.dart';
part 'search_state.dart';

// SearchBloc implements asynchronous methods for fetching and processing search results and articles 
// from the uniquely behaving Wikipedia API
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<SearchInit>(_init);
    on<SearchSettings>(_settings);
    on<SearchTerm>(_searchTerm);
    on<SearchContinue>(_continue);
    on<SearchGetArticle>(_getArticle);
    on<SearchAddHistory>(_addHistory);
    on<SearchRemoveHistory>(_removeHistory);
  }

  final http.Client httpClient = http.Client();


  // Startup and Settings

  Future<void> _init(SearchInit event, Emitter<SearchState> emit) async {
    await _loadSettings();
    emit(state.copyWith(
        status: SearchStatus.standby
    ));
  }

  Future<void> _settings(SearchSettings event, Emitter<SearchState> emit) async {
    await _loadSettings();
    emit(state.copyWith(
        status: SearchStatus.standby
    ));
  }

  Future<void> _loadSettings() async {

  }



  // Searching for Articles on Wikipedia

  Future<void> _searchTerm(SearchTerm event, Emitter<SearchState> emit) async {
    if (state.status == SearchStatus.initial || state.status == SearchStatus.searching || state.status == SearchStatus.continuing) return;
    if (event.searchTerm.isEmpty) return;
    emit(state.copyWith(status: SearchStatus.searching));

    List<Search> results = await _fetchSearch(event.context, event.searchTerm, "0");
    results = await _fetchExtracts(event.context, results);

    emit(state.copyWith(
        status: SearchStatus.standby,
        canContinue: true,
        lastSearchTerm: event.searchTerm,
        offset: results.length,
        results: results,
        articles: {}
    ));
  }

  Future<void> _continue(SearchContinue event, Emitter<SearchState> emit) async {
    if (state.status == SearchStatus.initial || state.status == SearchStatus.searching || state.status == SearchStatus.continuing) return;
    if (!state.canContinue) return;
    emit(state.copyWith(status: SearchStatus.continuing));

    List<Search> results = await _fetchSearch(event.context, state.lastSearchTerm, state.offset.toString());
    results = await _fetchExtracts(event.context, results);

  emit(state.copyWith(
      status: SearchStatus.standby,
      canContinue: false,
      offset: state.results.length + results.length,
      results: state.results..addAll(results),
  ));
  }

  Future<List<Search>> _fetchSearch(BuildContext context, String searchTerm, String offset) async {
    List<Search> searches = [];
    try {
      final response = await httpClient.get(
        Uri.https(
          'de.wikipedia.org',
          'w/api.php',
          {
            'action': 'query',
            'format': 'json',
            'prop': 'description',
            'generator': 'search',
            'formatversion': '2',
            'gsrsearch': searchTerm,
            'gsrlimit': '20',
            'gsroffset': offset,
            'gsrprop': 'size|wordcount|timestamp|snippet',
            'gsrsort': 'just_match',
          },
        ),
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        searches = (responseJson['query']['pages'] as List).map((elem) => Search.fromJson(elem)).toList();
      }
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBarError("Fehler beim Abrufen des Artikels"));
    } on SocketException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBarError("Es konnte keine Verbindung hergestellt werden"));
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBarError("Verbindung Zeit überschritten"));
    }
    return searches;
  }

  Future<List<Search>> _fetchExtracts(BuildContext context, List<Search> searchList) async {
    List<Search> searches = [];
    if (searchList.isEmpty) return [];
    String pageIDs = searchList.map((e) => e.pageID).join('|');
    try {
      final response = await httpClient.get(
        Uri.https(
          'de.wikipedia.org',
          'w/api.php',
          {
            'action': 'query',
            'format': 'json',
            'prop': 'extracts|sections|displaytitle',
            'formatversion': '2',
            'exintro': '1',
            'pageids': pageIDs
          },
        ),
      );
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        for (var elem in (responseJson['query']['pages'] as List)) {
          searches.add(searchList.firstWhere((element) => element.pageID == elem['pageid']).copyWith(extract: elem['extract']));
        }
      }
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBarError("Fehler beim Abrufen des Artikels"));
    } on SocketException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBarError("Es konnte keine Verbindung hergestellt werden"));
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBarError("Verbindung Zeit überschritten"));
    }
    return searches;
  }



  // Fetch complete Article on Wikipedia

  Future<void> _getArticle(SearchGetArticle event, Emitter<SearchState> emit) async {
    Map<int, Article> articles = state.articles;
    Map<int, Article> newArticle = await _fetchArticle(event.context, event.search);
    if (newArticle.isEmpty) return;

    articles.addAll(newArticle);
    articles[event.search.pageID] = (articles[event.search.pageID]!).copyWith(description: event.search.description);

    emit(state.copyWith(status: SearchStatus.continuing, articles: articles));
    emit(state.copyWith(status: SearchStatus.standby));
  }

  Future<Map<int, Article>> _fetchArticle(BuildContext context, Search search) async {
    Map<int, Article> articles = {};
    try {
      final response = await httpClient.get(
        Uri.https(
          'de.wikipedia.org',
          'w/api.php',
          {
            'action': 'query',
            'format': 'json',
            'prop': 'extracts|pageterms',
            'formatversion': '2',
            'pageids': search.pageID.toString()
          },
        ),
      );
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        for (var elem in (responseJson['query']['pages'] as List)) {
          Article article = Article.fromJson(elem);
          articles[article.pageID] = article;
        }
      }
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBarError("Fehler beim Abrufen des Artikels"));
    } on SocketException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBarError("Es konnte keine Verbindung hergestellt werden"));
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBarError("Verbindung Zeit überschritten"));
    }
    return articles;
  }



  // Methods for History

  void _addHistory(SearchAddHistory event, Emitter<SearchState> emit) async {
    List<Article> newHistory = state.history.toList(growable: true);
    newHistory.removeWhere((element) => element.pageID == event.article.pageID);
    newHistory.add(event.article);

    emit(state.copyWith(history: newHistory));
  }

  void _removeHistory(SearchRemoveHistory event, Emitter<SearchState> emit) async {
    List<Article> newHistory = state.history.toList(growable: true);
    newHistory.removeWhere((element) => element.pageID == event.pageID);
    
    emit(state.copyWith(history: newHistory));
  }
}
