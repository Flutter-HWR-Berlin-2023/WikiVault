part of 'bookmark_bloc.dart';

enum BookmarkStatus { initial, loading, standby }

class BookmarkState extends Equatable {
  const BookmarkState({
    this.status = BookmarkStatus.initial,
    this.groupBox,
    this.group = const <int>[],
    this.articleBox,
    this.article = const <int>[]
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
    List<int>? article
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

  bool isInitial() {return status == BookmarkStatus.initial;}
  bool isLoading() {return status == BookmarkStatus.loading;}
  bool isStandby() {return status == BookmarkStatus.standby;}

  bool bookmarksEmpty() {
    return articleBox!.isEmpty;
  }

  List<ArticleGroup> getGroups() {
    return groupBox!.values.toList();
  }

  List<Article> getArticles() {
    return articleBox!.values.toList();
  }

  bool isBookmarked(int pageID) {
    return articleBox!.containsKey(pageID);
  }
}
