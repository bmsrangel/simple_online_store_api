import 'package:simple_online_store_api/app/entities/product_entity.dart';

abstract class IProductsService {
  Future<List<ProductEntity>> getAllProducts();
}
