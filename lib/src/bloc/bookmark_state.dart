part of 'bookmark_bloc.dart';

enum BookmarkStatus { initial, loading, standby }

class BookmarkState extends Equatable {
  const BookmarkState({
    this.status = BookmarkStatus.initial,
    this.groupBox,
    this.articleBox
  });

  final BookmarkStatus status;
  final Box<ArticleGroup>? groupBox;
  final Box<Article>? articleBox;

  BookmarkState copyWith({
    BookmarkStatus? status,
    Box<ArticleGroup>? groupBox,
    Box<Article>? articleBox
  }) {
    return BookmarkState(
      status: status ?? this.status,
      groupBox: groupBox ?? this.groupBox,
      articleBox: articleBox ?? this.articleBox
    );
  }

  @override
  List<Object?> get props => [status, groupBox, articleBox];

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
}
