import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:wiki_vault/src/models/article.dart';
import 'package:wiki_vault/src/models/search.dart';

part 'search_event.dart';
part 'search_state.dart';

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

  Future<void> _init(SearchInit event, Emitter<SearchState> emit) async {
    _loadSettings();
    emit(state.copyWith(status: SearchStatus.standby));
  }

  Future<void> _settings(SearchSettings event, Emitter<SearchState> emit) async {
    _loadSettings();
  }

  void _loadSettings() {

  }



  Future<void> _searchTerm(SearchTerm event, Emitter<SearchState> emit) async {
    if (state.status == SearchStatus.initial || state.status == SearchStatus.searching || state.status == SearchStatus.continuing) return;
    if (event.searchTerm.isEmpty) return;
    emit(state.copyWith(status: SearchStatus.searching));

    List<Search> results = await _fetchSearch(event.searchTerm, '0');
    results = await _fetchExtracts(results);
    Map<int, Article> articles = {};

    emit(state.newSearch(true, event.searchTerm, results.length, results, articles));
  }

  Future<void> _continue(SearchContinue event, Emitter<SearchState> emit) async {
    if (state.status == SearchStatus.initial || state.status == SearchStatus.searching || state.status == SearchStatus.continuing) return;
    if (!state.canContinue) return;
    emit(state.copyWith(status: SearchStatus.continuing));

    List<Search> results = await _fetchSearch(state.lastSearchTerm, state.offset.toString());
    results = await _fetchExtracts(results);
    Map<int, Article> articles = {};

    emit(state.continueSearch(false, state.results.length + results.length, results, articles));
  }

  Future<List<Search>> _fetchSearch(String searchTerm, String offset) async {
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
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return (responseJson['query']['pages'] as List).map((elem) => Search.fromJson(elem)).toList();
    }
    return [];
  }

  Future<List<Search>> _fetchExtracts(List<Search> searches) async {
    if (searches.isEmpty) return [];
    String pageIDs = searches.map((e) => e.pageID).join('|');
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
      List<Search> newSearches = [];
      for (var elem in (responseJson['query']['pages'] as List)) {
        newSearches.add(searches.firstWhere((element) => element.pageID == elem['pageid']).copyWith(extract: elem['extract']));
      }
      return newSearches;
    }
    return searches;
  }



  Future<void> _getArticle(SearchGetArticle event, Emitter<SearchState> emit) async {
    Map<int, Article> articles = state.articles;
    Map<int, Article> newArticle = await _fetchArticle(event.pageID);
    articles.addAll(newArticle);

    emit(state.copyWith(status: SearchStatus.continuing, articles: articles));
    emit(state.copyWith(status: SearchStatus.standby));
  }

  // https://en.wikipedia.org/api/rest_v1/page/mobile-sections/Eath

  Future<Map<int, Article>> _fetchArticle(int pageID) async {
    final response = await httpClient.get(
      Uri.https(
        'de.wikipedia.org',
        'w/api.php',
        {
          'action': 'query',
          'format': 'json',
          'prop': 'extracts|pageterms',
          'formatversion': '2',
          'pageids': pageID.toString()
        },
      ),
    );
    Map<int, Article> articles = {};
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (var elem in (responseJson['query']['pages'] as List)) {
        Article article = Article.fromJson(elem);
        articles[article.pageID] = article;
      }
    }
    return articles;
  }



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
