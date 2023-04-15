part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BookmarkInit extends BookmarkEvent {}

class AddBookmark extends BookmarkEvent {
  AddBookmark(this.article);
  final Article article;
}

class RemoveBookmark extends BookmarkEvent {
  RemoveBookmark(this.pageID);
  final int pageID;
}

class AddBookmarkGroup extends BookmarkEvent {
  AddBookmarkGroup(this.groupID);
  final int groupID;
}

class RemoveBookmarkGroup extends BookmarkEvent {
  RemoveBookmarkGroup(this.groupID, this.removeArticles);
  final int groupID;
  final bool removeArticles;
}