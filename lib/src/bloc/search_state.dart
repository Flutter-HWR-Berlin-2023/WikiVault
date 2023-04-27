part of 'search_bloc.dart';

enum SearchStatus { initial, standby, searching, continuing }

/// SearchState class to manage the state of a search, including the search status, search results, articles, and search history
class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.canContinue = false,
    this.lastSearchTerm = '',
    this.useExtract = true,
    this.offset = 0,
    this.limit = 15,
    this.language = 'de',
    this.results = const <Search>[],
    this.articles = const <int, Article>{},
    this.history = const <Article>[]
  });

  final SearchStatus status;
  final bool canContinue;
  final String lastSearchTerm;
  final bool useExtract;
  final int offset;
  final int limit;
  final String language;
  final List<Search> results;
  final Map<int, Article> articles;
  final List<Article> history;

  SearchState copyWith({
    SearchStatus? status,
      bool? canContinue,
      String? lastSearchTerm,
      bool? useExtract,
      int? offset,
      int? limit,
      String? language,
      List<Search>? results,
      Map<int, Article>? articles,
      List<Article>? history
  }) {
    return SearchState(
        status: status ?? this.status,
        canContinue: canContinue ?? this.canContinue,
        lastSearchTerm: lastSearchTerm ?? this.lastSearchTerm,
        useExtract: useExtract ?? this.useExtract,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
        language: language ?? this.language,
        results: results ?? this.results,
        articles: articles ?? this.articles,
        history: history ?? this.history
    );
  }

  @override
  List<Object?> get props => [status, canContinue, lastSearchTerm, useExtract, offset, limit, language, results, articles, history];

  bool isInitial() => (status == SearchStatus.initial);
  bool isStandby() => (status == SearchStatus.standby);
  bool isSearching() => (status == SearchStatus.searching);
  bool isContinuing() => (status == SearchStatus.continuing);

  Article getArticle(int pageID) => (articles.containsKey(pageID)) ? articles[pageID]! : Article();
}
