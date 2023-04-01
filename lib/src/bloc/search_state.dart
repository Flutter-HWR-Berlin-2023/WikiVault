part of 'search_bloc.dart';

enum SearchStatus { initial, standby, searching, continuing }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.language = 'de',
    this.canContinue = false,
    this.lastSearchTerm = '',
    this.limit = 10,
    this.offset = 0,
    this.results = const <Search>[],
    this.articles = const <int, Article>{}
  });

  final SearchStatus status;
  final String language;
  final bool canContinue;
  final String lastSearchTerm;
  final int limit;
  final int offset;
  final List<Search> results;
  final Map<int, Article> articles;

  SearchState copyWith({
    SearchStatus? status,
      String? language,
      bool? canContinue,
      String? lastSearchTerm,
      int? limit,
      int? offset,
      List<Search>? results,
      Map<int, Article>? articles
  }) {
    return SearchState(
        status: status ?? this.status,
        language: language ?? this.language,
        canContinue: canContinue ?? this.canContinue,
        lastSearchTerm: lastSearchTerm ?? this.lastSearchTerm,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        results: results ?? this.results,
        articles: articles ?? this.articles
    );
  }

  SearchState newSearch(bool canContinue, String lastSearchTerm, int offset, List<Search> newResults, Map<int, Article> newArticles) {
    return SearchState(
        status: SearchStatus.standby,
        language: language,
        canContinue: canContinue,
        lastSearchTerm: lastSearchTerm,
        limit: limit,
        offset: offset,
        results: newResults,
        articles: newArticles
        );
  }

  SearchState continueSearch(bool canContinue, int offset, List<Search> newResults, Map<int, Article> newArticles) {
    return SearchState(
        status: SearchStatus.standby,
        language: language,
        canContinue: canContinue,
        lastSearchTerm: lastSearchTerm,
        limit: limit,
        offset: offset,
        results: results..addAll(newResults),
        articles: articles..addAll(newArticles)
    );
  }

  @override
  List<Object?> get props => [status, language, canContinue, lastSearchTerm, limit, offset, results, articles];

  bool isInitial() => (status == SearchStatus.initial);
  bool isStandby() => (status == SearchStatus.standby);
  bool isSearching() => (status == SearchStatus.searching);
  bool isContinuing() => (status == SearchStatus.continuing);

  Article getArticle(int pageID) {
    if (articles[pageID] != null) return articles[pageID]!;
    return Article();
  }
}
