import 'package:hive/hive.dart';

part 'article_group.g.dart';

// Hive data model for ArticleGroup with groupID, name, and (optional) description fields
@HiveType(typeId: 2)
class ArticleGroup {
  @HiveField(0)
  int groupID; // Primary key

  @HiveField(1)
  String name; // Primary key

  @HiveField(2)
  String? description;

  ArticleGroup({
    required this.groupID,
    required this.name,
    this.description
  });

  ArticleGroup copyWith({
    int? groupID,
    String? name,
    String? description
  }) {
    return ArticleGroup(
        groupID: groupID ?? this.groupID,
        name: name ?? this.name,
        description: description ?? this.description
    );
  }
}