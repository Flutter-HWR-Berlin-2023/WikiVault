import 'package:hive/hive.dart';

part 'article_group.g.dart';

@HiveType(typeId: 2)
class ArticleGroup {
  @HiveField(0)
  int groupID;

  @HiveField(1)
  String name;

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