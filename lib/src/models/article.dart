import 'package:hive/hive.dart';

part 'article.g.dart';

@HiveType(typeId: 1)
class Article {
  @HiveField(0)
  int pageID;

  @HiveField(1)
  int group;

  @HiveField(2)
  String title;

  @HiveField(3)
  String article;

  @HiveField(4)
  String? description;

  Article({
    this.pageID = 0,
    this.group = 0,
    this.title = 'Error',
    this.article = 'Error - Content',
    this.description
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        pageID: json['pageid'],
        title: json['title'],
        article: json['extract'],
        description: json['description'] != null ? json['description'][0] : null
    );
  }

  Article copyWith({
    int? pageID,
    int? group,
    String? title,
    String? article,
    String? description
  }) {
    return Article(
      pageID: pageID ?? this.pageID,
      group: group ?? this.group,
      title: title ?? this.title,
      article: article ?? this.article,
      description: description ?? this.description
    );
  }
}