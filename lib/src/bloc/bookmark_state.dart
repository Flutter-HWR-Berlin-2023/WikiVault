part of 'bookmark_bloc.dart';

enum BookmarkStatus { initial, loading, standby }

/// Defines the BookmarkState class with its properties and methods for managing bookmarks
class BookmarkState extends Equatable {
  const BookmarkState({
    this.status = BookmarkStatus.initial,
    this.articleBox,
    this.article = const [],
  });

  final BookmarkStatus status;
  final Box<Article>? articleBox;
  final List<int> article;

  BookmarkState copyWith({
    BookmarkStatus? status,
    Box<Article>? articleBox,
    List<int>? article,
  }) {
    return BookmarkState(
      status: status ?? this.status,
      articleBox: articleBox ?? this.articleBox,
      article: article ?? this.article,
    );
  }

  @override
  List<Object?> get props => [status, articleBox, article];

  bool isBookmarksEmpty() => articleBox!.isEmpty;
  List<Article> getArticles() => articleBox!.values.toList();
  bool isBookmarked(int pageID) => articleBox!.containsKey(pageID);
}
