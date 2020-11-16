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

Map<String, dynamic> _$ProductEntityToJson(ProductEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'short_description': instance.shortDescription,
      'long_description': instance.longDescription,
      'price': instance.price,
      'stock': instance.stock,
      'thumbnail': instance.thumbnail,
      'discount': instance.discount,
      'category': instance.category,
    };
