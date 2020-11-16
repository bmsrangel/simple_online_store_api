import 'package:json_annotation/json_annotation.dart';
import 'package:simple_online_store_api/app/entities/category_entity.dart';

part 'product_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductEntity {
  ProductEntity(this.id, this.name, this.shortDescription, this.longDescription,
      this.price, this.stock, this.thumbnail, this.discount, this.category);

  final String id;
  final String name;
  final String shortDescription;
  final String longDescription;
  final double price;
  final int stock;
  final String thumbnail;
  final int discount;
  final CategoryEntity category;

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);
}
