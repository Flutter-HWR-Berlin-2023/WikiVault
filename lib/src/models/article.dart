import 'package:hive/hive.dart';

part 'article.g.dart';

/// Hive data model for Article with pageID, title, article, and description fields,
/// along with methods for JSON deserialization and copying with optional field updates (using Hive annotations for serialization)
@HiveType(typeId: 1)
class Article {
  @HiveField(0)
  int pageID;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String article;

  Article({
    this.pageID = 0,
    this.title = 'Error',
    this.description,
    this.article = 'Error - Content',
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        pageID: json['pageid'],
        title: json['title'],
        article: json['extract']
    );
  }

  Article copyWith({
    int? pageID,
    String? title,
    String? article,
    String? description
  }) {
    return Article(
      pageID: pageID ?? this.pageID,
      title: title ?? this.title,
      article: article ?? this.article,
      description: description ?? this.description
    );
  }
}