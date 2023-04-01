part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInit extends SearchEvent {}

class SearchTerm extends SearchEvent {
  SearchTerm(this.searchTerm);
  final String searchTerm;
}

class SearchContinue extends SearchEvent {}