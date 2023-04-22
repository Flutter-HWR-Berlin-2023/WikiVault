part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Initialization of bookmarking functionality
class BookmarkInit extends BookmarkEvent {}

// Addition of a bookmark for a specific article
class AddBookmark extends BookmarkEvent {
  AddBookmark(this.context, this.article);
  final BuildContext context;
  final Article article;
}

// Removal of a bookmark for a specific page ID
class RemoveBookmark extends BookmarkEvent {
  RemoveBookmark(this.context, this.article);
  final BuildContext context;
  final Article article;
}

// Addition of a bookmark group with a specific group ID
class AddBookmarkGroup extends BookmarkEvent {
  AddBookmarkGroup(this.context, this.articleGroup);
  final BuildContext context;
  final ArticleGroup articleGroup;
}

// Removal of a bookmark group with a specific group ID and the option to remove associated articles
class RemoveBookmarkGroup extends BookmarkEvent {
  RemoveBookmarkGroup(this.context, this.articleGroup, this.removeArticles);
  final BuildContext context;
  final ArticleGroup articleGroup;
  final bool removeArticles;
}