part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Initialization of bookmarking functionality
class BookmarkInit extends BookmarkEvent {}

/// Addition of a bookmark for a specific article
class AddBookmark extends BookmarkEvent {
  AddBookmark(this.context, this.article);
  final BuildContext context;
  final Article article;
}

/// Removal of a bookmark for a specific page ID
class RemoveBookmark extends BookmarkEvent {
  RemoveBookmark(this.context, this.article);
  final BuildContext context;
  final Article article;
}