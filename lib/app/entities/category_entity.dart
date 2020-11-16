import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {
  CategoryEntity(this.id, this.name);

  final String id;
  final String name;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);
}
