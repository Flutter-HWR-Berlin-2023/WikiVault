part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInit extends SearchEvent {}

class SearchSettings extends SearchEvent {}

class SearchTerm extends SearchEvent {
  SearchTerm(this.searchTerm);
  final String searchTerm;
}

class SearchContinue extends SearchEvent {}

class SearchGetArticle extends SearchEvent {
  SearchGetArticle(this.pageID);
  final int pageID;
}

class SearchAddHistory extends SearchEvent {
  SearchAddHistory(this.article);
  final Article article;
}

class SearchRemoveHistory extends SearchEvent {
  SearchRemoveHistory(this.pageID);
  final int pageID;
}