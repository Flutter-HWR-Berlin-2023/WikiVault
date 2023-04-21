part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Search Event initialization (called on app start)
class SearchInit extends SearchEvent {}

// Settings of a search event
class SearchSettings extends SearchEvent {}

// Represents a search term event with a given search term string
class SearchTerm extends SearchEvent {
  SearchTerm(this.searchTerm);
  final String searchTerm;
}

// Represents a search continuation event (called when the user scrolls to the bottom of the search results)
class SearchContinue extends SearchEvent {}

// Represents a search article retrieval event with a given page ID integer
class SearchGetArticle extends SearchEvent {
  SearchGetArticle(this.pageID);
  final int pageID;
}

// Represents a search history addition event with a given article object (called when the user selects an article from search results)
class SearchAddHistory extends SearchEvent {
  SearchAddHistory(this.article);
  final Article article;
}

// Represents a search history removal event with a given page ID integer (called when the user removes an article from search history)
class SearchRemoveHistory extends SearchEvent {
  SearchRemoveHistory(this.pageID);
  final int pageID;
}