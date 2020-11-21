import 'package:json_annotation/json_annotation.dart';

part 'payment_type_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentTypeEntity {
  PaymentTypeEntity({
    this.id,
    this.type,
  });
  final int id;
  final String type;

  factory PaymentTypeEntity.fromJson(Map<String, dynamic> json) =>
      _$PaymentTypeEntityFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentTypeEntityToJson(this);
}
