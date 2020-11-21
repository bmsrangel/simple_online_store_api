// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTypeEntity _$PaymentTypeEntityFromJson(Map<String, dynamic> json) {
  return PaymentTypeEntity(
    id: json['id'] as int,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$PaymentTypeEntityToJson(PaymentTypeEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
