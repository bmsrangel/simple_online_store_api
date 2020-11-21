// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressEntity _$AddressEntityFromJson(Map<String, dynamic> json) {
  return AddressEntity(
    id: json['id'] as String,
    street: json['street'] as String,
    number: json['number'] as String,
    complement: json['complement'] as String,
    zipCode: json['zip_code'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    country: json['country'] as String,
  );
}

Map<String, dynamic> _$AddressEntityToJson(AddressEntity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('street', instance.street);
  writeNotNull('number', instance.number);
  writeNotNull('complement', instance.complement);
  writeNotNull('zip_code', instance.zipCode);
  writeNotNull('city', instance.city);
  writeNotNull('state', instance.state);
  writeNotNull('country', instance.country);
  return val;
}
