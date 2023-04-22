part of 'bookmark_bloc.dart';

enum BookmarkStatus { initial, loading, standby }

// Defines the BookmarkState class with its properties and methods for managing bookmarks
class BookmarkState extends Equatable {
  const BookmarkState({
    this.status = BookmarkStatus.initial,
    this.groupBox,
    this.group = const [],
    this.articleBox,
    this.article = const [],
  });

  final BookmarkStatus status;
  final Box<ArticleGroup>? groupBox;
  final List<int> group;
  final Box<Article>? articleBox;
  final List<int> article;

  BookmarkState copyWith({
    BookmarkStatus? status,
    Box<ArticleGroup>? groupBox,
    List<int>? group,
    Box<Article>? articleBox,
    List<int>? article,
  }) {
    return BookmarkState(
      status: status ?? this.status,
      groupBox: groupBox ?? this.groupBox,
      group: group ?? this.group,
      articleBox: articleBox ?? this.articleBox,
      article: article ?? this.article,
    );
  }

  @override
  List<Object?> get props => [status, groupBox, group, articleBox, article];

  bool isInitial() => status == BookmarkStatus.initial;
  bool isLoading() => status == BookmarkStatus.loading;
  bool isStandby() => status == BookmarkStatus.standby;

  bool bookmarksEmpty() => articleBox!.isEmpty;
  List<ArticleGroup> getGroups() => groupBox!.values.toList();
  List<Article> getArticles() => articleBox!.values.toList();
  bool isBookmarked(int pageID) => articleBox!.containsKey(pageID);
}
