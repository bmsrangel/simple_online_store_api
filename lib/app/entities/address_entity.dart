import 'package:json_annotation/json_annotation.dart';

part 'address_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AddressEntity {
  AddressEntity({
    this.id,
    this.street,
    this.number,
    this.complement,
    this.zipCode,
    this.city,
    this.state,
    this.country,
  });
  final String id;
  final String street;
  final String number;
  final String complement;
  final String zipCode;
  final String city;
  final String state;
  final String country;

  factory AddressEntity.fromJson(Map<String, dynamic> json) =>
      _$AddressEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AddressEntityToJson(this);
}
