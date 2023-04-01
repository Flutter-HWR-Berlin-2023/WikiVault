// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleGroupAdapter extends TypeAdapter<ArticleGroup> {
  @override
  final int typeId = 2;

  @override
  ArticleGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleGroup(
      groupID: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleGroup obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.groupID)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
