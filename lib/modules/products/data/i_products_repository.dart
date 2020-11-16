import 'package:simple_online_store_api/app/entities/product_entity.dart';

abstract class IProductsRepository {
  Future<List<ProductEntity>> getAllProducts();
}
