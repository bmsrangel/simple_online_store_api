import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserEntity {
  UserEntity({
    this.id,
    this.name,
    this.email,
    this.birthDate,
  });

  final String id;
  final String name;
  final String email;
  final String birthDate;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
