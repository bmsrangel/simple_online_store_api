// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) {
  return ProductEntity(
    json['id'] as String,
    json['name'] as String,
    json['short_description'] as String,
    json['long_description'] as String,
    (json['price'] as num)?.toDouble(),
    json['stock'] as int,
    json['thumbnail'] as String,
    json['discount'] as int,
    json['category'] == null
        ? null
        : CategoryEntity.fromJson(json['category'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductEntityToJson(ProductEntity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('short_description', instance.shortDescription);
  writeNotNull('long_description', instance.longDescription);
  writeNotNull('price', instance.price);
  writeNotNull('stock', instance.stock);
  writeNotNull('thumbnail', instance.thumbnail);
  writeNotNull('discount', instance.discount);
  writeNotNull('category', instance.category);
  return val;
}
