part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Initialization of bookmarking functionality
class BookmarkInit extends BookmarkEvent {}

// Addition of a bookmark for a specific article
class AddBookmark extends BookmarkEvent {
  AddBookmark(this.article);
  final Article article;
}

// Removal of a bookmark for a specific page ID
class RemoveBookmark extends BookmarkEvent {
  RemoveBookmark(this.pageID);
  final int pageID;
}

// Addition of a bookmark group with a specific group ID
class AddBookmarkGroup extends BookmarkEvent {
  AddBookmarkGroup(this.groupID);
  final int groupID;
}

// Removal of a bookmark group with a specific group ID and the option to remove associated articles
class RemoveBookmarkGroup extends BookmarkEvent {
  RemoveBookmarkGroup(this.groupID, this.removeArticles);
  final int groupID;
  final bool removeArticles;
}